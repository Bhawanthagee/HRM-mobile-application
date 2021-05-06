import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_ui/custom items/constants.dart';
import 'package:login_ui/leaveSubScreens/dutyLeave.dart';
import 'package:login_ui/screans/googleNav.dart';






class HalfDayEvent extends StatelessWidget {

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
              height: 290,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text('Half Day Leave', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    SizedBox(height: 50,),
                    Text(' ${timeNow.year} / ${timeNow.month} / ${timeNow.day}',style: Constants.timeAndDateTxt,),
                    Text(' ${timeNow.hour} : ${timeNow.minute} ',style: Constants.DateTxt,),
                    SizedBox(height: 35,),
                    RaisedButton(onPressed: () async{
                      DateTime date =timeNow;
                      String formattedDateIn = DateFormat('dd-M-yyyy').format(date);
                      String formattedTime = DateFormat('hh:mm ').format(date);
                      print(date);
                      Navigator.push(context,MaterialPageRoute(builder:(context)=>MyHomePage()));
                      print(formattedDateIn);
                      print(formattedTime);

                      try{
                        _fireStore.collection('Half_Day').doc().set({
                          'email' : loggedInUSer.email,
                          'date' :formattedDateIn,
                          'time' :formattedTime,
                        });
                        DocumentSnapshot variable = await _fireStore.collection('leave_counter').doc(loggedInUSer.email).get();
                        double l = variable['r_leave'];
                        //var l = int.parse(v);
                        double v = l.toDouble();
                        v=l-0.5;
                        _fireStore.collection('leave_counter').doc(loggedInUSer.email).set({
                          "r_leave" : v
                        });
                        //print('deduction : $v');
                      }catch(e){

                      }
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
                  backgroundImage: AssetImage('assets/images/mid2.gif'),
                )
            ),
          ],
        )
    );
  }
}




