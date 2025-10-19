import 'package:spotify/features/blog/data/models/blog_model.dart';

abstract class BlogRemoteDataSource{
  Future<BlogModel> uploadBlog(BlogModel blogModel);
}