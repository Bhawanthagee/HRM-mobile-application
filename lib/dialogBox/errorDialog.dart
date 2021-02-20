import 'package:flutter/material.dart';




class LoginErrorDialogPassword extends StatelessWidget {

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
                    Text('OOOPS!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.redAccent),),
                    SizedBox(height: 20,),
                    Text('"Please Check the Password"', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),),

                    SizedBox(height: 15,),
                    RaisedButton(onPressed: () {
                      Navigator.pop(context);
                      print(timeNow);
                    },
                      color: Colors.blueAccent,
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



class LoginErrorDialogEmail extends StatelessWidget {

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
                    Text('OOOPS!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.redAccent),),
                    SizedBox(height: 20,),
                    Text('"Please Check the Email"', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),),

                    SizedBox(height: 15,),
                    RaisedButton(onPressed: () {
                      Navigator.pop(context);
                      print(timeNow);
                    },
                      color: Colors.blueAccent,
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

// class EmailNotFound extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     DateTime timeNow = DateTime.now();
//     return Dialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(4.0)
//         ),
//         child: Stack(
//           overflow: Overflow.visible,
//           alignment: Alignment.topCenter,
//           children: [
//             Container(
//               height: 230,
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
//                 child: Column(
//                   children: [
//                     Text('OOOPS!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.redAccent),),
//                     SizedBox(height: 20,),
//                     Text('"No user to the Entered E-mail"', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),),
//
//                     SizedBox(height: 15,),
//                     RaisedButton(onPressed: () {
//                       Navigator.pop(context);
//                       print(timeNow);
//                     },
//                       color: Colors.blueAccent,
//                       child: Text('Ok', style: TextStyle(color: Colors.white),),
//                     ),
//
//
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//                 top: -60,
//                 child: CircleAvatar(
//                   backgroundColor: Colors.lightGreen,
//                   radius: 60,
//                   backgroundImage: AssetImage('assets/images/error.gif'),
//                 )
//             ),
//           ],
//         )
//     );
//   }
// }





