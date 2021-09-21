import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color>? valueColor;

  ProgressHUD({
    Key? key,
    required this.child,
    required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = new Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      );
      final iosModal = new Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          Center(
            child: CupertinoActivityIndicator(
              radius: 20.0,
            ),
          ),
        ],
      );
      if (Platform.isIOS) {
        widgetList.add(iosModal);
      } else {
        widgetList.add(modal);
      }
    }
    return Stack(
      children: widgetList,
    );
  }
}

Widget getLoadingIndicator() {
  if (Platform.isIOS) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoActivityIndicator(
          radius: 20.0,
        )
      ],
    );
  } else {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [CircularProgressIndicator()],
    );
  }
}

Widget getHeading() {
  return Padding(
      child: Text(
        'Please wait …',
        style: TextStyle(color: Colors.black, fontSize: 16),
        textAlign: TextAlign.center,
      ),
      padding: EdgeInsets.only(bottom: 4));
}
