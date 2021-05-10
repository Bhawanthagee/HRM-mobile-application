
import 'package:flutter/material.dart';


class BankLoan extends StatefulWidget {
  @override
  _BankLoanState createState() => _BankLoanState();
}

class _BankLoanState extends State<BankLoan> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: RaisedButton.icon(
          color: Colors.blue,
          icon: Icon(
            Icons.file_download,
            color: Colors.white,
          ),
          label: Text("Download"),
          onPressed: ()async{

          },
        ),
      ),
    );
  }
}
