import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:login_ui/dialogBox/alreadyMarkedAttendence.dart';
import 'package:login_ui/dialogBox/doneDialogBox.dart';
import 'package:login_ui/late%20check%20in%20and%20out/early_check_out_halfday.dart';
import 'package:login_ui/late%20check%20in%20and%20out/earlycheckout.dart';

import 'package:login_ui/late%20check%20in%20and%20out/lateAttHalfDay.dart';
import 'package:login_ui/late%20check%20in%20and%20out/lateAttShortLeave.dart';


User loggedInUSer;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUSer = user;
        print(loggedInUSer.email);
        print(loggedInUSer.uid);
      }
    } catch (e) {
      print(e);
    }
  }





  var textMsg;
  int leaveStatus;

  // int attStatus,attStatus1;
  int buttonValue;
  DateTime dateNow = DateTime.now();
  DateTime timeNow = DateTime.now();
  Address _address;
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  User currentUSerEmail;
  String inLocation, outLocation,
      addressOk, inTime,
      outTime, formattedDateIn,
      formattedDateOut,
      formattedTimeIn,
      formattedTimeIn2,
      formattedTimeOut,
      formattedTimeOut2,formattedDateIn3;

  //String userId = loggedInUSer.uid.toString();

  StreamSubscription<Position> _streamSubscription;
  final dbRef = FirebaseDatabase.instance.reference();
  void calLeave()async{
    DocumentSnapshot variable = await _fireStore.collection('already_got_HD_or_SL').doc(loggedInUSer.email).get();
    String v = variable['stat'].toString();
    leaveStatus = int.parse(v);
    //remainingLeave = double.parse(v);
    //print('remaining leave $remainingLeave' );
  }
  refreshShortLeave(){
    DateTime date = DateTime.now(); 
    String refreshSLDate = DateFormat('dd').format(date);
    int fDate = int.parse(refreshSLDate);
    if(fDate==1){
      _fireStore.collection('short leave Counter').doc(loggedInUSer.email).set({
        'count' : '2'
      });
    }else{
      print('Its not the beginning ogf the month bawantha');
      print('Today is $fDate bawantha');
    }

  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    calLeave();
    attStatus();
    refreshShortLeave();
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
// method that allows app to check already check in or out...........
  void attStatus() async{

    DateTime attDate = DateTime.now();
    formattedDateIn3 = DateFormat('dd').format(attDate); //converting date in to string
    print(formattedDateIn3);

    int fDate = int.parse(formattedDateIn3);
    DocumentSnapshot variable = await _fireStore.collection('attDate').doc(loggedInUSer.email).get(); //retrieving current firebase value.
    String v = variable['today'];
    int i = int.parse(v);
    print('firebase date: '+v+ 'converted value is $i');

    String attendeceFormatDate = DateFormat('MMM d, yyyy').format(attDate);
    print(attendeceFormatDate);
   if(fDate!=i){
     //checking whether current date and firebase stored dates are not equal
     // if those two values are not equal. set attendance to 0 otherwise it will do nothing
     _fireStore.collection('in').doc(loggedInUSer.email).set({
       'inStat': '0',
     });
     _fireStore.collection('out').doc(loggedInUSer.email).set({
       'outStat': '0',
     });
     _fireStore.collection('attDate').doc(loggedInUSer.email).set({
       'today': '$formattedDateIn3', //setting firebase date to today's date..
     });
   }
  }

// method that responsible for check in process
  void checkInWriteData() async  {
    try {
      int i = int.parse(formattedTimeIn2);
      DocumentSnapshot variable =
          await _fireStore.collection('in').doc(loggedInUSer.email).get();
      String v = variable['inStat'];
      int stat = int.parse(v);
      print(stat);

      if (stat != 1) { //check in weather user also check in or not
        if (i <830) {//its 8:30 am. check employee late or not
          _fireStore.collection("check_in").doc().set({
            'email':loggedInUSer.email,
            'check_in_time': formattedTimeIn,
            'check_in_location': '${_address?.addressLine ?? '-'}',
            //'Attendance type': 'Regular'
            //'stat':1
          });

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return DoneDialogBox('checked in Successfully');
              });

          _fireStore.collection('in').doc(loggedInUSer.email).set({
            'inStat': '1',
          });
        } else if(i<930){
          print('you r late this will be a short leave');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return LateAttShortLeaveType();
              });
        }else if(i<1030){
//LateAttHalfDayLeaveType
          Navigator.push(context,MaterialPageRoute(builder:
              (context)=>LateAttHalfDayLeaveType()));
        }else{
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AttendenceCheckIn(title: 'U can not Mark Attendance');
              });
        }
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AttendenceCheckIn(title: 'Already check In');
            });
      }
    } catch (e) {}
  }
