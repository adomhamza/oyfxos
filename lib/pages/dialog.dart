import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialog({
  required String title,
  required BuildContext context,
  required String content,
  required String defaultActionText,
}) async {
  if (Platform.isIOS) {
    return await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(defaultActionText),
                ),
              ],
            ));
  }
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(defaultActionText),
              ),
            ],
          ));
}

Future<void> showAlertDialogWithdraw({
  required String title,
  required BuildContext context,
  required TextEditingController controllerWithdrawalAmount,
  required String defaultActionText,
}) async {
  if (Platform.isIOS) {
    return await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: TextFormField(
                controller: controllerWithdrawalAmount,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(defaultActionText),
                ),
              ],
            ));
  }
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: TextFormField(
              controller: controllerWithdrawalAmount,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(defaultActionText),
              ),
            ],
          ));
}
//Cellular data is turned off
// Turn on cellular data or use Wi-Fi to access data