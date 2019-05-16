import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final _useridController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('P E T W E E N', style: TextStyle(color: Colors.black),),
        backgroundColor: Color(0xFFFFCA28),
      ),
      body: Center(
        child: Column(
          children: <Widget>[

            SizedBox(height: 200.0),
            
            
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _useridController,
                    decoration: InputDecoration(
                        filled:true,
                        labelText: 'ID',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            )
                        )
                    ),
                  ),

                  SizedBox(height: 10.0,),

                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        filled:true,
                        labelText: 'password',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            )
                        )
                    ),
                  ),


                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Text('Sign in'),
                        onPressed: (){
                          Navigator.of(context).pushNamed('/signin');
                        },
                      ),

                      RaisedButton(
                          child: Text('Log in'),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/catchoice');
                          }
                      ),
                    ],
                  ),

                  SizedBox (height: 15.0),

                  ButtonTheme(
                    minWidth: 300.0,
                    height: 50.0,
                    child: RaisedButton(
                        onPressed: () async {
//                        _signInWithGoogle().then((FirebaseUser user) {
//                          Navigator.of(context)
//                              .push(MaterialPageRoute(
//                              builder: (BuildContext context) => HomePage()))
//                              .catchError((e) => print(e));
//                        }
//                        );
                          Navigator.of(context).pushNamed('/catchoice');
                        },

                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Sign in Google'),
                        ),
                        color: Color(0xFFFFF8E1),
                    ),
                  )

                ],
              )
            )
          ],
        )
      ),
      backgroundColor: Color(0xFFFFCA28),
    );
  }
}