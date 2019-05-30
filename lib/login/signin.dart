import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petween/login/login.dart';
import 'package:petween/model/db.dart' as db;

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => new _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with WidgetsBindingObserver {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confrimPasswordController = TextEditingController();


  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text('P E T W E E N', style: TextStyle(color: Colors.black),),
          backgroundColor: Color(0xFFFFCA28),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: (){
              Navigator.of(context).pop();
            },
          )
      ),
      body: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30.0,),

                  Container(
                    child: const Text('W E L C O M E   T O   P E T W E E N !',
                      style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 15.0, color: Colors.black),),
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                  ),

                  SizedBox(height: 40.0,),

                  TextFormField (
                    controller: _userNameController,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                    validator: (String value){
                      if (value.isEmpty){
                        return 'Please enter name';
                      }
                    },
                  ),

                  SizedBox(height: 20.0,),

                  TextFormField (
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'email',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      validator: (String value){
                        if (value.isEmpty){
                          return 'Please enter email';
                        }
                        if (!value.contains('@') || !value.contains('.')){
                          return 'The email address is badly formatted';
                        }
                      },
                  ),

                  SizedBox(height: 20.0),

                  TextFormField (
                      controller: _passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'password',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      validator: (String value){
                        if (value.isEmpty){
                          return 'Please enter password';
                        }
                        if (value.length < 5){
                          return 'Password must be 6 characters long or more';
                        }

                      },
                    obscureText: true,
                  ),

                  SizedBox(height: 20.0,),

                  TextFormField (
                      controller: _confrimPasswordController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'confirmPassword',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      validator: (String value){
                        if (value.isEmpty){
                          return 'Check your password';
                        }
                        if ( value != _passwordController.text) {
                          return 'Password is not matching';
                        }
                        if (value.length < 5){
                          return 'Password must be 6 characters long or more';
                        }
                      },
                    obscureText: true,
                  ),

                  SizedBox(height: 15.0,),

                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Text('CANCLE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),),
                        onPressed: (){
                          _confrimPasswordController.clear();
                          _passwordController.clear();
                          _emailController.clear();
                          _userNameController.clear();
                        },
                      ),

                      FlatButton(
                          child: Text('LOG IN'),
                          onPressed: () async{
                            if (_formKey.currentState.validate()){
                              register();
                              };
                          },
                      ),
                    ],
                  ),

                ],
              )
          )
      ),
      backgroundColor: Color(0xFFFFCA28),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void register() async {

    final FirebaseUser cuser = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
    );
    if (cuser != null) {
      Map<String, dynamic> user = {
        'userName': _userNameController.text,
        'email' : _emailController.text,
        'docuemntID' : cuser.uid.toString(),
      };
      Firestore.instance.collection('information').document(cuser.uid).setData(user);
      Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => LoginPage()));
    }
    else {
      null;
    }
  }



}

