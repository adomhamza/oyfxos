import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final String message;
  ProgressDialog({this.message = ''});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            SizedBox(
              width: 6,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              '$message',
              style: TextStyle(color: Colors.black, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
