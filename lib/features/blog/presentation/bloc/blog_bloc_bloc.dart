import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotify/features/blog/domain/entities/blog.dart';

part 'blog_bloc_event.dart';
part 'blog_bloc_state.dart';

class BlogBlocBloc extends Bloc<BlogBlocEvent, BlogBlocState> {
  BlogBlocBloc() : super(BlogBlocInitial()) {
    on<BlogBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
