import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/login.dart';
import 'package:login_ui/screans/home.dart';
import 'package:login_ui/screans/imageCapture.dart';
import 'package:login_ui/screans/updateProfile.dart';






class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _fireStore = FirebaseFirestore.instance;
  String userName,position,address,branch,tel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }
  Future getUserDetails()async{

    DocumentSnapshot userDetails=await _fireStore.collection('UserProfiles').doc(loggedInUSer.email).get();
    DocumentSnapshot userDetails2=await _fireStore.collection('UserProfiles').doc(loggedInUSer.email).get();


    setState(() {
      userName = userDetails['name'];
      position = userDetails['Position'];
      address = userDetails['address'];

    });
    setState(() {
      tel = userDetails2['tel'];
      branch = userDetails2['branch'];
    });


  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        elevation: 20.0,
        actions: [
          IconButton(icon: Icon(Icons.security), onPressed: null)
        ],
      ),
      body:Column(
        children: [
          Center(
            child:Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/bawantha.jpg'),
                backgroundColor: Colors.transparent,
                radius: 60,
              ),
            ) ,
          ),
          SizedBox(height: 18,),
          Text("$userName",style: TextStyle(fontSize: 30),),
          SizedBox(height: 18,),
          Text("$position",style: TextStyle(fontSize: 18,color: Colors.black45),),
          SizedBox(height: 48,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ReUsableProfileCard(item: loggedInUSer.email),
                SizedBox(height: 18,),
                ReUsableProfileCard(item: "Address: $address"),
                SizedBox(height: 18,),
                ReUsableProfileCard(item: "Branch: $branch"),SizedBox(height: 18,),
                ReUsableProfileCard(item: "$tel"),
                SizedBox(height: 15,),
               Padding(
                 padding: const EdgeInsets.only(top :8.0,right: 25,left: 25),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     RaisedButton(onPressed:(){
                       Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfile()));
                     },
                       child: Text("Update profile",style: TextStyle(color: Colors.black),),),
                     RaisedButton(onPressed:(){
                       Navigator.pop(context);
                       Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));


                     },
                       child: Text("Log Out",style: TextStyle(color: Colors.black),),)
                   ],
                 ),
               )
              ],
            ),
          )
        ],
      )

    );
  }
}

class ReUsableProfileCard extends StatelessWidget {
  final String item;

  const ReUsableProfileCard({
    Key key, this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height:55,
      decoration: BoxDecoration(
          color: Color(0xFFe8e8e8),
          borderRadius: BorderRadius.circular(30),
        boxShadow:[
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8.0,
            offset: Offset(0.0,8.0)
          )
        ]
      ),
      child: Center(child: Text(item,style: TextStyle(fontWeight: FontWeight.bold),)),
    );
  }
}
