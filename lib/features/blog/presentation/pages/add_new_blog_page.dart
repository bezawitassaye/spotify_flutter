import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:spotify/core/theme/app_pallete.dart';

class NewBlog extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const NewBlog());
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.done_rounded)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DottedBorder(
              options: RectDottedBorderOptions(
                dashPattern: [10, 4],
                color: AppPallete.borderColor,
                strokeWidth: 2,
                padding: EdgeInsets.all(16),
              ),
              child: Container(
                height: 150,
                width: double.infinity,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.folder_open, size: 40),
                    SizedBox(height: 15),
                    Text('Select your image', style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
