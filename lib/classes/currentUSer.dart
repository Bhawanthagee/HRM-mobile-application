import 'package:firebase_auth/firebase_auth.dart';


class CurrentUser{

  User loggedInUSer;
  final _auth =FirebaseAuth.instance;

  void getCurrentUser()async{
    try{
      final user = _auth.currentUser;
      if(user!=null){
        loggedInUSer = user ;
        print(loggedInUSer.email);
      }}
    catch(e){
      print(e);
    }
  }


}