import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:spotify/core/theme/app_pallete.dart';
import 'package:spotify/core/utils/pick_image.dart';
import 'package:spotify/features/blog/presentation/widgets/blog_editor.dart';

class NewBlog extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const NewBlog());
  const NewBlog({super.key});

  @override
  State<NewBlog> createState() => _NewBlogState();
}

class _NewBlogState extends State<NewBlog> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics=[];
  File? image;
  void selectImage() async{
    final pickedImage = await pickimage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }
  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.done_rounded)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  selectImage();
                },
                child: DottedBorder(
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
              ),
              const SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  "Technology",
                  "Business",
                  "Programing",
                  "Entertainment",
                ].map((e)=>Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: (){
                      if (selectedTopics.contains(e)){
                        selectedTopics.remove(e);
                      } else{
                        selectedTopics.add(e);
                      }
                      
                      setState(() {
                        
                      });
                    },
                    child: Chip(
                      label: Text(e),
                      color: selectedTopics.contains(e)?
                      const MaterialStatePropertyAll(
                        AppPallete.gradient2
                      ): null,
                      side: selectedTopics.contains(e)?
                      null:
                       const BorderSide(
                        color: AppPallete.borderColor
                      ),
                    ),
                  ),
                ),).toList(),
                
                ),
              ),
              const SizedBox(height: 10,),
              BlogEditor(
                controller: titleController, hintText: "Blog Title"),
              const SizedBox(height: 10,),
              BlogEditor(
                controller: contentController, hintText: "Blog Content"),
            ],
          ),
        ),
      ),
    );
  }
}
