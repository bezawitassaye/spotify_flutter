import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:spotify/core/error/failures.dart';

abstract interface class BlogRepository {
  Future<Either<Failures,String>> uploadBlogImage({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });
}