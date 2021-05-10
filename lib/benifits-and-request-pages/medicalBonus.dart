import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_ui/screans/home.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MedicalBonus extends StatefulWidget {
  @override
  _MedicalBonusState createState() => _MedicalBonusState();
}

class _MedicalBonusState extends State<MedicalBonus> {


  DateTime attDate = DateTime.now();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int remainingMedicalLeave;
  double balance,bonus;
  double percentage =0.0;
  double count;

  getRemainingMedicalLeave()async{
    DocumentSnapshot data = await _firestore.collection('medicalLeaveCount').doc(loggedInUSer.email).get();
    count = data['remaining leaves'];
    print(count);
   setState(() {
     balance = 20-count;
   });

   double balance2 = balance.toDouble();
   setState(() {
     percentage = balance2/20*.1;
   });


    print('you have used $balance leave.');

  }
   calBonus()async{
    DocumentSnapshot data = await _firestore.collection('users').doc(loggedInUSer.email).get();
    int s = data['salary'];
    double salary = s.toDouble();
    bonus = salary/20*count;

    print('Rs. $salary and your bonus will be Rs.$bonus');
   }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRemainingMedicalLeave();
    calBonus();
  }


  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMM d, yyyy').format(attDate);
    return Scaffold(
      backgroundColor: Color(0xFF32374c),
      appBar: AppBar(
        backgroundColor: Color(0xFF303548),
        title: Text('Medical Bonus'),
      ),

    body: Column(
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.only(bottom:0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF2b2e40),

              ),
             child: Row(
               children: [
                 Expanded(
                   child: Center(
                     child: CircularPercentIndicator(
                       radius: 150,
                       center: Text("$balance days used", style: TextStyle(fontSize: 18,color: Colors.white ),),
                       progressColor: Colors.red,
                       percent: percentage,
                       lineWidth: 8,
                       circularStrokeCap: CircularStrokeCap.round,
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left:8.0, right: 20),
                   child: SizedBox(height:150,width: 1,
                   child: Container(
                     color: Colors.red,
                   ),),
                 ),
                 Expanded(
                     child: Container(
                       child: Text(formattedDate, style: TextStyle(fontSize: 25,color: Colors.white ),),

                     ),
                 )
               ],
             ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.01,
          child: Expanded(child: Container(color: Color(0xFF353a50),),),
        ),
        Expanded(
            flex:8,
            child: Column(
                  children: [
                    SizedBox(height: 45,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                          color:   Color(0xFF32374c),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF1e212d),
                            spreadRadius: 5,
                            blurRadius: 12,
                            offset: Offset(0, 0),
                          )
                        ]
                      ),

                      width: MediaQuery.of(context).size.height*0.4,
                      height: MediaQuery.of(context).size.height*0.12,
                      child: Row(
                        children: [
                          Expanded(child: Center(child: Text('Your Bonus will available in the end of the year',style: TextStyle(color: Colors.white),)))
                        ],
                      ),
                    ),
                    SizedBox(height: 45,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color:   Color(0xFF32374c),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF1e212d),
                              spreadRadius: 5,
                              blurRadius: 12,
                              offset: Offset(0, 0),
                            )
                          ]
                      ),
                      width: MediaQuery.of(context).size.height*0.4,
                      height: MediaQuery.of(context).size.height*0.12,
                      child: Row(
                        children: [
                          Expanded(
                            flex:3,
                              child:
                              Padding(
                                padding: const EdgeInsets.only(left:18.0),
                                child: RichText(
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.white),
                                        children: [
                                          TextSpan(text: "Approximate medical bonus\n",),
                                          TextSpan(text: "(this can be change according to your medical leave)",style: TextStyle(fontSize: 10))
                                        ])),
                              ),


                          ),
                          Expanded(
                              flex:2,
                              child: Center(child: Text('Rs.$bonus', style: TextStyle(color: Colors.white),))
                          )
                        ],
                      ),
                    ),


                  ],
                )
            )
      ],
    ),
    );
  }
}
