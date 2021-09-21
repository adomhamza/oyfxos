import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oyfxos/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:oyfxos/pages/dialog.dart';
import 'helper.dart';

class Withdrawal extends StatefulWidget {
  const Withdrawal({Key? key}) : super(key: key);

  @override
  _WithdrawalState createState() => _WithdrawalState();
}

class _WithdrawalState extends State<Withdrawal> {
  bool isApiCallProcess = false;
  getTraderWithdrawal() async {
    String userEmail = userData!.email;
    //String userType = userData!.userTypeId;
    var dataRes;
    //TraderWithdrawal traderWithdrawal;

    try {
      if (userData!.userTypeId == "1") {
        final response = await http
            .get(
              Uri.parse(
                'https://tunishub.com/oyfx_api/api/withdrawal/read_user_withdrawal.php?email=$userEmail',
              ),
            )
            .timeout(Duration(seconds: 5));
        print(response.statusCode);
        print('Stream: $userEmail');
        print(response.body);

        // traderWithdrawal.userWithdrawal.forEach((element) {
        //   print(element.supervisorName);
        //   listUserWithdrawalDetails.add(element);
        // });
        setState(() {});
        if (response.statusCode == 200) {
          dataRes = json.decode(response.body);
          for (int i = 0; i < dataRes["withdrawal"].length; i++) {
            UserWithdrawal userWithdrawal =
                UserWithdrawal.fromJson(dataRes["withdrawal"][i]);
            listUserWithdrawalDetails.add(userWithdrawal);
          }
        } else {
          throw Exception('Failed');
        }
      } else {
        final supervisorResponse = await http
            .get(
              Uri.parse(
                'https://tunishub.com/oyfx_api/api/withdrawal/read.php',
              ),
            )
            .timeout(Duration(seconds: 5));
        print(supervisorResponse.statusCode);
        print('Stream: $userEmail');
        print(supervisorResponse.body);
        // print(itemCount);

        dataRes = json.decode(supervisorResponse.body);
        // traderWithdrawal.userWithdrawal.forEach((element) {
        //   print(element.supervisorName);
        //   listUserWithdrawalDetails.add(element);
        //   print(listUserWithdrawalDetails.length);
        // });
        setState(() {});
        if (supervisorResponse.statusCode == 200) {
          dataRes = json.decode(supervisorResponse.body);
          for (int i = 0; i < dataRes["withdrawal"].length; i++) {
            UserWithdrawal userWithdrawal =
                UserWithdrawal.fromJson(dataRes["withdrawal"][i]);
            listUserWithdrawalDetails.add(userWithdrawal);
          }
        } else {
          throw Exception('Failed');
        }
      }
    } on SocketException catch (_) {
      setState(() {
        isApiCallProcess = false;
      });
      showAlertDialog(
          title: 'Connection Error',
          context: context,
          content: 'Please check internet connectivity',
          defaultActionText: 'OK');
    } on TimeoutException catch (_) {
      setState(() {
        isApiCallProcess = false;
      });
      showAlertDialog(
        title: 'Connection Timeout',
        context: context,
        content: 'Please check internet and try again',
        defaultActionText: 'OK',
      );
    } catch (_) {
      setState(() {
        isApiCallProcess = false;
      });
      showAlertDialog(
        title: 'Error',
        context: context,
        content: 'Please contact support or try again later',
        defaultActionText: 'OK',
      );
    }
  }

  @override
  void initState() {
    super.initState();
    listUserWithdrawalDetails.clear();
    getTraderWithdrawal();
  }

  @override
  Widget build(BuildContext context) {
    if (listUserWithdrawalDetails.isNotEmpty) {
      return ListView.builder(
          itemCount: listUserWithdrawalDetails.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                    "${listUserWithdrawalDetails.length - index}",
                  ),
                  radius: 20.0,
                ),
                title: Text(
                  "${listUserWithdrawalDetails[index].supervisorName}",
                ),
                subtitle: Text(
                  "Date ${listUserWithdrawalDetails[index].dateCreated}",
                ),
                trailing: Text(
                  "\$${listUserWithdrawalDetails[index].amount}",
                ),
              ),
            );
          });
    } else {
      if (Platform.isIOS) {
        return Center(
          child: Container(
            padding: EdgeInsets.all(16),
            color: Colors.white.withOpacity(0.8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoActivityIndicator(
                  radius: 20.0,
                )
              ],
            ),
          ),
        );
      } else {
        return Center(
          child: Container(
            padding: EdgeInsets.all(16),
            color: Colors.white.withOpacity(0.8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [CircularProgressIndicator()],
            ),
          ),
        );
      }
    }
  }
}
