import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class FirebaseMLApi {
  static Future<String> recogniseText(File imageFile) async{
    if (imageFile == null){
      return "No image";
    }

    final visionImage = FirebaseVisionImage.fromFile(imageFile);
    final textRecognizer = FirebaseVision.instance.textRecognizer();

    try {
      final visionText = await textRecognizer.processImage(visionImage);
      await textRecognizer.close();

      final text = extractText(visionText);

      return text.isEmpty ? "No text found" : text;
    } catch (e) {
      return e.toString();
    }

  }

  static extractText(VisionText visionText) {
    String text = '';
    for(TextBlock block in visionText.blocks){

      for(TextLine line in block.lines){
        for(TextElement element in line.elements){
          text += element.text + " ";
        }
      }
      text += "\n";
    }
    return text;
  }

}