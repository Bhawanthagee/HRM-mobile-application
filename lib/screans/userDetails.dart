
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/screans/home.dart';

class UserDetails extends StatefulWidget {

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {


  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0XFFF0F0F0),
      appBar: AppBar(

        title: Text('Benefits and Requests'),
      ),
      body: Padding(
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
                    },
                      mediaQuery: mediaQuery,
                  text: "Apply For\nFree Train Pass",
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
                     child: RequestCard(
                       backgroundColor: Color(0xFF021089),
                       image: AssetImage('assets/images/salary.png'),
                       text: '    Pay Sheet',
                     ),
                   ),
                 ),
                  Expanded(
                  child: GestureDetector(
                    child: RequestCard(
                      backgroundColor: Color(0xFF840211),
                      image: AssetImage('assets/images/loanImage.png'),
                      text: '   Bank Loan',
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
                      child: RequestCard(
                        backgroundColor: Color(0xFF430289),
                        image: AssetImage('assets/images/meeting.png'),
                        text: '   Meetings',
                      ),
                    ),
                  ), Expanded(
                    child: GestureDetector(
                      onTap: (){

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
            )
          ],
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