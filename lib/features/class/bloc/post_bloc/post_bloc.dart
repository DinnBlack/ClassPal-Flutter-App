import 'package:bloc/bloc.dart';
import 'package:flutter_class_pal/core/state/app_state.dart';
import 'package:meta/meta.dart';

import '../../data/class_firebase.dart';
import '../../model/post_model.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final ClassFirebase _classFirebase;

  PostBloc(this._classFirebase) : super(PostInitial()) {
    on<PostCreateStarted>(_onPostCreateStarted);
    on<PostResetStarted>(_onPostResetStarted);
    on<PostFetchStarted>(_onPostFetchStarted);
  }

  Future<void> _onPostResetStarted(
      PostResetStarted event, Emitter<PostState> emit) async {
    emit(PostInitial());
  }

  Future<void> _onPostCreateStarted(
      PostCreateStarted event, Emitter<PostState> emit) async {
    emit(PostCreateInProgress());

    try {
      PostModel newPost = event.newPost;
      String postId = await _classFirebase.createPost(
          AppState.getClass()!.classId, newPost);

      if (postId.isNotEmpty) {
        emit(PostCreateSuccess());
      } else {
        emit(PostCreateFailure());
      }
    } catch (e) {
      print('Error creating post: $e');
      emit(PostCreateFailure());
    }
  }

  Future<void> _onPostFetchStarted(PostFetchStarted event, Emitter<PostState> emit) async {
    emit(PostFetchInProgress());

    try {
      List<PostModel> posts = await _classFirebase.fetchPosts(AppState.getClass()!.classId);
      emit(PostFetchSuccess(posts));
    } catch (e) {
      print('Error fetching posts: $e');
      emit(PostFetchFailure());
    }
  }
}
