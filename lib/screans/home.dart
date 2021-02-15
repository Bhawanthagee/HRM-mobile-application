import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:login_ui/dialogBox/alreadyChecked.dart';
import 'package:login_ui/dialogBox/attendece.dart';


User loggedInUSer;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();


}

class _HomeState extends State<Home> {

  void getCurrentUser()async{
    try{
      final user = _auth.currentUser;
      if(user!=null){
        loggedInUSer = user ;
        print(loggedInUSer.email);
        print(loggedInUSer.uid);
      }}
    catch(e){
      print(e);
    }
  }


  var textMsg;
  int attStatus,attStatus1;
  int buttonValue;
  DateTime dateNow= DateTime.now();
  DateTime timeNow=DateTime.now();
  Address _address;
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  User currentUSerEmail;
  String inLocation, outLocation,addressOk,inTime, outTime,formattedDateIn,
      formattedDateOut,formattedTimeIn,formattedTimeOut;
  
  //String userId = loggedInUSer.uid.toString();

  StreamSubscription<Position> _streamSubscription;
  final dbRef = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
     getCurrentUser();
    _streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
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



  void writeData()async{
  try{

    // DocumentSnapshot variable = await _fireStore.collection('attendance').doc(formattedDateIn).collection(loggedInUSer.email).doc('check in').get();
    // String v = variable['stat'].toString();
    // attStatus = int.parse(v);
    // print (v);
    // if(attStatus==1){
    //   showDialog(context: context,
    //       builder: (BuildContext context){
    //         return AlreadyChecked('You Have Already Check in');
    //
    //       });
    // }else{
      _fireStore.collection("attendance").doc(formattedDateIn).collection(loggedInUSer.email).doc('check in').set({

        'check in time' : formattedTimeIn,
        'check in Location': '${_address?.addressLine ?? '-'}',
        'stat':1
      });
      _fireStore.collection("attendance").doc(formattedDateIn).collection(loggedInUSer.email).doc('check out').set({

        'check in time' : '',
        'check out Location': '',
        'stat':0
      });

      showDialog(context: context,
          builder: (BuildContext context){
            return Attendance('checked in Successfully');

          });
    // }




  }catch(e){}
  }
  void updateData()async{
  try{

    // DocumentSnapshot variable = await _fireStore.collection('attendance').doc(formattedDateIn).collection(loggedInUSer.email).doc('check out').get();
    // String v = variable['stat'].toString();
    // attStatus1 = int.parse(v);
    // print (v);
    // if(attStatus1==1){
    //   showDialog(context: context,
    //       builder: (BuildContext context){
    //         return AlreadyChecked('You Have Already Check Out');
    //
    //       });
    // }else{
      _fireStore.collection("attendance").doc(formattedDateIn).collection(loggedInUSer.email).doc('check out').set({

        'check in time' : formattedTimeOut,
        'check out Location': '${_address?.addressLine ?? '-'}',
        'stat':1
      });
      showDialog(context: context,
          builder: (BuildContext context){
            return Attendance('checked out Successfully');
          });
    //}




  } catch(e){}
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
                        Text('${dateNow.year} / ${dateNow.month} / ${dateNow.day} '),
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
                                formattedDateIn = DateFormat(' dd-M-yyyy').format(timeNow);
                                formattedTimeIn = DateFormat('kk:mm').format(timeNow);
                                print('checked in date $formattedDateIn checked in time: $formattedTimeIn ');
                                //print(loggedInUSer.email);
                                writeData();

                              }),
                          SizedBox(width: 10,),
                          RaisedButton(
                              color: Colors.redAccent,
                              textColor: Colors.white,
                              child: Text('Check out'),
                              onPressed: () {
                                writeData();
                                DateTime time = DateTime.now();
                                timeNow = time;
                                formattedDateOut = DateFormat(' dd-M-yyyy').format(timeNow);
                                formattedTimeOut = DateFormat('kk:mm').format(timeNow);
                                print('checked out date $formattedDateOut checked out Time: $formattedTimeOut');
                                updateData();
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



// Center(
//                       child: Container(
//                         height: 80,
//                         width: 250,
//                         child: FlatButton(
//                           onPressed: (){
//                             //this can be change according to future improvements
//                             //Navigator.push(context,MaterialPageRoute(builder:(context)=>Nav()));
//                             // Navigator.push(context,MaterialPageRoute(builder:(context)=>MyHomePage()));
//                           },
//                           child: Ink(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(6),
//                                 gradient: LinearGradient(
//                                     begin: Alignment.centerLeft,
//                                     end: Alignment.centerRight,
//                                     colors: [
//                                       Color(0xfc99000c),
//                                       Color(0xffc70413),
//                                       Color(0xfffacdd0),
//                                     ]
//                                 )
//                             ),
//                             child: Container(
//                               alignment: Alignment.center,
//                               constraints: BoxConstraints(maxWidth: double.infinity, minHeight: 50),
//                               child:Text("Check Out",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
//                             ),
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                         ),
//                       ),
//                     ),
