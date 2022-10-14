import 'dart:io';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:google_ml_vision/google_ml_vision.dart';



// TODO

//1. Compress the image
//2. Binary the image
class FirebaseMLApi {
  static Future<String> recogniseText(File imageFile, String imagePath) async{
    if (imagePath == ""){
      return "No image";
    }

    final size = ImageSizeGetter.getSize(FileInput(imageFile));
    if (size.needRotate) {
      final width = size.height;
      final height = size.width;
      print('width = $width, height = $height');
    } else {
      print('width = ${size.width}, height = ${size.height}');
    }


    final visionImage = GoogleVisionImage.fromFile(imageFile);
    final textRecognizer = GoogleVision.instance.textRecognizer();

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
          text += "${element.text!} ";
        }
      }
      text += "\n";
    }
    return text;
  }

}