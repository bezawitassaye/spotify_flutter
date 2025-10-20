part of 'blog_bloc_bloc.dart';

@immutable
sealed class BlogBlocState {}

final class BlogInitial extends BlogBlocState {}

final class BlogLoading extends BlogBlocState {}

final class BlogFailure extends BlogBlocState {
  final String error;
  BlogFailure(this.error);
}

final class BlogUploadSuccess extends BlogBlocState {}

final class BlogsDisplaySuccess extends BlogBlocState {
  final List<Blog> blogs;
  BlogsDisplaySuccess(this.blogs);
}
