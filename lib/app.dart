import 'package:flutter/material.dart';
import 'pre_login.dart';
import 'login.dart';
import 'profile_create.dart';
import 'setting.dart';
import 'signin.dart';

class PetweenApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      home: PreloginPage(),
      //initialRoute: '/login',
      // onGenerateRoute: _getRoute,
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginPage(),
        '/catchoice': (BuildContext context) => ProfileCreatePage(),
        '/setting': (BuildContext context) => SettingPage(),
        '/signin' : (BuildContext context) => SignInPage(),
      },
    );
  }
}
