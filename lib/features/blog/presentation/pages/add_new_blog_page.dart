import 'package:flutter/material.dart';

class NewBlog extends StatefulWidget {
  const NewBlog({super.key});

  @override
  State<NewBlog> createState() => _NewBlogState();
}

class _NewBlogState extends State<NewBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(
              Icons.done_rounded
            ))
        ],
      ),
    );
  }
}