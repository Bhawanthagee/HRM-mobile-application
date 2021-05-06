
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/benifits-and-request-pages/bankLoan.dart';
import 'package:login_ui/benifits-and-request-pages/google_map.dart';
import 'package:login_ui/benifits-and-request-pages/medicalBonus.dart';
import 'package:login_ui/benifits-and-request-pages/meetings.dart';
import 'package:login_ui/benifits-and-request-pages/paySheetRequest.dart';
import 'package:login_ui/benifits-and-request-pages/train.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:login_ui/benifits-and-request-pages/distress loan.dart';

class UserDetails extends StatefulWidget {

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  void emailLaunch(command)async{
    if(await canLaunch(command)){
      await launch(command);
    }else{
  print('something went wrong');
    }
  }


  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0XFFF0F0F0),
      appBar: AppBar(

        title: Text('Benefits and Requests'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(23.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Benefits',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600
              ),),
              Container(
                width: mediaQuery.width*.8,
                height: mediaQuery.height*.15,
                //color: Colors.red,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    BenefitsCard(
                      onTap: (){
                        print('apply train');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TrainPass()));
                      },
                        mediaQuery: mediaQuery,
                    text: "Apply For\n Train Warrant",
                        image: AssetImage('assets/images/train.jpg')
                    ),
                    BenefitsCard(
                        onTap: (){
                          print('bonus');
                        },
                        mediaQuery: mediaQuery,
                      text: "Bonus",
                        image: AssetImage('assets/images/bonus.png')

                    ),
                    BenefitsCard(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MedicalBonus()));

                          print('medical bonus');
                        },
                        mediaQuery: mediaQuery,
                      text: 'Medical Bonus',
                        image: AssetImage('assets/images/medicalBonus.png')
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:15.0,bottom: 10),
                child: Text('Requests',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              ),
              Container(
                width: double.infinity,
                height: mediaQuery.height*.14,
               //color: Colors.red,
                child: Row(
                  children: [
                   Expanded(
                     child: GestureDetector(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>PaySheetRequest()));
                         //Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                       },
                       child: RequestCard(
                         backgroundColor: Color(0xFF021089),
                         image: AssetImage('assets/images/salary.png'),
                         text: '    Pay Sheet',
                       ),
                     ),
                   ),
                    Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DistressLoan()));

                      },
                      child: RequestCard(
                        backgroundColor: Color(0xFF840211),
                        image: AssetImage('assets/images/loanImage.png'),
                        text: '   Distress Loan',
                      ),
                    ),
                    )
                  ],
                ),
              ),
              SizedBox(height: mediaQuery.height*.02,),
              Container(
                width: double.infinity,
                height: mediaQuery.height*.15,
                //color: Colors.red,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MeetingRequest()));
                        },
                        child: RequestCard(
                          backgroundColor: Color(0xFF430289),
                          image: AssetImage('assets/images/meeting.png'),
                          text: '   Meetings',
                        ),
                      ),
                    ), Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BankLoan()));
                        },
                        child: RequestCard(
                          backgroundColor: Color(0xFF0E6802),
                          image: AssetImage('assets/images/loanImage.png'),
                          text: '   Bank Loan',
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:15.0,bottom: 10),
                child: Text('Important',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              ),
              Container(
                width: double.infinity,
                height: mediaQuery.height*.15,
                //color: Colors.red,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          emailLaunch('https://eservices.railway.gov.lk/schedule/searchTrain.action?lang=en');
                        },
                        child: RequestCard(
                          backgroundColor: Color(0xFF009fb8),
                          image: AssetImage('assets/images/transportImage.png'),
                          text: '   Train Time Table',
                        ),
                      ),
                    ), Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ResortsMap()));
                        },
                        child: RequestCard(
                          backgroundColor: Color(0xFF36142d),
                          image: AssetImage('assets/images/googleMap.png'),
                          text: '   View Resorts',
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class RequestCard extends StatelessWidget {
  final Color color,backgroundColor;
  final String text;
  final AssetImage image;


 RequestCard({this.color,this.text,this.image,this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5,bottom: 5,left: 8,right: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
      ),
      child: Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: image,
                      fit: BoxFit.cover
                  )
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text(text,style: TextStyle(color: Colors.white,fontSize: 18),)
            ],
          )
        ],
      ),
    );
  }
}
class BenefitsCard extends StatelessWidget {
  const BenefitsCard({@required this.mediaQuery, this.image,this.text, this.onTap}) ;

  final Size mediaQuery;
  final String text;
  final AssetImage image;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 5,bottom: 5,right: 10,left: 10),
        height:mediaQuery.height * .15,
        width: mediaQuery.width*.6,
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  //color: Colors.red,
                  image: DecorationImage(
                      image: image,
                    //fit: BoxFit.cover
                  )
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 5),
                child:Text(text,style: TextStyle(fontSize: 17),),
              ),
            )
          ],
        ),
      ),
    );
  }
}