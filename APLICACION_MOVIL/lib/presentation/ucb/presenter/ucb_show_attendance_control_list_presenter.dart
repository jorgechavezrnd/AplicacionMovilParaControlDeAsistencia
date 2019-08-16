import 'package:aplicacion_taller/domain/boundary/output/show_attendance_control_list_presenter.dart';
import 'package:aplicacion_taller/domain/dto/response/show_attendance_control_list_response.dart';
import 'package:aplicacion_taller/domain/entities/authentication.dart';
import 'package:aplicacion_taller/presentation/ucb/view_model/ucb_show_attendance_control_list_view_model.dart';
import 'package:aplicacion_taller/presentation/ucb/view/ucb_show_attendance_control_list_view.dart';
import 'package:aplicacion_taller/presentation/ucb/view/pages/students_list_page.dart';
import 'package:aplicacion_taller/presentation/ucb/view/pages/image_page.dart';
import 'package:flutter/material.dart';

class UCBShowAttendanceControlListPresenter implements ShowAttendanceControlListPresenter {
  UCBShowAttendanceControlListView _view;
  ShowAttendanceControlListResponse _response;

  UCBShowAttendanceControlListPresenter(this._view);

  void updateAttendanceControlList() {
    Authentication authentication = Authentication();

    UCBShowAttendanceControlListViewModel ucbShowAttendanceControlListViewModel = UCBShowAttendanceControlListViewModel(
        authentication.studentsPresentList,
        authentication.studentsMissingList,
        _response.numberOfDoubtfulStudents,
        _response.pictureWithFacesDetectedAndNamesBase64
    );

    String numberOfStudentsPresent = ucbShowAttendanceControlListViewModel.studentsPresentList.length.toString();
    String numberOfStudentsMissing = ucbShowAttendanceControlListViewModel.studentsMissingList.length.toString();

    String studentsPresentMessage = numberOfStudentsPresent == '1'
        ? '$numberOfStudentsPresent Estudiante reconocido'
        : '$numberOfStudentsPresent Estudiantes reconocidos';

    String studentsMissingMessage = numberOfStudentsMissing == '1'
        ? '$numberOfStudentsMissing Estudiante no reconocido'
        : '$numberOfStudentsMissing Estudiantes no reconocidos';

    Widget studentPresentListPage = Scaffold(
      body: StudentsListPage(
        ucbShowAttendanceControlListViewModel.studentsPresentList,
        'estudiantes no reconocidos',
        this
      ),
      bottomNavigationBar: Text(
        studentsPresentMessage,
        style: TextStyle(
          fontSize: 20.0,
        ),
        textAlign: TextAlign.center,
      ),
    );

    Widget studentMissingListPage = Scaffold(
      body: StudentsListPage(
        ucbShowAttendanceControlListViewModel.studentsMissingList,
        'estudiantes reconocidos',
        this
      ),
      bottomNavigationBar: Text(
        studentsMissingMessage,
        style: TextStyle(
          fontSize: 20.0,
        ),
        textAlign: TextAlign.center,
      ),
    );

    Widget pictureWithFacesDetectedAndNamesPage = ImagePage(
      ucbShowAttendanceControlListViewModel.pictureWithFacesDetectedAndNamesBase64,
      ucbShowAttendanceControlListViewModel.numberOfDoubtfulStudents,
    );

    Widget body = TabBarView(
      controller: this._view.ucbShowAttendanceControlListViewState.tabController,
      children: <Widget>[
        studentPresentListPage,
        studentMissingListPage,
        pictureWithFacesDetectedAndNamesPage,
      ],
    );

    this._view.ucbShowAttendanceControlListViewState.changeStateAndBody(true, body);
  }

  @override
  void displayAttendanceControlList(ShowAttendanceControlListResponse response) {
    Authentication authentication = Authentication();
    authentication.studentsPresentList = response.studentsPresentList;
    authentication.studentsMissingList = response.studentsMissingList;

    this._response = response;

    updateAttendanceControlList();
  }
}