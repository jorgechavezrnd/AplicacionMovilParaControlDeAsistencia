import 'dart:convert';
import 'package:aplicacion_taller/domain/entities/authentication.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion_taller/presentation/ucb/controller/ucb_controller.dart';
import 'package:aplicacion_taller/presentation/ucb/view_model/ucb_login_form_view_model.dart';

class UCBLoginFormView extends StatefulWidget {
  final UCBLoginFormViewModel ucbLoginFormViewModel;

  UCBLoginFormView(this.ucbLoginFormViewModel);

  @override
  _UCBLoginFormViewState createState() => _UCBLoginFormViewState();
}

class _UCBLoginFormViewState extends State<UCBLoginFormView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  BuildContext _context;

  void _onLoginButtonPressed() async {
    setState(() {
      _isLoading = true;
    });

    String username = _usernameController.text;
    var bytes = utf8.encode(_passwordController.text);
    var digest = md5.convert(bytes);
    String passwordEncrypted = digest.toString();

    UCBController controller = UCBController();
    controller.context = this._context;

    await controller.loginUserUseCase(
        username, passwordEncrypted, this._scaffoldKey);

    Authentication authentication = Authentication();

    if (authentication.isEmpty()) {
      setState(() {
        this._isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: AssetImage(widget.ucbLoginFormViewModel.backgroundImageURL),
            fit: BoxFit.cover,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage(widget.ucbLoginFormViewModel.logoImageURL),
                height: 100,
                width: 100,
              ),
              Form(
                child: Theme(
                  data: ThemeData(
                      brightness: Brightness.dark,
                      primarySwatch: Colors.teal,
                      inputDecorationTheme: InputDecorationTheme(
                          labelStyle:
                              TextStyle(color: Colors.teal, fontSize: 20.0))),
                  child: Container(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                              hintText: widget
                                  .ucbLoginFormViewModel.usernamePlaceholder),
                          keyboardType: TextInputType.text,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                              hintText: widget
                                  .ucbLoginFormViewModel.passwordPlaceholder),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                        ),
                        _isLoading
                            ? Center(child: CircularProgressIndicator())
                            : MaterialButton(
                                height: 40.0,
                                minWidth: 100.0,
                                color: Colors.teal,
                                textColor: Colors.white,
                                child: Text(
                                    widget.ucbLoginFormViewModel.loginButtonText),
                                onPressed: _onLoginButtonPressed,
                                splashColor: Colors.blue,
                              )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
