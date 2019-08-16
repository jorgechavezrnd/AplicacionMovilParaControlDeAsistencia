import 'package:aplicacion_taller/presentation/ucb/controller/ucb_controller.dart';
import 'package:aplicacion_taller/domain/entities/authentication.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

class UCBTakePictureView extends StatefulWidget {
  @override
  _UCBTakePictureViewState createState() => _UCBTakePictureViewState();
}

class _UCBTakePictureViewState extends State<UCBTakePictureView> {
  List<File> _imageList;
  BuildContext _context;

  @override
  void initState() {
    super.initState();
    this._imageList = new List<File>();
  }

  void _takePicture(String source) async {
    ImageSource imageSource;

    if (source == 'camera') {
      imageSource = ImageSource.camera;
    } else {
      imageSource = ImageSource.gallery;
    }

    File img = await ImagePicker.pickImage(source: imageSource);

    if (img != null) {
      setState(() {
        this._imageList.add(img);
      });
    }
  }

  void _startRegisterAssistanceUseCase() async {
    print('START REGISTER ASSISTANCE USE CASE');

    Authentication authentication = Authentication();
    UCBController controller = UCBController();
    controller.context = this._context;
    String subjectID = authentication.subject.id;
    String parallelID = authentication.subject.parallel;
    List<int> imageBytes = this._imageList[0].readAsBytesSync();
    String imageBase64 = base64Encode(imageBytes);

    await controller.showAttendanceControlListUseCase(subjectID, parallelID, imageBase64);
  }

  void _imageOptionsDialog(File image) {
    AlertDialog alert = new AlertDialog(
      title: Center(
        child: Text('IMAGEN'),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Image.file(image),
            Padding(
              padding: EdgeInsets.only(top: 12.0),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: FlatButton(
            child: Text('ELIMINAR'),
            onPressed: () {
              Navigator.of(this._context).pop();
              setState(() {
                this._imageList.remove(image);
              });
            },
          ),
        ),
        Center(
          child: FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(this._context).pop();
            },
          ),
        )
      ],
    );

    showDialog(context: this._context, builder: (_) => alert);
  }

  Widget _buildImageItem(File image) {
    return Material(
      elevation: 15.0,
      child: InkWell(
        onTap: () {
          print('IMAGE: $image');
          _imageOptionsDialog(image);
        },
        child: Image.file(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCarouselSlider() {
    return Container(
      height: 258.0,
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
      ),
      child: Column(
        children: <Widget>[
          Flexible(
              child: ListView(
            scrollDirection: Axis.horizontal,
            children: this
                ._imageList
                .map((imageItem) => Padding(
                      padding: EdgeInsets.only(left: 6.0, right: 2.0),
                      child: _buildImageItem(imageItem),
                    ))
                .toList(),
          )),
        ],
      ),
    );
  }

  Widget _buildImageList() {
    return Container(
      child: Center(
        child: this._imageList.length == 0
            ? Text('Imagen no seleccionada')
            : _buildCarouselSlider(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Escoger Image'),
        ),
      ),
      body: _buildImageList(),
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 1,
              onPressed: () => _takePicture('camera'),
              child: Icon(Icons.camera_alt),
            ),
            FloatingActionButton(
              heroTag: 2,
              onPressed: () => this._imageList.length == 0
                  ? null
                  : _startRegisterAssistanceUseCase(),
              child: Icon(Icons.send),
              backgroundColor: this._imageList.length == 0 ? Colors.grey : null,
            ),
            FloatingActionButton(
              heroTag: 3,
              onPressed: () => _takePicture('gallery'),
              child: Icon(Icons.image),
            )
          ],
        ),
      ),
    );
  }
}
