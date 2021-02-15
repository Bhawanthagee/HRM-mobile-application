import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoggedInUser{
  var loggedInUSer;
  FirebaseAuth _auth = FirebaseAuth.instance;

  void getCurrentUser()async{
    try{
      final user = await _auth.currentUser;
      if(user!=null){
        loggedInUSer = user;
        print(loggedInUSer.email);
      }}
    catch(e){
      print(e);
    }
  }
}