import 'package:aplicacion_taller/presentation/ucb/controller/ucb_controller.dart';
import 'package:aplicacion_taller/presentation/ucb/view/ucb_user_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion_taller/presentation/ucb/view_model/ucb_login_user_view_model.dart';

class UCBLoginUserView {
  GlobalKey<ScaffoldState> _scaffoldKey;

  UCBLoginUserView(this._scaffoldKey);

  void displayLoginError(UCBLoginUserViewModel model) {
    final snackBar = SnackBar(
      content: Text(model.message),
      duration: Duration(seconds: 3),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void displayLoginSuccess() {
    UCBController controller = UCBController();

    Navigator.of(controller.context).pushReplacement(MaterialPageRoute(
        builder: (context) => UCBUserProfileView()
    ));
  }
}
