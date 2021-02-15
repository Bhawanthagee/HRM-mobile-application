import 'package:flutter/material.dart';


class AlreadyChecked extends StatelessWidget {
  final title;
  AlreadyChecked(this.title);

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
              height: 230,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text('OOOPS!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.red),),
                    SizedBox(height: 20,),
                    Text('"$title"', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),),

                    SizedBox(height: 15,),
                    RaisedButton(onPressed: () {
                      Navigator.pop(context);
                      print(timeNow);
                    },
                      color: Colors.blue,
                      child: Text('Ok', style: TextStyle(color: Colors.white),),
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
                  backgroundImage: AssetImage('assets/images/error.gif'),
                )
            ),
          ],
        )
    );
  }
}