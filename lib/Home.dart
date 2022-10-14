// import 'dart:io';
//
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   String result = '';
//   File? image;
//   ImagePicker? imagePicker;
//
//
//   }
//
//   performImageLabelling() async{
//     final FirebaseVisionImage firebaseVisionImage = FirebaseVisionImage.fromFile(image);
//     final TextRecognizer recognizer = FirebaseVision.instance.textRecognizer();
//
//     VisionText visionText = await recognizer.processImage(firebaseVisionImage);
//
//     result = '';
//
//     setState(() {
//       for(TextBlock block in visionText.blocks){
//         final String txt = block.text;
//
//         for(TextLine line in block.lines){
//           for(TextElement element in line.elements){
//             result += element.text + " ";
//           }
//         }
//         result += "\n\n";
//       }
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Center(
//           child: Text("11"),
//         ),
//       )
//     );
//   }
// }
