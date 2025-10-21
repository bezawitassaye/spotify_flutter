import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    );
  }
}