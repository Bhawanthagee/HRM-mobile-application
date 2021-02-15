import 'package:flutter/material.dart';

class CasualLeavesDialog extends StatefulWidget {
  @override
  _CasualLeavesDialogState createState() => _CasualLeavesDialogState();
}

class _CasualLeavesDialogState extends State<CasualLeavesDialog> {
  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                child: Column(
                  children: [
                    Text('Apply Leave', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    SizedBox(height: 5,),
                    Text('Please Fill The Details', style: TextStyle(fontSize: 20),),
                    SizedBox(height: 20,),
                    Container(
                      child: Column(
                        children: [
                          TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                hintText: 'Type your message here...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                              ),



                          ),

                          RaisedButton(onPressed: () {
                              Navigator.of(context).pop();
                            },
                              color: Colors.lightBlueAccent,
                              child: Text('Submit', style: TextStyle(color: Colors.white),),
                            ),

                          RaisedButton(onPressed: () {
                            Navigator.of(context).pop();
                          },
                            color: Colors.redAccent,
                            child: Text('Cancel', style: TextStyle(color: Colors.white),),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Positioned(
            //     top: -60,
            //     child: CircleAvatar(
            //       backgroundColor: Colors.redAccent,
            //       radius: 60,
            //       child: Icon(Icons.assistant_photo, color: Colors.white, size: 50,),
            //     )
            // ),
          ],
        )
    );
  }
}


