part of 'blog_bloc_bloc.dart';

@immutable
sealed class BlogBlocState {}

final class BlogBlocInitial extends BlogBlocState {}

final class BlogBlocLoading extends BlogBlocState {}

final class BlogBlocFailure extends BlogBlocState {
  final String error;
  BlogBlocFailure(this.error);
}

final class BlogBlocUploadSuccess extends BlogBlocState {
 
}

final class BlogDisplaySuccess extends BlogBlocState {
  final List<Blog> blogs;
  BlogDisplaySuccess(this.blogs);
}

