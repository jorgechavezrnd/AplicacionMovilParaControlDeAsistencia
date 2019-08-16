import 'package:aplicacion_taller/presentation/ucb/view/ucb_attendance_control_information_view.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:convert';

class ImagePage extends StatelessWidget {
  final String _imageBase64;
  final String _numberOfDoubtfulStudents;

  ImagePage(this._imageBase64, this._numberOfDoubtfulStudents);

  void _onPressedImage(BuildContext context) {
    Widget pictureScaffold = Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('IMAGEN'),
        ),
        elevation: 0.7,
      ),
      body: Container(
        child: PhotoView(
            imageProvider: MemoryImage(base64Decode(this._imageBase64))
        ),
      ),
    );

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => pictureScaffold));
  }

  void _onRegisterAssistanceButtonPressed(BuildContext context) {
    print('BOTON PARA REGISTRAR PRECIONADO');

    Widget formInformation = UCBAttendanceControlInformationView();

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => formInformation));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: InkWell(
                child: Image(
                  image: MemoryImage(base64Decode(this._imageBase64)),
                ),
                onTap: () { _onPressedImage(context); },
              ),
            ),
            Text(
              this._numberOfDoubtfulStudents == '1'
                ? '${this._numberOfDoubtfulStudents} Estudiante no reconocido'
                : '${this._numberOfDoubtfulStudents} Estudiantes no reconocidos',
              style: TextStyle(
                fontSize: 20.0,
              ),
            textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: MaterialButton(
        height: 40.0,
        minWidth: 100.0,
        color: Colors.teal,
        textColor: Colors.white,
        child: Text('Registrar Asistencia'),
        onPressed: () { _onRegisterAssistanceButtonPressed(context); },
        splashColor: Colors.blue,
      ),
    );
  }
}
