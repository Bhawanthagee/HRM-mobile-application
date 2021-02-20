import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:login_ui/custom items/constants.dart';
import 'package:login_ui/screans/googleNav.dart';
import 'package:login_ui/screans/home.dart';



class LateCheckIn extends StatefulWidget {

  @override
  _LateCheckInState createState() => _LateCheckInState();
}

class _LateCheckInState extends State<LateCheckIn> {
   Address _address;

   StreamSubscription<Position> _streamSubscription;

   @override
   void initState() {
     super.initState();

     _streamSubscription = Geolocator.getPositionStream().listen((Position position) {
       if(mounted)setState(() {
         final coordinates = Coordinates(position.latitude, position.longitude);
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
    final _fireStore = FirebaseFirestore.instance;


    DateTime timeNow = DateTime.now();
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)
        ),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 350,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [

                    Text('You Are Late', textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    SizedBox(height: 10.0,),
                    Text('so your attendance will record as a short leave',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),),
                    SizedBox(height: 45,),
                    Text(' ${timeNow.year} / ${timeNow.month} / ${timeNow.day}',style: Constants.timeAndDateTxt,),
                    Text(' ${timeNow.hour} : ${timeNow.minute} ',style: Constants.DateTxt,),
                    SizedBox(height: 35,),
                    RaisedButton(onPressed: () {
                      DateTime date =timeNow;
                      String formattedDateIn = DateFormat('dd-M-yyyy').format(date);
                      String formattedTime = DateFormat('hh:mm ').format(date);
                      print(date);
                      Navigator.pop(context);
                      print(formattedDateIn);
                      print(formattedTime);

                      try{
                        _fireStore.collection('leaves').doc('short leave').collection(loggedInUSer.email).doc().set({
                          'date' :formattedDateIn,
                          'time' :formattedTime,
                        });
                        _fireStore.collection("attendance").doc(formattedDateIn).collection(loggedInUSer.email).doc('check in').set({

                          'check in time' : formattedTime,
                          'check in Location': '${_address?.addressLine ?? '-'}',
                          'Attendance type':'short leave'
                          //'stat':1
                        });
                      }catch(e){

                      }


                      Navigator.push(context,MaterialPageRoute(builder:(context)=>MyHomePage()));
                      print(timeNow);
                    },
                      color: Colors.blueAccent,
                      child: Text('Submit', style: TextStyle(color: Colors.white),),
                    ),


                  ],
                ),
              ),
            ),
            Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.lightGreen,
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/shortLeave.gif'),
                )
            ),
          ],
        )
    );
  }
}




