import 'dart:io';
import 'dart:async';

import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

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
