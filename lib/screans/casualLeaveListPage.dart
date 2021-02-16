import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';



final _fireStore = FirebaseFirestore.instance;
Future<void> deleteProduct(DocumentSnapshot doc) async {
  await _fireStore.collection("leaves").doc("casual").collection(loggedInUSer.email).doc().delete();
}


class CasualLeaveListPage extends StatefulWidget {
  @override
  _CasualLeaveListPageState createState() => _CasualLeaveListPageState();
}

class _CasualLeaveListPageState extends State<CasualLeaveListPage> {

  final _fireStore = FirebaseFirestore.instance;




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
  final String reason;
  final DocumentSnapshot documentSnapshot;
  LeaveItems({this.date, this.documentSnapshot,this.reason});

  @override
  _LeaveItemsState createState() => _LeaveItemsState();
}

class _LeaveItemsState extends State<LeaveItems> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Row(
          children: [
            Container(
              height: 100,
              width: 150,
              child: Text(widget.date),
            ),
            // Container(
            //   height: 100,
            //   width: 150,
            //   child: Text(widget.reason),
            // ),
          ],
        ),
        IconButton(
          onPressed: () {
            deleteProduct(widget.documentSnapshot);
          },
          icon: Icon(
            Icons.delete,
            color: Colors.redAccent,
          ),
        ),
      ],
    );
  }
}
