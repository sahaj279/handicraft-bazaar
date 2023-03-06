
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<List<Uint8List>> pickImages()async{
  print("#2");
  List<Uint8List> images=[];
  try {
    FilePickerResult? files=await FilePicker.platform.pickFiles(
      type: FileType.image, 
      allowMultiple: true,
      withData:true,
    );
    print("#3");
    print(files);

    if(files!=null && files.files.isNotEmpty){
      print("#4");
      for(int i=0;i<files.files.length;i++){
        images.add((files.files[i].bytes! ));
      }
    }
  } catch (e) {
    print("#5");
    debugPrint(e.toString());
  }
  return images;
}