import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class NewBlog extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context)=> const NewBlog());
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
      body: Column(
        children: [
          DottedBorder(child: Container(
            height: 150,
            width: double.infinity,
            child: Column(
              children: [
                Icon(
                  Icons.folder_open,
                  size: 40,
                ),
                SizedBox(height: 15,),
                Text('Select your image',
                style: TextStyle(fontSize: 15),)
              ],
            ),

          ))
        ],
      ),
    );
  }
}