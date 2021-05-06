import 'package:flutter/material.dart';

class ResortDetails extends StatefulWidget {
  final AssetImage image;
  final String resortName;
  final String description;

  const ResortDetails({Key key, this.image, this.resortName, this.description}) : super(key: key);
  @override
  _ResortDetailsState createState() => _ResortDetailsState();
}

class _ResortDetailsState extends State<ResortDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,

        title: Text("Request Leave"),
        shadowColor: Colors.transparent,
      ),

    );
  }
}