// method that responsible for check out process
//   void checkOutWriteData1() async {
//     DocumentSnapshot variable =
//     await _fireStore.collection('out').doc(loggedInUSer.email).get();
//     String v = variable['outStat'];
//     int stat = int.parse(v);
//
//     if(stat ==1){
//       showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AttendenceCheckIn(title: 'Already check out');
//           });
//     }else{
//       try {
//         int i = int.parse(formattedTimeOut2);//converting time in to int value
//         if(leaveStatus==1){
//           showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AttendenceCheckIn(title: 'You are already got a short/half day leave');
//               });
//         }else if(i<1630){
//           showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return EarlyCheckOutSL();
//               });
//         }
//         else{
//           DocumentSnapshot variable =
//           await _fireStore.collection('out').doc(loggedInUSer.email).get();
//           String v = variable['outStat'];
//           int stat = int.parse(v);
//           print(stat);
//
// // in here i get get check in value. so i can check if user must check in first or not
//           DocumentSnapshot variable2 =
//           await _fireStore.collection('in').doc(loggedInUSer.email).get();
//           String v2 = variable2['inStat'];
//           int stat2 = int.parse(v2);
//           print('check in status: $stat2');
//
//           if (stat2 == 0) {//check whether user already check in or not
//             showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AttendenceCheckIn(title: 'You must checked in first');
//                 });
//           } else {
//             if (stat != 1) {//if he checked in update checkout field of firebase
//               _fireStore.collection("attendance").doc("$formattedDateOut").collection(loggedInUSer.email).doc('check out').set({
//                 'check in time': formattedTimeOut,
//                 'check out Location': '${_address?.addressLine ?? '-'}',
//                 // 'stat':1
//               });
//               showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return Attendance('checked out Successfully');
//                   });
//               _fireStore.collection('out').doc(loggedInUSer.email).set({
//                 'outStat': '1',
//               });
//             } else {
//               showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AttendenceCheckIn(title: 'Already check out');
//                   });
//             }
//           }
//         }
//         //getting value from firebase 0 or 1. if 0 means not check in 1 means checked out
//
//       } catch (e) {}
//     }
//   }
  void checkOutWriteData()async{

    int i = int.parse(formattedTimeOut2);// converting date in to int so i can check time easily

    DocumentSnapshot variable2 =
    await _fireStore.collection('in').doc(loggedInUSer.email).get();
    String v2 = variable2['inStat'];
    int stat2 = int.parse(v2);
    print('check in status: $stat2');

    DocumentSnapshot variable =
    await _fireStore.collection('out').doc(loggedInUSer.email).get();
    String v = variable['outStat'];
    int stat = int.parse(v);
    print(stat);

    if (stat2 == 0) {//check whether user already check in or not
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AttendenceCheckIn(title: 'You must checked in first');
          });
    }else if(stat==1){//checking user already check out or not
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AttendenceCheckIn(title: 'You have already check out');
          });
    }else if(leaveStatus==1){// checking user already got a half day or not
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AttendenceCheckIn(title: 'You are already got a short/half day leave');
          });
    }else {
      if(i<1130){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AttendenceCheckIn(title: 'You cannot check out yet');
            });
      }
      else if(i>1130 && i<1530){
        Navigator.push(context, MaterialPageRoute(builder: (context) => EarlyCheckOutHD()));
        print('This is a half day');
      }else if(i<1630){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return EarlyCheckOutSL();
            });
      }else{//if user check out right time. following will happen
        _fireStore.collection("check_out").doc().set({
          'email': loggedInUSer.email,
          'check_in_time': formattedTimeOut,
          'check_out_location': '${_address?.addressLine ?? '-'}',
          // 'stat':1
        });
        _fireStore.collection('already_got_HD_or_SL').doc(loggedInUSer.email).set({
          'stat': '0',
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return DoneDialogBox('checked out Successfully');
            });
        _fireStore.collection('out').doc(loggedInUSer.email).set({
          'outStat': '1',
        });
      }
    }
  }

//TODO create a method to get firebase value
  bool defaultVal() {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
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
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                    //Text("Sign in to continue!,",style: TextStyle(fontSize: 20,color: Colors.grey.shade400),),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            height: 300,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/checkIn.png'),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Mark Your Attendance Here,",
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade400),
                    ),
                    SizedBox(
                      height: 75,
                    ),
                    Center(
                        child: Column(
                      children: [
                        Text(
                            '${dateNow.year} / ${dateNow.month} / ${dateNow.day} '),
                        Text('${timeNow.hour} : ${timeNow.minute}'),
                        Text('${_address?.addressLine ?? '-'}'),
                      ],
                    )),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                              color: Colors.blue,
                              textColor: Colors.white,
                              child: Text('Check in'),
                              onPressed: () {
                                DateTime time = DateTime.now();
                                timeNow = time;
                                formattedDateIn = DateFormat('dd-M-yyyy').format(timeNow);
                                formattedDateIn ='"$formattedDateIn';
                                formattedTimeIn =
                                    DateFormat('kk:mm').format(timeNow);
                                formattedTimeIn2 =
                                    DateFormat('kkmm').format(timeNow);
                                print(
                                    'checked in date $formattedDateIn checked in time: $formattedTimeIn ');
                                print(formattedTimeIn2);
                                //print(loggedInUSer.email);
                                checkInWriteData();
                              }),
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                              color: Colors.redAccent,
                              textColor: Colors.white,
                              child: Text('Check out'),
                              onPressed: () {
                                DateTime time = DateTime.now();
                                timeNow = time;
                                formattedDateOut =
                                    DateFormat('dd-M-yyyy').format(timeNow);
                                formattedDateOut = '"$formattedDateOut"';
                                formattedTimeOut =
                                    DateFormat('kk:mm').format(timeNow);
                                formattedTimeOut2 =
                                    DateFormat('kkmm').format(timeNow);
                                print(
                                    'checked out date $formattedDateOut checked out Time: $formattedTimeOut');
                                print(formattedTimeOut2);
                                checkOutWriteData();
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

