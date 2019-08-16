import 'package:aplicacion_taller/domain/entities/authentication.dart';
import 'package:aplicacion_taller/domain/entities/student.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UCBAttendanceControlInformationView extends StatefulWidget {
  @override
  _UCBAttendanceControlInformationViewState createState() => _UCBAttendanceControlInformationViewState();
}

class _UCBAttendanceControlInformationViewState extends State<UCBAttendanceControlInformationView> {
  final TextEditingController _subjectNameController = TextEditingController();
  final TextEditingController _parallelController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  DateTime _dateTime;

  Widget _buildStudent(BuildContext context, Student student) {
    return Column(
      children: <Widget>[
        Divider(
          height: 10.0,
        ),
        ListTile(
          leading: CircleAvatar(
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(student.pictureURL),
          ),
          title: Text(
              student.name,
              style: TextStyle(fontWeight: FontWeight.bold)
          ),
        )
      ],
    );
  }

  void _onConfirmButtonPressed(BuildContext context) {
    print('CONFIRMADO!');

    Authentication authentication = Authentication();

    AlertDialog alert = new AlertDialog(
      title: Center(
        child: Text('CONFIRMADO'),
      ),
      content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Text('Se registro la asistencia de la materia ${authentication.subject.name} correctamente'),
              )
            ],
          )
      ),
      actions: <Widget>[
        Center(
          child: FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }

  @override
  Widget build(BuildContext context) {
    Authentication authentication = Authentication();

    _subjectNameController.text = toBeginningOfSentenceCase(authentication.subject.name.toLowerCase());
    _parallelController.text = authentication.subject.parallel;
    _dateTime = DateTime.now();
    _dateTimeController.text = DateFormat("dd-MM-yyyy").format(_dateTime);

    return Scaffold(
      appBar: AppBar(
        title: Text('DATOS DEL REGISTRO'),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              TextFormField(
                controller: _subjectNameController,
                enabled: false,
                decoration: const InputDecoration(
                  icon: Icon(Icons.subject),
                  hintText: 'Nombre de materia',
                  labelText: 'Materia',
                ),
              ),
              TextFormField(
                controller: _parallelController,
                enabled: false,
                decoration: const InputDecoration(
                  icon: Icon(Icons.subject),
                  hintText: 'Numero de paralelo',
                  labelText: 'Paralelo',
                ),
              ),
              InkWell(
                child: TextFormField(
                  controller: _dateTimeController,
                  enabled: false,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.access_time),
                    hintText: 'Fecha del registro',
                    labelText: 'Fecha',
                  ),
                ),
                onTap: () { print('Fecha Precionada'); },
              ),
              ExpansionTile(
                  title: Text('Estudiantes Presentes (${authentication.studentsPresentList.length})'),
                  children: authentication.studentsPresentList.map((student) {
                    return _buildStudent(context, student);
                  }).toList()
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: MaterialButton(
        height: 40.0,
        minWidth: 100.0,
        color: Colors.teal,
        textColor: Colors.white,
        child: Text('Confirmar'),
        onPressed: () { _onConfirmButtonPressed(context); },
        splashColor: Colors.blue,
      ),
    );
  }
}
