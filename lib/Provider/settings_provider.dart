import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingsProvider extends ChangeNotifier {
  File? _imageFile;
  final picker = ImagePicker();

  File? get imageFile => _imageFile;

  Future<void> chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    notifyListeners(); // Notify listeners to update the UI
  }
}
