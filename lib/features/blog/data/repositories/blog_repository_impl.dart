import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:spotify/core/error/exceptions.dart';
import 'package:spotify/core/error/failures.dart';
import 'package:spotify/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:spotify/features/blog/data/models/blog_model.dart';
import 'package:spotify/features/blog/domain/repositories/blog_repository.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource remoteDataSource;
  BlogRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failures, String>> uploadBlogImage({required File image, required String title, required String content, required String posterId, required List<String> topics}) async {
   try{
       BlogModel blogModel = BlogModel(
    id: const Uuid().v1(), posterId: posterId, title: title, content: content, imageUrl: "", topics: topics, updatedAt: DateTime.now());
    
    final imageUrl = await BlogRemoteDataSource.uploadBlogImage(
      image: image,
      blog: blogModel
    );
   } on ServerException catch(e){
    return left(Failures(e.message));
   }
  }
}