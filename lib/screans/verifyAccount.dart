import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/screans/googleNav.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class VerifyAccount extends StatefulWidget {
  @override
  _VerifyAccountState createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {

  String nameOfTheUser;
  User u;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;


  getName()async{
    User user = _auth.currentUser;
    DocumentSnapshot name = await _fireStore.collection('users').doc(user.email).get();

    setState(() {
      nameOfTheUser = name['name'];
      u=user;
    });
  }
  activateAccount(){
    _fireStore.collection('leave_counter').doc(u.email).set({
      'r_leave' : 40
    });
    _fireStore.collection('attDate').doc(u.email).set({
      'today':'0'
    });
    _fireStore.collection('halfDay leave Counter').doc(u.email).set({
      'count' :'0'
    });
    _fireStore.collection('in').doc(u.email).set({
      'inStat' :'0'
    });
    _fireStore.collection('medicalLeaveCount').doc(u.email).set({
      'remaining leaves' :20
    });
    _fireStore.collection('out').doc(u.email).set({
      'outStat' :'0'
    });
    _fireStore.collection('short leave Counter').doc(u.email).set({
      'count' :'2'
    });
    _fireStore.collection('users').doc(u.email).set({
      'bio' :'1'
    });
    _fireStore.collection('already_got_HD_or_SL').doc(u.email).set({
      'stat' :'0'
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();
  }
  @override
  Widget build(BuildContext context) {
    getName()async{
      User user = _auth.currentUser;
      DocumentSnapshot name = await _fireStore.collection('users').doc(user.email).get();

      setState(() {
        nameOfTheUser = name['name'];
        u=user;
      });
    }
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Activate Account"),
        ),
        body: Column(
          children: [
            Expanded(child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/CERTLogo.png')
                )
              ),
            )),
            Expanded(child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:11.0),
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: "Hello ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                            TextSpan(text: "$nameOfTheUser!",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 23),),

                          ])),
                ),

                Padding(
                  padding: const EdgeInsets.only(top:8.0,left: 20.0,right: 20.0),
                  child:RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: "Welcome to our company's mobile application ",),
                            TextSpan(text: "$nameOfTheUser",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,),),
                            TextSpan(text: "  ,this is the first time you are using our mobile application.\nfirst of all we need to activate your account. \nIt is a simple task, just click on the below  ",),
                            TextSpan(text: "ACTIVATE",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
                            TextSpan(text: " button to activate your account.")
                          ])),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(
                      child: RaisedButton.icon(
                        color: Colors.green,
                        label: Text('ACTIVATE',style: TextStyle(color: Colors.white),),
                          icon: Icon(Icons.verified,color: Colors.white,),
                          onPressed: ()async{
                          try{
                            setState(() {
                              showSpinner = true;
                            });
                            activateAccount();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                            setState(() {
                              showSpinner = false;
                            });

                          }catch (e){

                          }
                        }
                      )),
                )
              ],
            ))
          ],
        )
      ),
    );
  }
}
