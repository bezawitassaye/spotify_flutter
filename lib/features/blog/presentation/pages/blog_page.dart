import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/common/widgets/loader.dart';
import 'package:spotify/core/utils/show_snackbar.dart';
import 'package:spotify/features/blog/presentation/bloc/blog_bloc_bloc.dart';
import 'package:spotify/features/blog/presentation/pages/add_new_blog_page.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState(){
    super.initState();
    context.read<BlogBlocBloc>().add(BlogFetchAllBlogs());
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, NewBlog.route());
            }, 
            icon: const Icon(
              CupertinoIcons.add_circled
            ))
        ],
      ),
      body: BlocConsumer<BlogBlocBloc, BlogBlocState>(
        listener: (context, state) {
         if(state is BlogBlocFailure){
          showSnackBar(context, state.error);
         }
        },
        builder: (context, state) {
          if(state is BlogBlocLoading){
            return const Loader();
          }
          if(state is BlogDisplaySuccess){
             return ListView.builder(
              itemCount: state.blogs.length ,
              itemBuilder: (context,index){
                final blog = state.blogs[index];
                return Text(blog.title);
              }
              );

          }
          return const SizedBox();
         
        },
      ),
    );
  }
}