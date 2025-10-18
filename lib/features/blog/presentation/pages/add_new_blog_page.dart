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
              dashPattern: const [10, 4],
              color: AppPallete.borderColor,
              radius: const Radius.circular(10),
              borderType: BorderType.RRect,
              strokeCap: StrokeCap.round,  
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                "Technology",
                "Business",
                "Programing",
                "Entertainment",
              ].map((e)=>Chip(label: Text(e),),).toList(),
              
              ),
            )
          ],
        ),
      ),
    );
  }
}
