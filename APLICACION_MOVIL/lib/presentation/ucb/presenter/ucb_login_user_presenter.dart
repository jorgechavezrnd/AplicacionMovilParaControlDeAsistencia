import 'package:aplicacion_taller/domain/boundary/output/login_user_presenter.dart';
import 'package:aplicacion_taller/domain/dto/response/login_user_response.dart';
import 'package:aplicacion_taller/presentation/ucb/view_model/ucb_login_user_view_model.dart';
import 'package:aplicacion_taller/presentation/ucb/view/ucb_login_user_view.dart';
import 'package:flutter/material.dart';


class UCBLoginUserPresenter implements LoginUserPresenter {
  UCBLoginUserView _view;

  UCBLoginUserPresenter(GlobalKey<ScaffoldState> scaffoldKey) {
    this._view = UCBLoginUserView(scaffoldKey);
  }

  @override
  void displayLoginFailedIncorrectPassword() {
    UCBLoginUserViewModel model = UCBLoginUserViewModel('ERROR: Contraseña Incorrecta');
    _view.displayLoginError(model);
  }

  @override
  void displayLoginFailedUserNotExist() {
    UCBLoginUserViewModel model = UCBLoginUserViewModel('ERROR: Usuario no existente');
    _view.displayLoginError(model);
  }

  @override
  void displayLoginSuccess(LoginUserResponse response) {
    _view.displayLoginSuccess();
  }
}