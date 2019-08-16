import 'package:aplicacion_taller/domain/boundary/output/show_subjects_presenter.dart';
import 'package:aplicacion_taller/domain/dto/response/show_subjects_response.dart';
import 'package:aplicacion_taller/presentation/ucb/view/ucb_show_subjects_view.dart';
import 'package:aplicacion_taller/presentation/ucb/view_model/ucb_show_subjects_view_model.dart';
import 'package:flutter/material.dart';

class UCBShowSubjectsPresenter implements ShowSubjectsPresenter {
  BuildContext _context;

  UCBShowSubjectsPresenter(this._context);

  @override
  void displaySubjects(ShowSubjectsResponse response) {
    UCBShowSubjectsViewModel ucbShowSubjectsViewModel = UCBShowSubjectsViewModel(response.subjectList);

    Navigator.of(this._context).push(MaterialPageRoute(
      builder: (context) => UCBShowSubjectsView(ucbShowSubjectsViewModel)
    ));
  }
}