import 'package:flutter/material.dart';
import 'package:login_ui/login.dart';



class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        elevation: 20.0,
        actions: [
          IconButton(icon: Icon(Icons.email), onPressed: null)
        ],
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Log Out'),
          onPressed: (){
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Login()));
          },
        ),
      ),
    );
  }
}
