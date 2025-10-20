import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:spotify/core/common/widgets/loader.dart';
import 'package:spotify/core/theme/app_pallete.dart';
import 'package:spotify/core/utils/pick_image.dart';
import 'package:spotify/core/utils/show_snackbar.dart';
import 'package:spotify/features/blog/presentation/bloc/blog_bloc_bloc.dart';
import 'package:spotify/features/blog/presentation/pages/blog_page.dart';
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
  final formkey = GlobalKey<FormState>();
  List<String> selectedTopics = [];
  File? image;
  void selectImage() async {
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
          IconButton(
            onPressed: () {
              if (formkey.currentState!.validate() &&
                  selectedTopics.isNotEmpty &&
                  image != null) {
                final posterId =
                    (context.read<AppUserCubit>().state as AppUserLoggedIn)
                        .user
                        .id;
                context.read<BlogBlocBloc>().add(
                  BlogUpload(
                    posterId: posterId,
                    title: titleController.text.trim(),
                    content: contentController.text.trim(),
                    image: image!,
                    topics: selectedTopics,
                  ),
                );
              }
            },
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: BlocConsumer<BlogBlocBloc, BlogBlocState>(
        listener: (context, state) {
          if(state is BlogBlocFailure){
            showSnackBar(context, state.error);
          } else if(state is BlogBlocUploadSuccess){
            Navigator.pushAndRemoveUntil(
              context, BlogPage.route(), (route) => false);
          }
        },
        builder: (context, state) {
          if(state is BlogBlocFailure){
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(image!, fit: BoxFit.cover),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
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
                                    Text(
                                      'Select your image',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            [
                                  "Technology",
                                  "Business",
                                  "Programing",
                                  "Entertainment",
                                ]
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (selectedTopics.contains(e)) {
                                          selectedTopics.remove(e);
                                        } else {
                                          selectedTopics.add(e);
                                        }

                                        setState(() {});
                                      },
                                      child: Chip(
                                        label: Text(e),
                                        color: selectedTopics.contains(e)
                                            ? const MaterialStatePropertyAll(
                                                AppPallete.gradient2,
                                              )
                                            : null,
                                        side: selectedTopics.contains(e)
                                            ? null
                                            : const BorderSide(
                                                color: AppPallete.borderColor,
                                              ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    BlogEditor(
                      controller: titleController,
                      hintText: "Blog Title",
                    ),
                    const SizedBox(height: 10),
                    BlogEditor(
                      controller: contentController,
                      hintText: "Blog Content",
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
