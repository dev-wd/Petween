import 'package:flutter/material.dart';
import 'package:petween/login/pre_login.dart';
import 'login.dart';
import 'package:petween/pet_create_and_show/profile_create.dart';
import 'package:petween/setting/setting.dart';
import 'package:petween/login/signin.dart';
import 'profile_edit.dart';

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
        '/edit' : (BuildContext context) => ProfileEditPage(),
      },
    );
  }
}
