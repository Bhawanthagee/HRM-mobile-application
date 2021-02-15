import 'package:flutter/material.dart';
class MedicalLeavesRequest extends StatefulWidget {
  @override
  _MedicalLeavesRequestState createState() => _MedicalLeavesRequestState();
}

class _MedicalLeavesRequestState extends State<MedicalLeavesRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Medial Leaves"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          ],
        ),
      ),
    );
  }
}
