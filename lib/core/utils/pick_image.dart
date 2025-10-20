import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickimage() async{
  try{
    final xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery);
      

    if(xFile != null){
      return File(xFile.path);
    }  

  }catch(e){
    return null;
  }
}