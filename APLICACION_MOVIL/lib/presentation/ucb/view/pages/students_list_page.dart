import 'package:aplicacion_taller/domain/entities/authentication.dart';
import 'package:aplicacion_taller/domain/entities/student.dart';
import 'package:aplicacion_taller/presentation/ucb/presenter/ucb_show_attendance_control_list_presenter.dart';
import 'package:flutter/material.dart';

class StudentsListPage extends StatefulWidget {
  final List<Student> _studentsList;
  final String _listNameToMove;
  final UCBShowAttendanceControlListPresenter _ucbShowAttendanceControlListPresenter;

  @override
  _StudentsListPageState createState() => _StudentsListPageState();

  StudentsListPage(this._studentsList, this._listNameToMove, this._ucbShowAttendanceControlListPresenter);
}

class _StudentsListPageState extends State<StudentsListPage> {
  TextEditingController _editingController = TextEditingController();
  List<Student> items;

  @override
  void initState() {
    super.initState();
    items = List<Student>();
    items.addAll(widget._studentsList);
  }

  void _editList(BuildContext context, Student student) {
    AlertDialog alert = new AlertDialog(
      title: Center(
        child: Text('EDITAR'),
      ),
      content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                foregroundColor: Theme.of(context).primaryColor,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(student.pictureURL),
                radius: 70.0,
              ),
              Center(
                child: Text('¿Mover a "${student.name}" a ${widget._listNameToMove}?'),
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

              Authentication authentication = Authentication();

              if (widget._listNameToMove == 'estudiantes no reconocidos') {
                authentication.studentsPresentList.remove(student);
                authentication.studentsMissingList.add(student);
              } else {
                authentication.studentsMissingList.remove(student);
                authentication.studentsPresentList.add(student);
              }

              items.remove(student);
              widget._ucbShowAttendanceControlListPresenter.updateAttendanceControlList();
            },
          ),
        ),
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }

  void _filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<Student> studentsListData = List<Student>();
      widget._studentsList.forEach((student) {
        String studentNameFix = student.name.toLowerCase();
        String queryFix = query.toLowerCase();
        if (studentNameFix.contains(queryFix)) {
          studentsListData.add(student);
        }
      });
      setState(() {
        items.clear();
        items.addAll(studentsListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(widget._studentsList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  _filterSearchResults(value);
                },
                controller: _editingController,
                decoration: InputDecoration(
                  labelText: 'Buscar',
                  hintText: 'Buscar',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))
                  )
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => Column(
                    children: <Widget>[
                      Divider(
                        height: 10.0,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          foregroundColor: Theme.of(context).primaryColor,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(items[index].pictureURL),
                        ),
                        title: Text(
                            items[index].name,
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        onTap: () { _editList(context, items[index]); },
                      )
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
