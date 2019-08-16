import 'package:aplicacion_taller/domain/entities/authentication.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion_taller/presentation/ucb/view_model/ucb_show_subjects_view_model.dart';
import 'package:aplicacion_taller/presentation/ucb/view/ucb_take_picture_view.dart';

class UCBShowSubjectsView extends StatelessWidget {
  final UCBShowSubjectsViewModel _ucbShowSubjectsViewModel;

  UCBShowSubjectsView(this._ucbShowSubjectsViewModel);

  void _pushTakePictureView(BuildContext context) {
    Authentication authentication = Authentication();

    AlertDialog alert = new AlertDialog(
      title: Center(
        child: Text('MATERIA'),
      ),
      content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Text('¿Registrar asistenia de la materia ${authentication.subject.name}, paralelo ${authentication.subject.parallel}?'),
              )
            ],
          )
      ),
      actions: <Widget>[
        Center(
          child: FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Center(
          child: FlatButton(
            child: Text('Si'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => UCBTakePictureView()));
            },
          ),
        ),
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('CURSOS'),
        ),
        elevation: 0.7,
      ),
      body: ListView.builder(
        itemCount: this._ucbShowSubjectsViewModel.subjectList == null
            ? 1
            : this._ucbShowSubjectsViewModel.subjectList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Column(
              children: <Widget>[
                Divider(height: 10.0),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Center(
                            child: Text('Paralelo',
                                style:
                                    TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)))),
                    Expanded(
                        child: Center(
                            child: Text('Materia',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0))))
                  ],
                )
              ],
            );
          }
          index -= 1;

          return Column(
            children: <Widget>[
              Divider(height: 10.0),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Text(
                          this
                              ._ucbShowSubjectsViewModel
                              .subjectList[index]
                              .parallel,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        this._ucbShowSubjectsViewModel.subjectList[index].name,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Authentication authentication = Authentication();
                  authentication.subject = this._ucbShowSubjectsViewModel.subjectList[index];

                  print('SUBJECT: ${authentication.subject.id}, ${authentication.subject.parallel}, ${authentication.subject.name}');

                  _pushTakePictureView(context);
                },
              )
            ],
          );
        },
      ),
    );
  }
}
