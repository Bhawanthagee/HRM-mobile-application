
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
User loggedInUSer;

class DutyLeave extends StatefulWidget {
  @override
  _DutyLeaveState createState() => _DutyLeaveState();
}

class _DutyLeaveState extends State<DutyLeave> {


  int status;

  void remainingLeaveCounter()async{
    try{
      //QuerySnapshot variable = await _fireStore.collection('Leaves').doc('duty').collection(loggedInUSer.email).get();


    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Duty Leave'),
      ),
      body: Container(
        child: Center(
          child: Text(
            'This is Duty Leave Page'
          ),
        ),
      ),
    );
  }
}
