import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_ui/custom items/constants.dart';
import 'package:login_ui/dialogBox/alreadyMarkedAttendence.dart';
import 'package:login_ui/screans/googleNav.dart';
import 'package:login_ui/screans/home.dart';



class AdvanceCustomAlert extends StatefulWidget {

  @override
  _AdvanceCustomAlertState createState() => _AdvanceCustomAlertState();
}

class _AdvanceCustomAlertState extends State<AdvanceCustomAlert> {
    int shortLeave;
    Color btnColor;
    String remainingTxt;
    var _fireStore = FirebaseFirestore.instance;

  void reductionShortLeave()async{
    DocumentSnapshot variable =
    await _fireStore.collection('short leave Counter').doc(loggedInUSer.email).get();
    String v = variable['count'];
    shortLeave = int.parse(v);
    print('remainig shotr leaves :  $shortLeave');
    if(shortLeave ==0){
      remainingTxt = 'No More Short Leave Left';
      btnColor = Colors.grey;
    }else if(shortLeave !=0){
      remainingTxt = '';
      btnColor = Colors.green;
    }
    setState(() {

    });
  }

    @override
    void initState() {
      super.initState();
      reductionShortLeave();
    }
  @override
  Widget build(BuildContext context) {

    final _fireStore = FirebaseFirestore.instance;
    String descriptionTxt;
    final _formKey = GlobalKey<FormState>();

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
              height: 430,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text('Short Leave', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    SizedBox(height: 15,),
                    Text('Remaining : $shortLeave'),
                    SizedBox(height: 20,),
                    Text('$remainingTxt',style: TextStyle(color: Colors.red),),
                    SizedBox(height: 10,),
                    Text(' ${timeNow.year} / ${timeNow.month} / ${timeNow.day}',style: Constants.timeAndDateTxt,),
                    Text(' ${timeNow.hour} : ${timeNow.minute} ',style: Constants.DateTxt,),
                    SizedBox(height: 25,),
                    Form(
                      key: _formKey,
                      child: Container(

                        padding: EdgeInsets.only(left: 30, right: 30 ,bottom: 20),
                        child: TextFormField(
                            validator: (value){
                              if(value.trim().isEmpty){
                                return" Description can not be emplty";
                              }
                            },
                            maxLines: 2,
                            onChanged: (value){
                              descriptionTxt = value;
                            },
                            decoration: InputDecoration(
                              labelText:"Description",
                              helperText: "",
                              labelStyle: TextStyle(fontSize: 14, color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color:Colors.blue,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color:Colors.blue,
                                  )),
                            )
                        ),
                      ),
                    ),
                    RaisedButton(
                      color: btnColor,
                      onPressed: () {
                      DateTime date =timeNow;
                      String formattedDateIn = DateFormat('dd-M-yyyy').format(date);
                      String formattedTime = DateFormat('hh:mm').format(date);
                      print(date);
                     // Navigator.pop(context);
                      print(formattedDateIn);
                      print(formattedTime);
                      if( _formKey.currentState.validate()){

                      try{
                        if(shortLeave!=0) {
                          _fireStore.collection('leaves').doc('short leave')
                              .collection(loggedInUSer.email).doc()
                              .set({
                            'date': formattedDateIn,
                            'time': formattedTime,
                            'Description': descriptionTxt,
                          });
                          _fireStore.collection('short leave Counter').doc(
                              loggedInUSer.email).set(
                          {
                          'count':'${shortLeave-1}',
                          });
                        }
                      }catch(e){}
                      Navigator.of(context).pop();
                      print(timeNow);
                      }
                    },
                      //color: Colors.blueAccent,
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




