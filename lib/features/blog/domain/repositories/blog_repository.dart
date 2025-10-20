import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:spotify/core/error/failures.dart';
import 'package:spotify/features/blog/domain/entities/blog.dart';

abstract interface class BlogRepository {
  Future<Either<Failures,Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });
  Future<Either<Failures, List<Blog>>> getAllBlogs();
}