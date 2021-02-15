import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/screans/googleNav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'dialogBox/errorDialog.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String errorMessage;
  bool showSpinner = false;
  final _key = GlobalKey<FormState>();

  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Welcome,",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Sign in to continue!,",
                        style: TextStyle(
                            fontSize: 20, color: Colors.grey.shade400),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                                height: 300,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage('assets/images/login.png'),
                                )))
                          ],
                        ),
                      )
                    ],
                  ),
                  //TODO username is here...................................................................................................
                  Form(
                    key: _key,
                    child: Column(
                      children: [
                        TextFormField(
                            onChanged: (value) {
                              email = value;
                            },
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return " Email can not be emplty";
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade400),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  )),
                            )),
                        SizedBox(
                          height: 16,
                        ),
                        //TODO password is here...................................................................................................
                        TextFormField(
                            obscureText: true,
                            onChanged: (value) {
                              password = value;
                            },
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return " Password can not be emplty";
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade400),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  )),
                            )),
                        //TODO login button here...................................................................................................
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: FlatButton(
                            onPressed: () async {
                              if (_key.currentState.validate()) {
                                setState(() {
                                  showSpinner = true;
                                });

                                try {
                                  final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);
                                  if (user != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyHomePage()));
                                    //Navigator.pop(context);
                                  }
                                  setState(() {
                                    showSpinner = false;
                                  });
                                } on FirebaseAuthException catch (e) {
                                 if(e.code == 'user-not-found' || e.code == 'invalid-email'){
                                   showDialog(context: context,
                                       builder: (BuildContext context){
                                         return LoginErrorDialogEmail();
                                       });
                                   setState(() {
                                     showSpinner = false;
                                   });
                                 } else if(e.code == 'wrong-password'){
                                   showDialog(context: context,
                                       builder: (BuildContext context){
                                         return LoginErrorDialogPassword();
                                       });
                                   setState(() {
                                     showSpinner = false;
                                   });
                                 }
                                 // else if(e.code == 'invalid-email'){
                                 //   showDialog(context: context,
                                 //       builder: (BuildContext context){
                                 //         return LoginErrorDialogPassword();
                                 //       });
                                 //   setState(() {
                                 //     showSpinner = false;
                                 //   });
                                 // }
                                }
                              }
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xff5F67FF),
                                        Color(0xff7e85ff),
                                        Color(0xffbfc2ff),
                                      ])),
                              child: Container(
                                alignment: Alignment.center,
                                constraints: BoxConstraints(
                                    maxWidth: double.infinity, minHeight: 50),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Align(
                            alignment: Alignment.topCenter,
                            //TODO forgot password field...................................................................................................

                            child: FlatButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ))
                      ],
                    ),
                  ),
                  Row(
                    children: [],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
