import 'package:spotify/core/error/exceptions.dart';
import 'package:spotify/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource{
  Future<BlogModel> uploadBlog(BlogModel blog);
}

class BlogRemoteDataSourceImplementation implements BlogRemoteDataSource{
 final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImplementation({required this.supabaseClient});
 
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try{
      supabaseClient.from("blogs").insert({});

    }catch(e){
      throw ServerException(e.toString());
    }
    
  }

}