part of 'post_bloc.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

class PostCreateInProgress extends PostState  {}

class PostCreateSuccess extends PostState {}

class PostCreateFailure extends PostState {}

class PostFetchInProgress extends PostState {}

class PostFetchSuccess extends PostState {
  final List<PostModel> posts;

  PostFetchSuccess(this.posts);
}

class PostFetchFailure extends PostState {}
