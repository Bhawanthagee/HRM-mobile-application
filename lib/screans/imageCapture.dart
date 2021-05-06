import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      print('Image Path: $_image');
    });
  }

  Future uploadImage(BuildContext context) async {
    String fileName = basename(_image.path);
    Reference ref = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(_image);
    TaskSnapshot snapshot = await uploadTask;
    //bool complete = snapshot;

    // snapshot
    //     ? setState(() {
    //   print('Pciture uploaded');
    //   Scaffold.of(context)
    //       .showSnackBar(SnackBar(content: Text('Pciture uploaded')));
    // })
    //     : setState(() {
    //   Scaffold.of(context)
    //       .showSnackBar(SnackBar(content: CircularProgressIndicator()));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          //* mainAxisAlignment: MainAxisSize.,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.lightBlueAccent,
                  child: ClipOval(
                    child: SizedBox(
                      width: 180.0,
                      height: 180.0,
                      child: (_image != null)
                          ? Image.file(
                        _image,
                        fit: BoxFit.cover,
                      )
                          : Image(
                        image: NetworkImage(
                            'https://pointchurch.com/wp-content/uploads/2019/02/Blank-Person-Image.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    getImage();
                  },
                  icon: Icon(
                    FontAwesomeIcons.camera,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text(
                'User Name',
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                'Tamer Ahmad',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(FontAwesomeIcons.edit),
              ),
            ),
            ListTile(
              title: Text(
                'Birthday',
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                '16/3/1995',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(FontAwesomeIcons.edit),
              ),
            ),
            ListTile(
              title: Text(
                'Location',
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                'London, UK',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(FontAwesomeIcons.edit),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.email,
                size: 30,
              ),
              title: Text(
                'tamer@email.com',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  width: 100,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      // Navigator.pop(context);
                    },
                    color: Colors.redAccent,
                    elevation: 5,
                    splashColor: Colors.red,
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      uploadImage(context);
                    },
                    color: Colors.greenAccent,
                    elevation: 5,
                    splashColor: Colors.green,
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}