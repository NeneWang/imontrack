import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  // File _image;

  final picker = ImagePicker();
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
    );

    if (imageFile == null) {
      return;
    }

    setState(() {
      if (imageFile != null) {
        _storedImage = File(imageFile.path);
      } else {
        print("No Image Selected");
      }
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);

    // imageFile.copy(newPath); //copy non existent
  }

  Future<void> _takePictureFromGallery() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (imageFile == null) {
      return;
    }

    setState(() {
      if (imageFile != null) {
        _storedImage = File(imageFile.path);
      } else {
        print("No Image Selected");
      }
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);

    // imageFile.copy(newPath); //copy non existent
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 2.5,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text('No Image taken'),
          alignment: Alignment.center,
        ),
        Padding(padding: EdgeInsets.all(10)),
        SizedBox(
          width: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera_alt),
              label: Text('Take Pictures'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _takePicture,
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              label: Text('Choose Gallery'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _takePictureFromGallery,
            ),
          ],
        )
      ],
    );
  }
}
