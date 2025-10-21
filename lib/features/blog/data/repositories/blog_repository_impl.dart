import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:spotify/core/error/exceptions.dart';
import 'package:spotify/core/error/failures.dart';
import 'package:spotify/core/network/conncetion_checker.dart';
import 'package:spotify/features/blog/data/datasources/blog_local_datasources.dart';
import 'package:spotify/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:spotify/features/blog/data/models/blog_model.dart';
import 'package:spotify/features/blog/domain/entities/blog.dart';
import 'package:spotify/features/blog/domain/repositories/blog_repository.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final ConnectionChecker connectionChecker;
  final BlogLocalDataSource blogLocalDataSource;

  BlogRepositoryImpl(this.blogRemoteDataSource, this.connectionChecker, this.blogLocalDataSource);

  @override
  Future<Either<Failures, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if(!await (connectionChecker.isConnected)) {
        return left(Failures("No Internet Connection"));
      }
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

      blogModel = blogModel.copyWith(
        imageUrl: imageUrl
      );



      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }
  
  @override
  Future<Either<Failures, List<Blog>>> getAllBlogs() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final blogs = blogLocalDataSource.loadBlogs();
        return right(blogs);
      }
      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadLocalBlogs(blogs: blogs);
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }
}
