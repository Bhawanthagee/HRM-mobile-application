import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;
  final bool isLoading;
  CustomButton({this.text, this.onPressed, this.outlineBtn,this.isLoading});


  @override
  Widget build(BuildContext context) {
    bool _outLineBtn = outlineBtn ??false;
    bool _isLoading = isLoading ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60.0,

        decoration: BoxDecoration(
            color: _outLineBtn ? Colors.transparent : Colors.black,
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(12)
        ),
        margin: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 8.0
        ),
        // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                  text?? "Text",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: _outLineBtn ? Colors.lightBlueAccent : Colors.white,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
