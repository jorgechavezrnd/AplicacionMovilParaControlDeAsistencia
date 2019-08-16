import 'package:aplicacion_taller/domain/boundary/input/login_user_use_case.dart';
import 'package:aplicacion_taller/domain/boundary/input/show_subjects_use_case.dart';
import 'package:aplicacion_taller/domain/boundary/input/show_attendance_control_list_use_case.dart';
import 'package:aplicacion_taller/domain/boundary/output/login_user_presenter.dart';
import 'package:aplicacion_taller/domain/boundary/output/show_subjects_presenter.dart';
import 'package:aplicacion_taller/domain/boundary/output/show_attendance_control_list_presenter.dart';
import 'package:aplicacion_taller/domain/dto/request/login_user_request.dart';
import 'package:aplicacion_taller/domain/dto/request/show_subjects_request.dart';
import 'package:aplicacion_taller/domain/dto/request/show_attendance_control_list_request.dart';
import 'package:aplicacion_taller/domain/entities/authentication.dart';
import 'package:aplicacion_taller/domain/entityGateways/show_subjects_repository.dart';
import 'package:aplicacion_taller/domain/entityGateways/user_repository.dart';
import 'package:aplicacion_taller/domain/entityGateways/student_repository.dart';
import 'package:aplicacion_taller/domain/interactors/login_user_interactor.dart';
import 'package:aplicacion_taller/domain/interactors/show_subjects_interactor.dart';
import 'package:aplicacion_taller/domain/interactors/show_attendance_control_list_interactor.dart';
import 'package:aplicacion_taller/presentation/ucb/presenter/ucb_login_user_presenter.dart';
import 'package:aplicacion_taller/presentation/ucb/presenter/ucb_show_subjects_presenter.dart';
import 'package:aplicacion_taller/presentation/ucb/presenter/ucb_show_attendance_control_list_presenter.dart';
import 'package:aplicacion_taller/repository/user/server_go_user_repository.dart';
import 'package:aplicacion_taller/repository/subject/server_go_subject_repository.dart';
import 'package:aplicacion_taller/repository/student/server_go_student_repository.dart';
import 'package:aplicacion_taller/presentation/ucb/view/ucb_show_attendance_control_list_view.dart';
import 'package:flutter/material.dart';

class UCBController {
  BuildContext _context;

  BuildContext get context => _context;

  set context(BuildContext context) => this._context = context;

  static UCBController _instance = UCBController.internal();
  UCBController.internal();
  factory UCBController() => _instance;

  Future<void> loginUserUseCase(String username, String password, GlobalKey<ScaffoldState> scaffoldKey) async {
    UserRepository repository = ServerGoUserRepository();
    LoginUserPresenter presenter =
        UCBLoginUserPresenter(scaffoldKey);
    LoginUserRequest request = LoginUserRequest(username, password);
    LoginUserUseCase loginUserUseCase =
        LoginUserInteractor(repository, presenter);

    await loginUserUseCase.loginUser(request);
  }

  Future<void> showSubjectsUseCase() async {
    Authentication authentication = Authentication();

    SubjectRepository repository = ServerGoSubjectRepository();
    ShowSubjectsPresenter presenter = UCBShowSubjectsPresenter(this._context);
    ShowSubjectsRequest request = ShowSubjectsRequest(authentication.id);
    ShowSubjectsUseCase showSubjectsUseCase = ShowSubjectsInteractor(repository, presenter);

    await showSubjectsUseCase.showSubjects(request);
  }

  Future<void> showAttendanceControlListUseCase(String subjectID, String parallelID, String imageBase64) async {
    UCBShowAttendanceControlListView ucbShowAttendanceControlListView = UCBShowAttendanceControlListView();

    Navigator.of(this._context).pushReplacement(MaterialPageRoute(
        builder: (context) => ucbShowAttendanceControlListView
    ));

    StudentRepository repository = ServerGoStudentRepository(ucbShowAttendanceControlListView);
    ShowAttendanceControlListPresenter presenter = UCBShowAttendanceControlListPresenter(ucbShowAttendanceControlListView);
    ShowAttendanceControlListRequest request = ShowAttendanceControlListRequest(subjectID, parallelID, imageBase64);
    ShowAttendanceControlListUseCase showAttendanceControlListUseCase = ShowAttendanceControlListInteractor(repository, presenter);

    await showAttendanceControlListUseCase.showAttendanceControlList(request);
  }
}