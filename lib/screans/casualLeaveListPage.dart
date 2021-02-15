import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


User loggedInUSer;

class CasualLeaveListPage extends StatefulWidget {
  @override
  _CasualLeaveListPageState createState() => _CasualLeaveListPageState();
}

class _CasualLeaveListPageState extends State<CasualLeaveListPage> {



  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;



  @override
  void initState() {
    super.initState();
    setState(() {
      getCurrentUser();
    });


  }

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection("leaves").doc('casual').collection(loggedInUSer.email).snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data.docs[index];
              return LeaveItems(
                //documentSnapshot: data,

                date: data['date'],

              );
            },
          );
        },
      ),
    );
  }
}

class LeaveItems extends StatefulWidget {
  final String date;
  LeaveItems({this.date});

  @override
  _LeaveItemsState createState() => _LeaveItemsState();
}

class _LeaveItemsState extends State<LeaveItems> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 100,
      width: 150,
      child: Text(widget.date)
    );
  }
}
