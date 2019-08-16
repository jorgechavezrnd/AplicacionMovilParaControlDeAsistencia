import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class UCBShowAttendanceControlListView extends StatefulWidget {
  final _UCBShowAttendanceControlListViewState _ucbShowAttendanceControlListViewState = _UCBShowAttendanceControlListViewState();

  _UCBShowAttendanceControlListViewState get ucbShowAttendanceControlListViewState => _ucbShowAttendanceControlListViewState;

  @override
  _UCBShowAttendanceControlListViewState createState() => _ucbShowAttendanceControlListViewState;
}

class _UCBShowAttendanceControlListViewState extends State<UCBShowAttendanceControlListView> with SingleTickerProviderStateMixin {
  bool _isFinishedProcess;
  TabController _tabController;
  Widget _body;
  String _percentageString;
  double _percentageDouble;

  TabController get tabController => _tabController;

  @override
  void initState() {
    super.initState();
    _isFinishedProcess = false;
    _tabController = new TabController(vsync: this, initialIndex: 0, length: 3);
    _body = SingleChildScrollView(
      child: Center(
        child: ListBody(
          children: <Widget>[
            Center(
              child: Text('CONECTANDO SERVIDOR'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Center(child: CircularProgressIndicator()),
            )
          ],
        ),
      ),
    );
    _percentageString = '0%';
    _percentageDouble = 0.0;
  }

  void changeStateAndBody(bool isFinishedProcess, Widget body) {
    setState(() {
      _isFinishedProcess = isFinishedProcess;
      _body = body;
    });
  }

  void changePercentage(String percentageString) {
    setState(() {
      _percentageString = '$percentageString%';
      _percentageDouble = double.parse(percentageString) / 100;
    });
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('SALIR'),
        content: Text('¿Realmente quiere salir?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Si'),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    double width_device = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('CONTROL DE ASISTENCIA'),
          ),
          elevation: 0.7,
          bottom: !_isFinishedProcess ? null : TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(text: 'RECONOCIDOS'),
              Tab(text: 'NO RECONOCIDOS'),
              Tab(text: 'IMAGEN'),
            ],
          ),
        ),
        body: _body,
        bottomNavigationBar: _isFinishedProcess ? null : LinearPercentIndicator(
          width: width_device,
          lineHeight: 30.0,
          percent: _percentageDouble,
          backgroundColor: Colors.grey,
          progressColor: Colors.blue,
          center: Text(_percentageString, style: TextStyle(fontWeight: FontWeight.bold)),
        )
      ),
    );
  }
}
