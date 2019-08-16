import 'package:aplicacion_taller/presentation/ucb/view_model/ucb_login_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion_taller/presentation/ucb/view/ucb_login_form_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    UCBLoginFormViewModel ucbLoginFormViewModel = UCBLoginFormViewModel('Usuario', 'Contraseña', 'Ingresar', 'assets/img/fondo-ucb.jpg', 'assets/img/logo-ucb.png');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplicacion taller',
      theme: ThemeData.dark(),
      home: UCBLoginFormView(ucbLoginFormViewModel),
    );
  }
}
