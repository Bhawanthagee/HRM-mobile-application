import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:login_ui/dialogBox/alreadyMarkedAttendence.dart';
import 'package:login_ui/dialogBox/attendece.dart';

import 'package:login_ui/screans/home.dart';

class EarlyCheckOutSL extends StatefulWidget {
  @override
  _EarlyCheckOutSLState createState() => _EarlyCheckOutSLState();
}

class _EarlyCheckOutSLState extends State<EarlyCheckOutSL> {
  final _fireStore = FirebaseFirestore.instance;
  String descriptionTxt, formattedTimeOut, formattedDateIn;
  Address _address;
  DateTime timeNow = DateTime.now();
  int shortLeave;

  void currentHalfDayOrShortLeave(){
    _fireStore.collection('HalfD_Short').doc(loggedInUSer.email).set({
      'stat':'1'
    });
  }

  void reductionShortLeave()async{
    DocumentSnapshot variable =
    await _fireStore.collection('short leave Counter').doc(loggedInUSer.email).get();
    String v = variable['count'];
    shortLeave = int.parse(v);
    print('remainig shotr leaves :  $shortLeave');
    setState(() {

    });

  }
  String SLCal(){
    shortLeave = shortLeave-1;
    String sL = shortLeave.toString();
    return sL;
  }

  final _formKey = GlobalKey<FormState>();
  StreamSubscription<Position> _streamSubscription;

  @override
  void initState() {
    super.initState();
    reductionShortLeave();
    _streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
          if (mounted)
            setState(() {
              final coordinates =
              Coordinates(position.latitude, position.longitude);
              convertCoordinatesToAddress(coordinates)
                  .then((value) => _address = value);
            });
        });
  }

  Future<Address> convertCoordinatesToAddress(Coordinates coordinates) async {
    var addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first;
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Early Leave (Short Leave)'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  //color: Colors.red,
                  image: DecorationImage(
                    image: AssetImage('assets/images/late.png'),
                  ),
                ),
              ),
              Container(
                child: Text(
                    'You are checking out early\nyour checkOut has been marked\nbut one of your short leave has been deducted',
                    textAlign: TextAlign.center),
              ),
              Container(
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: TextStyle(color: Colors.black, fontSize: 25.0),
                              children: [
                                TextSpan(
                                  text: 'Time\n',
                                ),
                                TextSpan(
                                    text: '${timeNow.hour}:${timeNow.minute} ',
                                    style: TextStyle(
                                        color: Colors.black45, fontSize: 18.0))
                              ]),
                        )),
                    Expanded(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: TextStyle(color: Colors.black, fontSize: 25.0),
                              children: [
                                TextSpan(
                                  text: 'Date\n',
                                ),
                                TextSpan(
                                    text:
                                    '${timeNow.year} / ${timeNow.month} / ${timeNow.day}',
                                    style: TextStyle(
                                        color: Colors.black45, fontSize: 18.0))
                              ]),
                        )),
                    // Expanded(
                    //     child: Text('Time',textAlign: TextAlign.center)
                    // ),
                  ],
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                    child: TextFormField(
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return " Description can not be emplty";
                          }
                        },
                        maxLines: 3,
                        onChanged: (value) {
                          descriptionTxt = value;
                        },
                        decoration: InputDecoration(
                          labelText: "Please Enter The Reason For The Delay",
                          helperText: "",
                          labelStyle:
                          TextStyle(fontSize: 14, color: Colors.black),
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
                  ),
                ),
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: FlatButton(
                  onPressed: () async {
                    //currentHalfDayOrShortLeave();
                    if (_formKey.currentState.validate()) {
                      DateTime date = timeNow;
                      String formattedDateOut = DateFormat('dd-M-yyyy').format(date);
                      String formattedTime = DateFormat('hh:mm ').format(date);
                      print(date);
                      // Navigator.pop(context);
                      print(formattedDateOut);
                      print(formattedTime);

                      DateTime time = DateTime.now();

                      formattedDateOut = DateFormat('dd-M-yyyy').format(time);
                      formattedDateOut='"$formattedDateOut"';
                      formattedTimeOut = DateFormat('kk:mm').format(time);
                      try {
                        if(shortLeave==0){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AttendenceCheckIn(title: 'No Short Leaves left');
                              });
                        }else {
                          DocumentSnapshot variable =
                          await _fireStore.collection('out').doc(loggedInUSer.email).get();
                          String v = variable['outStat'];
                          int stat = int.parse(v);
                          if(stat!=1){
                            _fireStore.collection('leaves').doc('short leave').collection(loggedInUSer.email).doc().set({
                              'date': formattedDateOut,
                              'time': formattedTime,
                              'Description': descriptionTxt,
                            });
                            _fireStore
                                .collection("attendance")
                                .doc("$formattedDateOut")
                                .collection(loggedInUSer.email)
                                .doc('check out')
                                .set({
                              'check out time': formattedTimeOut,
                              'check out Location':
                              '${_address?.addressLine ?? '-'}',
                              'Attendance type': 'Short Leave(Early check Out)'
                              //'stat':1
                            });
                            _fireStore.collection('short leave Counter').doc(loggedInUSer.email).set(
                                {
                                  'count' : SLCal()//todo need to update firebase properly not working because its uploading int must upload String
                                });

                            _fireStore
                                .collection('out')
                                .doc(loggedInUSer.email)
                                .set({
                              'outStat': '0',
                            });
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Attendance('checked out Successfully');
                                });
                          }else{
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AttendenceCheckIn(title: 'Already check out');
                                });
                          }
                        }
                      } catch (e) {  print(e);}


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
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
