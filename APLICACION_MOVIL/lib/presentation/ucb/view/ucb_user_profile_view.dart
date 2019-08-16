import 'package:aplicacion_taller/domain/entities/authentication.dart';
import 'package:aplicacion_taller/presentation/ucb/view/ucb_login_form_view.dart';
import 'package:aplicacion_taller/presentation/ucb/view_model/ucb_login_form_view_model.dart';
import 'package:aplicacion_taller/utils/constants_and_functions.dart';
import 'package:flutter/material.dart';

import '../controller/ucb_controller.dart';

class UCBUserProfileView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onRegisterAttendanceControl(BuildContext context) async {
    UCBController controller = UCBController();

    controller.context = context;

    Navigator.of(context).pop();

    final snackBar = SnackBar(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Center(child: Text('OBTENIENDO MATERIAS')),
            Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Center(child: CircularProgressIndicator()))
          ],
        ),
      ),
      duration: Duration(minutes: 5),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);

    await controller.showSubjectsUseCase();

    _scaffoldKey.currentState.removeCurrentSnackBar();
  }

  void _onShowImages(BuildContext context) {
    print('Ver imagenes del semestre precionado');
    Navigator.of(context).pop();
  }

  void _onLogout(BuildContext context) {
    Navigator.of(context).pop();

    UCBLoginFormViewModel ucbLoginFormViewModel = UCBLoginFormViewModel(
        'Usuario',
        'Contraseña',
        'Ingresar',
        'assets/img/fondo-ucb.jpg',
        'assets/img/logo-ucb.png');

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => UCBLoginFormView(ucbLoginFormViewModel)));

    Authentication authentication = Authentication();

    authentication.id = null;
    authentication.username = null;
    authentication.name = null;
    authentication.subject = null;
    authentication.studentsPresentList = null;
    authentication.studentsMissingList = null;
  }

  Widget _buildProfileImage(String imageURL) {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageURL),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(color: Colors.white, width: 10.0),
        ),
      ),
    );
  }

  Widget _buildFullName(String fullName) {
    TextStyle _nameTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      fullName,
      style: _nameTextStyle,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildEmail(BuildContext context, String email) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        email,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Authentication authentication = Authentication();
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        key: this._scaffoldKey,
        appBar: AppBar(
          title: Center(
            child: Text('USUARIO'),
          ),
          elevation: 0.7,
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(authentication.name),
                accountEmail: Text(authentication.username + '@ucbcba.edu.bo'),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        '$SERVER_SIAA_PERSON_PICTURE_URL/${authentication.id}'),
                  ),
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            'assets/img/ucb_information_background.jpg'),
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.2), BlendMode.dstATop))),
              ),
              ListTile(
                title: Text('Registrar asistencia'),
                trailing: Icon(Icons.arrow_upward),
                onTap: () {
                  _onRegisterAttendanceControl(context);
                },
              ),
              ListTile(
                title: Text('Imagenes del semestre'),
                trailing: Icon(Icons.arrow_upward),
                onTap: () {
                  _onShowImages(context);
                },
              ),
              ListTile(
                title: Text('Cerrar sesión'),
                trailing: Icon(Icons.exit_to_app),
                onTap: () {
                  _onLogout(context);
                },
              )
            ],
          ),
        ),
        body: Stack(fit: StackFit.expand, children: <Widget>[
          Image(
            image: AssetImage('assets/img/fondo-ucb.jpg'),
            fit: BoxFit.cover,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,
          ),
          SafeArea(
              child: SingleChildScrollView(
                  child: Column(children: <Widget>[
            SizedBox(height: screenSize.height / 6.4),
            _buildProfileImage(
                '$SERVER_SIAA_PERSON_PICTURE_URL/${authentication.id}'),
            SizedBox(height: 15.0),
            _buildFullName(authentication.name),
            _buildEmail(context, '${authentication.username}@ucbcba.edu.bo'),
          ])))
        ]));
  }
}
