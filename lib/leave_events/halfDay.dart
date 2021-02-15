import 'package:flutter/material.dart';
import 'package:login_ui/custom items/constants.dart';



class HalfDayEvent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


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
                    RaisedButton(onPressed: () {
                      Navigator.pop(context);
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
                  backgroundImage: AssetImage('assets/images/mid2.gif'),
                )
            ),
          ],
        )
    );
  }
}




