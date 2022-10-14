import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ocr_translation/widget/text_area_widget.dart';
import 'package:image_picker/image_picker.dart';

import '../api/firebase_ml_api.dart';
import 'controls_widget.dart';

class TextRecognitionWidget extends StatefulWidget {
  const TextRecognitionWidget({
    required Key key,
  }) : super(key: key);

  @override
  _TextRecognitionWidgetState createState() => _TextRecognitionWidgetState();
}

class _TextRecognitionWidgetState extends State<TextRecognitionWidget> {
  String text = '';
  late File image;
  String imagePath = '';

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Expanded(child: buildImage()),
        const SizedBox(height: 16),
        ControlsWidget(
          onClickedPickImage: pickImage,
          onClickedScanText: scanText,
          onClickedClear: clear,
          key: const ObjectKey("pickImage"),
        ),
        const SizedBox(height: 16),
        TextAreaWidget(
          text: text,
          onClickedCopy: copyToClipboard, key: const ObjectKey("textArea"),
        ),
      ],
    ),
  );

  Widget buildImage() => Container(
    child: imagePath != ""
        ? Image.file(image)
        : Icon(Icons.photo, size: 80, color: Colors.black),
  );

  Future pickImage() async {

    XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    imagePath = pickedImage!.path;
    image = File(imagePath);

    // final file = await ImagePicker().getImage(source: ImageSource.gallery);
    setImage(image);
  }

  Future scanText() async {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );

    final text = await FirebaseMLApi.recogniseText(image, imagePath);
    setText(text);

    Navigator.of(context).pop();
  }

  void clear() {
    // setImage(null);
    setText('');
  }

  void copyToClipboard() {
    if (text.trim() != '') {
      FlutterClipboard.copy(text);
    }
  }

  void setImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }

  void setText(String newText) {
    setState(() {
      text = newText;
    });
  }
}
