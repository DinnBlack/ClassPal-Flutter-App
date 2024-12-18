part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

class PostResetStarted extends PostEvent {}

class PostCreateStarted extends PostEvent {
  final PostModel newPost;

  PostCreateStarted({required this.newPost});
}

class PostFetchStarted extends PostEvent {}
