import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/dialogBox/doneDialogBox.dart';
import 'package:login_ui/screans/home.dart';

class MeetingRequest extends StatefulWidget {
  @override
  _MeetingRequestState createState() => _MeetingRequestState();
}

class _MeetingRequestState extends State<MeetingRequest> {
  final _key = GlobalKey<FormState>();
  String person,description,reason,position;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  meetingReqUpload(){
    _fireStore.collection('meeting_request').doc().set({
      'person': person,
      'position' : position,
      'description':description,
      'email' : loggedInUSer.email,
      'reason': reason
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meeting Request'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top:5.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height*.3,
                    width: MediaQuery.of(context).size.width*.8,
                    decoration: BoxDecoration(
                      //color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40),
                        ),
                        image: DecorationImage(
                            image: AssetImage('assets/images/meetingRequest.png'),
                            fit: BoxFit.fitHeight

                        )
                    ),

                  ),
                ),
              ),
              Form(
                key:_key,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                                  onChanged: (value) {
                                    person = value;
                                  },
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return " field can not be emplty";
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Requested Person Name",
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
                                  )

                              )
                          ),
                          SizedBox(width: 10,),
                          Expanded(child: TextFormField(
                              onChanged: (value) {
                                position = value;
                              },
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return " field can not be emplty";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "position",
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
                              )
                          )
                          )
                        ],
                      ),

                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 8,left: 18,right: 18
                      ),
                      child: TextFormField(

                          onChanged: (value) {
                            description = value;
                          },
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return " field can not be emplty";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Reason",
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
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 8,left: 18,right: 18
                      ),
                      child: TextFormField(
                          maxLines: 3,
                          onChanged: (value) {
                            reason = value;
                          },
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return " field can not be emplty";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Description",
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
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:58.0,right: 58,top: 28),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        child: FlatButton(
                          onPressed: () async {
                            if (_key.currentState.validate()){
                              meetingReqUpload();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DoneDialogBox('Request Submitted');
                                  });
                              Navigator.pop(context);
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
                                "Submit",
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
                    ),
                  ],
                ),

              )
            ],
          ),

        ),
      ),
    );
  }
}
