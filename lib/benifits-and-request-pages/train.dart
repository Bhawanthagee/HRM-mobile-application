import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_ui/dialogBox/doneDialogBox.dart';
import 'package:login_ui/leaveSubScreens/dutyLeave.dart';

class TrainPass extends StatefulWidget {
  @override
  _TrainPassState createState() => _TrainPassState();
}

class _TrainPassState extends State<TrainPass> {

  String begging;
  String destionation;
  String name;
  String count;
  String date,dateTime;
  DateTime _date;
  final _fireStore = FirebaseFirestore.instance;


  final _key = GlobalKey<FormState>();
  void uploadFireStore(){
    _fireStore.collection('train_pass_req').add({
      'email':loggedInUSer.email,
      'from' : begging,
      'to': destionation,
      'date': dateTime,
      'ticket_count': count,
      'name' : name
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Apply Train Pass"),
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(28.0),
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
                        image: AssetImage('assets/images/trainImage2.png'),
                        fit: BoxFit.fitHeight

                    )
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Form(
             key: _key,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                                onChanged: (value) {
                                  begging = value;
                                },
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return " field can not be emplty";
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: "Begging",
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
                              destionation = value;
                            },
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return " field can not be emplty";
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Destination",
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
                    SizedBox(height: 20,),
                    TextFormField(
                      maxLines: 2,
                        onChanged: (value) {
                          name = value;
                        },
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return " field can not be emplty";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Name",
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
                    SizedBox(height: 20,),
                   Row(
                     children: [
                       Expanded(
                         flex: 1,
                         child:  TextFormField(
                           onChanged: (value) {
                             count = value;
                           },
                             validator: (value) {
                               if (value.trim().isEmpty) {
                                 return " field can not be emplty";
                               }
                             },
                           decoration: InputDecoration(
                             labelText: "Count",
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
                       ),),
                       SizedBox(width: 20,),
                       Expanded(
                         flex: 3,
                           child: Text('You can only book tickets for family members',style: TextStyle(fontWeight: FontWeight.bold),))
                     ],
                   ),
                    SizedBox(height: 20,),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: FlatButton(
                        onPressed: () async {
                          showDatePicker(context: context,
                              initialDate: _date==null?DateTime.now():_date,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2022)
                          ).then((date) {
                            setState(() {
                              _date=date;
                            });
                          });

                        },
                        child: Ink(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xff0021f5),
                                    Color(0xff2238c7),
                                    Color(0xffa7b1f2),
                                  ])),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(
                                maxWidth: double.infinity, minHeight: 50),
                            child: Text(
                              "Select Date",
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
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left:58.0,right: 58),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        child: FlatButton(
                          onPressed: () async {
                            dateTime = DateFormat('dd-M-yyyy').format(_date);

                            if (_key.currentState.validate()){
                              print('$dateTime \n $name \n $count \n $begging \n $destionation');
                              uploadFireStore();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DoneDialogBox('Request successfully uploaded');
                                  });
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
              ),
            ),
          )


          ],
        ),
      ),
    );
  }
}
