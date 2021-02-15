import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:login_ui/screans/googleNav.dart';
import 'package:login_ui/screans/home.dart';
import 'package:login_ui/screans/leaveReq.dart';
import 'package:login_ui/classes/loggedInUser.dart';
import '';

//User loggedInUSer;

class CasualLeaveEvent extends StatefulWidget {

  final DateTime selectedDate;

  const CasualLeaveEvent({Key key, this.selectedDate}) : super(key: key);

  @override
  _CasualLeaveEventState createState() => _CasualLeaveEventState();
}

class _CasualLeaveEventState extends State<CasualLeaveEvent> {



   String reasonTxt;
   String descriptionTxt;
   bool showSpinner = false;
   final _auth = FirebaseAuth.instance;
   final _fireStore = FirebaseFirestore.instance;
   final _formKey = GlobalKey<FormState>();

   @override
   void initState() {
     super.initState();
     // getCurrentUser();
     print(loggedInUSer);
    }

   // void getCurrentUser()async{
   //   try{
   //     final user = await _auth.currentUser;
   //     if(user!=null){
   //       loggedInUSer = user;
   //       print(loggedInUSer.email);
   //     }}
   //   catch(e){
   //     print(e);
   //   }
   // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.clear, color: Colors.blue,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        // actions: [
        //   Center(
        //     child: ElevatedButton(
        //       onPressed:()async{
        //         addLeave();
        //       },
        //       child: Text('Save'),
        //     ),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(

           child: Form(
             key: _formKey,
             child: Column(
               children: [
                 Container(
                   padding: EdgeInsets.all(30 ),
                   child: TextFormField(
                     validator: (value){
                       if(value.trim().isEmpty){
                         return" Reason can not be emplty";
                       }
                     },

                       onChanged: (value){
                         reasonTxt = value;
                       },
                       decoration: InputDecoration(
                         labelText:"Reason",
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
                 Container(

                   padding: EdgeInsets.only(left: 30, right: 30 ,bottom: 20),
                   child: TextFormField(
                       validator: (value){
                         if(value.trim().isEmpty){
                           return" Description can not be emplty";
                         }
                       },
                     maxLines: 8,
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
                 Divider(height: 8.0,
                 thickness: 1,
                 color: Colors.black45  ,),

                 FormBuilderDateTimePicker(
                   style: TextStyle(fontWeight: FontWeight.bold),
                   name: 'date',
                   initialValue: widget.selectedDate?? DateTime.now(),
                   inputType: InputType.date ,
                   format: DateFormat.yMMMMEEEEd(),
                   decoration: InputDecoration(
                     border: InputBorder.none,
                     prefixIcon: Icon(Icons.calendar_today_outlined, color: Colors.blue,)
                   ),
                 ),
                  SizedBox(height: 50,),
                  Container(
                       height: 50,
                       width: double.infinity,
                    child: FlatButton(
                      onPressed:()async{

                        if( _formKey.currentState.validate()){
                          DateTime date = widget.selectedDate;
                          String formattedDateIn = DateFormat(' dd-M-yyyy').format(date);
                          print(date);
                        try{
                          _fireStore.collection('leaves').doc('casual').collection(loggedInUSer.email).doc(formattedDateIn).set({
                            "description": descriptionTxt,
                            "reason" :reasonTxt
                          });
                          DocumentSnapshot variable = await _fireStore.collection('Leave counter').doc(loggedInUSer.email).get();

                          String v = variable['remaining leaves'].toString();
                          var l = int.parse(v);
                          l=l-1;
                          _fireStore.collection('Leave counter').doc(loggedInUSer.email).set({
                            "remaining leaves" : l
                          });
                          print('remaining leaves: $l');
                          Navigator.push(context,MaterialPageRoute(builder:(context)=>MyHomePage()));

                        }catch(e){}

                      }


                        },


                         child: Ink(
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(6),
                               gradient: LinearGradient(
                                   begin: Alignment.centerLeft,
                                   end: Alignment.centerRight,
                                   colors: [
                                     Color(0xff5F67FF),
                                     Color(0xff7e85ff),
                                     Color(0xffbfc2ff),
                                   ]
                               )
                           ),
                           child: Container(
                             alignment: Alignment.center,
                             constraints: BoxConstraints(
                                 maxWidth: double.infinity,
                                 minHeight: 50),
                             child:Text("Submit",
                               style: TextStyle(
                                   color: Colors.white,
                                   fontWeight: FontWeight.bold),
                               textAlign: TextAlign.center,
                             ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
          ),
        ),




               ],
             ),
           ),
         ),
      ),
      );

  }
}