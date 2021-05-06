
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/screans/leaveReq.dart';
User loggedInUSer;
int stat;
String place;
String todo;
String date,moreDetails;

class DutyLeave extends StatefulWidget {
  @override
  _DutyLeaveState createState() => _DutyLeaveState();
}

class _DutyLeaveState extends State<DutyLeave> {
int a=1;
FirebaseFirestore _fireStore = FirebaseFirestore.instance;
@override


getValFromFB()async{
  DocumentSnapshot dutyLeaveDetails=await _fireStore.collection('duty_leave').doc(loggedInUSer.email).get();
  setState(() {
    stat = dutyLeaveDetails['stat'];
    place = dutyLeaveDetails['place'];
    todo = dutyLeaveDetails['todo'];
    date = dutyLeaveDetails['date'];
    moreDetails = dutyLeaveDetails['moreD'];
  });
  print(stat);
}
checkPAge(){

  if(stat==1){
    return One();
  }else{
    return Two();
  }
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPAge();
    getValFromFB();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeeeeee),
      appBar: AppBar(
        title: Text('Duty Leave'),
      ),
      body:checkPAge(),
    );
  }
}

// ignore: must_be_immutable
class One extends StatelessWidget {
DutyLeave dLeave = DutyLeave();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
            Padding(
              padding: const EdgeInsets.only(top:28.0,bottom: 5),
              child: Row(

                children: [
                  Expanded(
                      child:Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/gifs/workToDo.gif')
                      )
                    ),
                  )),
                  Expanded(
                      child:
                  Column(
                    children: [
                      Text("You Have",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35),),
                      Text("New Duty",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                      Text("Assigned",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20),),
                    ],
                  ))
                ],
              ),
            ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFeeeeee),
                  boxShadow:[
                    BoxShadow(
                        color: Color(0xFFdddddd),
                        blurRadius: 18.0,
                        offset: Offset(.0,8.0)
                    )
                  ],
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                            children: [
                                TextSpan(text: "Date : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                                TextSpan(text: "$date",)
                    ])),
                    SizedBox(height: 20,),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(text: "Place : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                              TextSpan(text: "$place",)
                            ])),
                    SizedBox(height: 20,),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(text: "You Job is : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                              TextSpan(text: "$todo",)
                            ])),
                    SizedBox(height: 20,),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(text: "U must : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                              TextSpan(text: "$moreDetails",)
                            ])),
                    SizedBox(height: 50,),
                    Center(
                      child: RaisedButton.icon(
                        color: Colors.blueAccent,
                        label: Text("Back to Home"),
                        icon: Icon(
                          Icons.keyboard_backspace,
                          color: Colors.white,
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
class Two extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top:28.0),
          child: Text(
            "You Don't Have Any Duty Leave",
            style: TextStyle(fontSize: 25),

          ),
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          height: MediaQuery.of(context).size.height*0.4,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/gifs/thinking.gif')
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:28.0),
          child: Text(
            "Please Contact your supervisor for more details",
            style: TextStyle(fontSize: 15),

          ),
        ),
        SizedBox(height: 30,),
        RaisedButton.icon(
            color: Colors.blueAccent,
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.exit_to_app_outlined,color: Colors.white,),
            label: Text('Go to Home',style: TextStyle(color: Colors.white),))
      ],
    );
  }
}

