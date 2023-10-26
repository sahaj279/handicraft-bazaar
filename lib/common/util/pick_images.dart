import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<List<Uint8List>> pickImages() async {
  List<Uint8List> images = [];
  try {
    FilePickerResult? files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      withData: true,
    );

    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add((files.files[i].bytes!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
