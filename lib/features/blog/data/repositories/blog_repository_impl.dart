import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:spotify/core/error/exceptions.dart';
import 'package:spotify/core/error/failures.dart';
import 'package:spotify/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:spotify/features/blog/data/models/blog_model.dart';
import 'package:spotify/features/blog/domain/repositories/blog_repository.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl({required this.blogRemoteDataSource});

  @override
  Future<Either<Failures, String>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      // Create blog model
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: "",
        topics: topics,
        updatedAt: DateTime.now(),
      );

      // Upload image to Supabase
      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      // Update model with image URL
      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      // Upload full blog data
      await blogRemoteDataSource.uploadBlog(blogModel);

      return right(blogModel.id);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }
}
