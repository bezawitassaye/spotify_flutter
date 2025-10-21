import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/features/blog/domain/entities/blog.dart';
import 'package:spotify/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:spotify/features/blog/domain/usecases/upload_blog.dart';
part 'blog_bloc_event.dart';
part 'blog_bloc_state.dart';

class BlogBlocBloc extends Bloc<BlogBlocEvent, BlogBlocState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBlocBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
      : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogBlocInitial()) {
    on<BlogBlocEvent>((event, emit) {
      emit(BlogBlocLoading());
    });

    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onBlogFetchAllBlogs);


  }


  void _onBlogFetchAllBlogs(
    BlogFetchAllBlogs event,
    Emitter<BlogBlocState> emit,
  ) async{
    final res = await _getAllBlogs(NoParams());

    res.fold(
      (l) => emit(BlogBlocFailure(l.message)),
      (r) => emit(
        BlogDisplaySuccess( r),
      )
    );
  }


  void _onBlogUpload(
    BlogUpload event,
    Emitter<BlogBlocState> emit,
  ) async{
  final res = await _uploadBlog(
    UploadBlogParams(posterId: event.posterId, title: event.title, content: event.content, image: event.image, topics: event.topics)
   );

   res.fold(
    (l) => emit(BlogBlocFailure(l.message)),
    (r) => emit(
      BlogBlocUploadSuccess(),
    )
   );
  }
}
