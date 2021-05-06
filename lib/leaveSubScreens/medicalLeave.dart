import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:login_ui/dialogBox/alreadyMarkedAttendence.dart';
import 'package:login_ui/dialogBox/doneDialogBox.dart';
import 'package:login_ui/screans/home.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MedicalLeaveReq extends StatefulWidget {
  @override
  _MedicalLeaveReqState createState() => _MedicalLeaveReqState();
}

class _MedicalLeaveReqState extends State<MedicalLeaveReq> {

  String imageLink,formattedDateStart,formattedDateEnd,countA;
  double remainingLeaveCount,percentage=0.0,count;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.reference();
  File _image;
  String reason;
  final _key = GlobalKey<FormState>();
  DateTime _dateStart,_dateEnd;


  Future getImage()async{
    final image =await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    print("image name : $_image");
  }
  Future uploadImage(BuildContext context)async{
    String fileName = (_image.path);
    final _firebaseStorage = FirebaseStorage.instance;

    _firebaseStorage.ref().child('uploads/$fileName').putFile(_image);

  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
    if (mounted) {
      setState(() {
        remainingLeaveCounter();
      });
    }
  }

  // void updateCasualLeave()async{
  //   DocumentSnapshot variable = await _fireStore.collection('Leave counter').doc(loggedInUSer.email).get();
  //   int l = variable['remaining leaves'];
  //   //var l = int.parse(v);
  //   l=l-1;
  //   _fireStore.collection('Leave counter').doc(loggedInUSer.email).set({
  //     "remaining leaves" : l
  //   });
  // }
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

  void remainingLeaveCounter()async{
    try{
      DocumentSnapshot variable = await _fireStore.collection('medicalLeaveCount').doc(loggedInUSer.email).get();
      String v = variable['remaining leaves'].toString();
      remainingLeaveCount = double.parse(v);
      percentage = remainingLeaveCount/2*.1;
      if (mounted) {
        setState(() {
          // Your state change code goes here
        });
      }

      print( percentage);
    }
    catch(e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {

    void remainingLeaveCounter()async{
      try{
        DocumentSnapshot variable = await _fireStore.collection('medicalLeaveCount').doc(loggedInUSer.email).get();
        remainingLeaveCount = variable['remaining leaves'];
        //remainingLeaveCount = double.parse(v);
        percentage = remainingLeaveCount/2*.1;
        if (mounted) {
          setState(() {
            // Your state change code goes here
          });
        }

        print( percentage);
      }
      catch(e){
        print(e);
      }
    }

    return Scaffold(


      body: SingleChildScrollView(
        child: Column(

          children: [
            Container(
              height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    )
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top:48.0),
                    child: CircularPercentIndicator(
                      radius: 180,
                      center: Text("$remainingLeaveCount days", style: TextStyle(fontSize: 25,color: Colors.black54 ),),//TODO need to call a another method for show remaining leave count
                      progressColor: Colors.red,
                      percent: percentage,//TODO i need to call a method for getting used leave count in percentage
                      lineWidth: 12,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ),
                ),

              ),

            Form(
              key: _key,
              child: Column(

                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:18.0 , right: 18,top: 28),
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
                        padding: const EdgeInsets.only(top:18.0, right: 18.0,left: 18.0,bottom: 15),
                        child: Row(
                          children: [
                           Expanded(child:
                           GestureDetector(
                             onTap: (){
                               _dateStart = DateTime.now();
                               setState(() {
                                 formattedDateStart =DateFormat('dd-M-yyyy').format(_dateStart);
                               });
                             },
                             child:  CustomContainer(color: Color(0xFF431ff2),text: formattedDateStart==null?'Select Start Date':formattedDateStart),
                           )),
                            Expanded(child:
                            GestureDetector(
                              onTap: (){
                                showDatePicker(context: context,
                                    initialDate: _dateEnd==null?DateTime.now():_dateEnd,
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2022)
                                ).then((date) {
                                  setState(() {
                                    _dateEnd=date;
                                    formattedDateEnd = DateFormat('dd-M-yyyy').format(_dateEnd);
                                  });
                                });

                              },
                              child: CustomContainer(color: Color(0xFF990000), text:formattedDateEnd==null?'Select End Date':formattedDateEnd,),
                            )),

                          ],
                        ),
                      ),
                  Padding(
                    padding: const EdgeInsets.only(top:18.0, left: 18, right: 18),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child:  TextFormField(
                              onChanged: (value) {
                                countA = value ;
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
                            child: Text('How many days Are you willing to take medical leave',style: TextStyle(fontWeight: FontWeight.bold),))
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: _image==null?Center(child: Text('Upload medical Report here')):Image.file(_image),
                  ),SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left:58.0,right: 58),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      child: FlatButton(
                        onPressed: () async {
                          double d = double.parse(countA);
                          double a = remainingLeaveCount-d;


                          if (_key.currentState.validate()){
                            if(remainingLeaveCount<d){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AttendenceCheckIn(title: 'Not enough Medical leaves',);
                                  });
                            }
                           else if(remainingLeaveCount==0){
                             showDialog(
                                 context: context,
                                 builder: (BuildContext context) {
                                   return AttendenceCheckIn(title: 'Out of medical Leaves',);
                                 });
                           }else{
                             if(formattedDateStart==null || formattedDateEnd==null || _image ==null){
                               showDialog(
                                   context: context,
                                   builder: (BuildContext context) {
                                     return AttendenceCheckIn(title: 'Required Field is empty',);
                                   });
                             }
                             else{
                               print(loggedInUSer.email);
                               print(countA);
                               print(remainingLeaveCount);
                               print(a);
                               await _fireStore.collection('Medical_Leave').doc().set({
                                 'email':loggedInUSer.email,
                                 'number_of_days':countA,
                                 'starting_date':formattedDateStart,
                                 'end_date':formattedDateEnd,
                                 'reason':reason,
                                 'image_URL':"usr"

                               });

                               DocumentSnapshot variable = await _fireStore.collection('leave_counter').doc(loggedInUSer.email).get();
                               int l = variable['r_leave'];
                               //var l = int.parse(v);
                               int value = int.parse(countA);
                               l=l-value;
                               _fireStore.collection('leave_counter').doc(loggedInUSer.email).set({
                                 "r_leave" : l
                               });

                               _fireStore.collection('medicalLeaveCount').doc(loggedInUSer.email).set({
                                 'remaining leaves':a
                               });
                               showDialog(
                                   context: context,
                                   builder: (BuildContext context) {
                                     return DoneDialogBox('Medical Leave Submitted');
                                   });
                             }

                           }

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
                  )

              ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: getImage,
        icon: Icon(Icons.camera),
        label: Text('Select Image'),
      ),

    );
  }
}

class CustomContainer extends StatelessWidget {
final String text;
final Color color;

  const CustomContainer({Key key, this.text, this.color}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20,right: 25),
      height: 30,
        decoration: BoxDecoration(
            color:color,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            )
        ),
      child: Center(
        child: Text(text, style: TextStyle(color: Colors.white),),
      ),


    );
  }
}
// child: _image==null?Text('not picked'):Image.file(_image),
// _fireStore.collection('Medical_Leave').doc().set({
// 'Email':loggedInUSer.email,
// 'number of days':countA,
// 'starting date':formattedDateStart,
// 'end date':formattedDateEnd,
// 'reason':reason,
// 'image URL':"usr"
//
// });