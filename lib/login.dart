import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'db.dart' as db;
import 'profile_create.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String _userEmail;
  String _password;
  bool _success = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('P E T W E E N', style: TextStyle(color: Colors.black),),
        backgroundColor: Color(0xFFFFCA28),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[

            SizedBox(height: 200.0),
            
            
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        filled: true,
                        labelText: 'ID',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            )
                        ),
                    ),
                    validator: (String value){
                      if (value.isEmpty){
                        return 'Please enter email';
                      }
                      if (!value.contains("@") || !value.contains(".")){
                        return 'The email address is badly formatted';
                      }
                    },
                  ),

                  SizedBox(height: 10.0,),

                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        filled:true,
                        labelText: 'password',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            )
                        ),
                    ),
                    validator: (String value){
                      if (value.isEmpty){
                        return 'Please enter password';
                      }
                      if (value.length < 5){
                        return 'Password is not correct';
                      }
                    },
                    obscureText: true,
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
                          onPressed: () async{
                            if (_formKey.currentState.validate()){
                              _signInWithEmailAndPassword();
                              if (!_success){
                                return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(dialogBackgroundColor: Color(0xFFFFCA28)),
                                      child: AlertDialog(
                                        title: Text("Not correct!"),
                                        actions: <Widget>[
                                          RaisedButton(
                                            child: Text('OK'),
                                            color: Color(0xFF5D4037),
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            }
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
                        _signInWithGoogle();
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

  Future<FirebaseUser> _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken);

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    db.user = user;
    db.userUID = user.uid;
    db.userEmail = user.email;
  }

  Future<dynamic> _signInWithEmailAndPassword() async {
    _userEmail = _emailController.text;
    _password = _passwordController.text;

    final FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: _userEmail,
        password: _password
    );


    if (user != null){
        _success = true;
        Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ProfileCreatePage()))
          .catchError((e) => print(e));
    }
    else{
      _success = false;
    }

    user.reload();
    if (!user.isEmailVerified){
      _success = false;
    }
    else{
      _success = true;
    }

  }
}