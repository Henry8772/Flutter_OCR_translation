import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String result = '';
  File? image;
  ImagePicker? imagePicker;

  pickImageFromGallery() async{
    PickedFile pickedFile = (await imagePicker!.pickImage(source: ImageSource.gallery)) as PickedFile;
    image = File(pickedFile.path);
    setState(() {
      image;
    });


  }

  pickImageFromCamera() async{
    PickedFile pickedFile = (await imagePicker!.pickImage(source: ImageSource.camera)) as PickedFile;
    image = File(pickedFile.path);
    setState(() {
      image;
    });

  }

  performImageLabelling() async{
    final FirebaseVisionImage firebaseVisionImage = FirebaseVisionImage.fromFile(image);
    final TextRecognizer recognizer = FirebaseVision.instance.textRecognizer();

    VisionText visionText = await recognizer.processImage(firebaseVisionImage);

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
