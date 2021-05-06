import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/leaveSubScreens/casualLeavesSubmission.dart';
import 'package:login_ui/leaveSubScreens/dutyLeave.dart';
import 'package:login_ui/leaveSubScreens/medicalLeave.dart';
import 'package:login_ui/leave_events/halfDay.dart';
import 'package:login_ui/leave_events/short_Leave_event.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LeaveRequest extends StatefulWidget {
  @override
  _LeaveRequestState createState() => _LeaveRequestState();
}
class _LeaveRequestState extends State<LeaveRequest> {

  double remainingLeaveCount,percentage=0.0;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final dbRef = FirebaseDatabase.instance.reference();
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;

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
      DocumentSnapshot variable = await _fireStore.collection('leave_counter').doc(loggedInUSer.email).get();
      String v = variable['r_leave'].toString();
      remainingLeaveCount = double.parse(v);
      percentage = remainingLeaveCount/4*.1;
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
        DocumentSnapshot variable = await _fireStore.collection('leave_counter').doc(loggedInUSer.email).get();
        String v = variable['r_leave'].toString();
        remainingLeaveCount = double.parse(v);
        percentage = remainingLeaveCount/4*.1;
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

      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,

        title: Text("Request Leave"),
        shadowColor: Colors.transparent,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        )
                    ),
                    child: Center(
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
                 SizedBox(height: 10,),
                 Expanded(
                   flex: 1,
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       SizedBox(width:15,),
                       Text(
                           'Select your Leave category',
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 20,
                         ),
                       ),
                     ],
                   ),
                 ),
                 SingleChildScrollView(
                   child: Expanded(
                     flex: 6,
                     child:Column(
                       children: [
                         Container(
                           child: Row(
                               children: [
                                 Expanded(
                                   child: GestureDetector(
                                     onTap: (){
                                       Navigator.push(context,MaterialPageRoute(builder:(context)=>CasualLeavesSubmission()));
                                       // showDialog(context: context, builder: (BuildContext context){
                                       //   return CasualLeavesDialog();
                                       //
                                       // });
                                     },

                                     child: ReUsableCardLRP(
                                       colourFromAbove:Colors.blue.shade50,
                                         textFromAbove:"Casual Leaves",
                                         imageFromUp:
                                         DecorationImage(
                                           image: AssetImage('assets/images/caualLeave.png'),
                                         ),
                                     ),
                                   ),

                                 ),
                                 Expanded(
                                   child: GestureDetector(
                                     onTap: (){
                                       Navigator.push(context,MaterialPageRoute(builder:(context)=>MedicalLeaveReq()));
                                     },
                                     child: ReUsableCardLRP(
                                         colourFromAbove:Colors.blue.shade100,
                                         imageFromUp:
                                         DecorationImage(
                                           image: AssetImage('assets/images/medicalLeave.png'),
                                         ),
                                         textFromAbove:"Medical Leaves"
                                     ),
                                   ),
                                 ),
                               ]
                           ),
                         ),
                         Container(
                           child: Row(
                               children: [
                                 Expanded(
                                   child: GestureDetector(
                                     onTap: (){
                                       showDialog(context: context,
                                       builder: (BuildContext context){
                                         return AdvanceCustomAlert();
                                       });

                                     },
                                     child: ReUsableCardLRP(
                                       colourFromAbove:Colors.blue.shade100,
                                       imageFromUp:DecorationImage(
                                          image: AssetImage('assets/images/shortLeaves.png'),
                                         ),
                                         textFromAbove:"Short Leaves",


                                     ),
                                   ),
                                 ),
                                 Expanded(
                                   child: GestureDetector(
                                     onTap: (){
                                       showDialog(context: context,
                                           builder: (BuildContext context){
                                             return HalfDayEvent();
                                           });
                                     },
                                     child: ReUsableCardLRP(
                                         colourFromAbove:Colors.blue.shade50,
                                       //halfDay
                                         imageFromUp:DecorationImage(
                                           image: AssetImage('assets/images/halfDay.png'),
                                         ),
                                         textFromAbove:"Half Day Leaves"),
                                   ),

                                 ),
                               ]
                           ),
                         ),
                         Container(
                           child: Row(
                               children: [
                                 Expanded(
                                   child: GestureDetector(
                                     onTap: (){Navigator.push(context,MaterialPageRoute(builder:(context)=>DutyLeave()));},
                                     child: ReUsableCardLRP(
                                       //dutyLeave
                                       imageFromUp:DecorationImage(
                                         image: AssetImage('assets/images/dutyLeave.png'),
                                       ),
                                         colourFromAbove:Colors.blue,
                                         textFromAbove:"Duty Leaves",
                                     ),
                                   ),
                                 ),
                               ]
                           ),
                         ),
                       ],
                     )
                   ),
                 ),
              ],
            ),
      ),
    );
  }
}

class ReUsableCardLRP extends StatelessWidget {
  const ReUsableCardLRP({Key key, @required this.imageFromUp,this.textFromAbove,this.colourFromAbove
  }) : super(key: key);

final  DecorationImage imageFromUp;
final String textFromAbove;
final Color colourFromAbove;


  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.all(10),
      width: 100,
      height: 100,
      color:colourFromAbove,
      child:  Row(
     children: [
       //image part.......................
       Expanded(
         flex: 3,
         child: Container(
           //color: Colors.red,
            decoration: BoxDecoration(

              image: imageFromUp
            ),
         ),
       ),
       // text part.........................
       Expanded(
         flex: 4,
         child: Container(
           child: Text("$textFromAbove",
             style: TextStyle(
                 fontSize: 15,
                 fontWeight:FontWeight.bold,

                   ),

           ),

         ),
       ),
     ],
     ),
    );
  }
}

