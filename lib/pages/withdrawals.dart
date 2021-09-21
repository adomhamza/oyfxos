import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:oyfxos/data/local_storage.dart';
import 'package:oyfxos/model/model.dart';
import 'package:oyfxos/pages/ProgressHUD.dart';
import 'package:oyfxos/pages/dialog.dart';
import 'package:oyfxos/pages/helper.dart';
//import 'package:oyfxos/pages/new_withdrawal_input.dart';
//import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Withdrawals extends StatefulWidget {
  final Login? userData;

  final Supervisor? supervisorData;
  const Withdrawals({Key? key, this.userData, this.supervisorData})
      : super(key: key);

  @override
  _WithdrawalsState createState() => _WithdrawalsState();
}

class _WithdrawalsState extends State<Withdrawals> {
  String userEmail = userData!.email;
  var dataRes;
  bool progressCode = false;

  getTraderWithdrawal() async {
    try {
      if (userData!.userTypeId == "1") {
        final response = await http.get(
          Uri.parse(
              'https://tunishub.com/oyfx_api/api/withdrawal/read_user_withdrawal.php?email=$userEmail'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ).timeout(Duration(seconds: 5));
        print(response.statusCode);
        if (response.statusCode == 200) {
          //String responseString = response.body;
          dataRes = json.decode(response.body);
          print(response.body);
          for (int i = 0; i < dataRes["withdrawal"].length; i++) {
            UserWithdrawal userWithdrawal =
                UserWithdrawal.fromJson(dataRes["withdrawal"][i]);
            listUserWithdrawalDetails.add(userWithdrawal);
          }
        } else {
          progressCode = true;
          setState(() {});
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

        if (supervisorResponse.statusCode == 200) {
          dataRes = json.decode(supervisorResponse.body);
          for (int i = 0; i < dataRes["withdrawal"].length; i++) {
            UserWithdrawal userWithdrawal =
                UserWithdrawal.fromJson(dataRes["withdrawal"][i]);
            listUserWithdrawalDetails.add(userWithdrawal);
          }
        } else {
          progressCode = true;
          setState(() {});
        }
      }
    } on TimeoutException catch (_) {
      setState(() {
        progressCode = false;
      });
      showAlertDialog(
        title: 'Connection Timeout',
        context: context,
        content: 'Please check internet and try again',
        defaultActionText: 'OK',
      );
    } on SocketException catch (_) {
      setState(() {
        progressCode = false;
      });
      showAlertDialog(
        title: 'Connection Error',
        context: context,
        content: 'Could not retrieve data. Please try again later',
        defaultActionText: 'OK',
      );
    } catch (_) {
      setState(() {
        progressCode = false;
      });
      showAlertDialog(
        title: 'Error',
        context: context,
        content: 'Please contact support or try again later',
        defaultActionText: 'OK',
      );
    }
    setState(() {
      progressCode = true;
    });
  }

  Future<void> scroll() async {
    listUserWithdrawalDetails.clear();
    progressCode = false;
    setState(() {});
    getTraderWithdrawal();
  }

  @override
  void initState() {
    super.initState();
    listUserWithdrawalDetails.clear();
    getTraderWithdrawal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {
              listUserWithdrawalDetails.clear();
              progressCode = false;
              setState(() {});
              getTraderWithdrawal();
            },
            icon: Icon(Icons.refresh),
            color: Colors.black,
          )
        ],
        title: Text(
          'Withdrawals',
        ),
      ),
      body: Container(
        child: Column(
          children: [
            listUserWithdrawalDetails.isNotEmpty
                ? Expanded(
                    child: RefreshIndicator(
                      onRefresh: scroll,
                      child: ListView.builder(
                        itemCount: listUserWithdrawalDetails.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                final snackBarTraderName = SnackBar(
                                  content: Text(listUserWithdrawalDetails[index]
                                      .traderName),
                                  duration: Duration(seconds: 1),
                                );

                                if (userData!.userTypeId == "2") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBarTraderName);
                                }
                              },
                              leading: CircleAvatar(
                                child: Text(
                                    '${listUserWithdrawalDetails.length - index}'),
                                radius: 20.0,
                              ),
                              title: Text(
                                "${listUserWithdrawalDetails[index].supervisorName}",
                              ),
                              subtitle: Text(
                                  "${listUserWithdrawalDetails[index].dateCreated}"),
                              trailing: Text(
                                "\$${listUserWithdrawalDetails[index].amount}",
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : listUserWithdrawalDetails.isEmpty && progressCode == false
                    ? Expanded(
                        child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                getLoadingIndicator(),
                                SizedBox(
                                  height: 5.0,
                                ),
                                getHeading(),
                              ]),
                        ),
                      )
                    : listUserWithdrawalDetails.isEmpty && progressCode == true
                        ? Expanded(
                            child: Center(
                              child: Container(
                                child: Text("No Records"),
                              ),
                            ),
                          )
                        : Container()
          ],
        ),
      ),
    );
  }
}

// Widget _getLoadingIndicator() {
//   return Padding(
//       child: Container(
//           child: CircularProgressIndicator(strokeWidth: 3),
//           width: 32,
//           height: 32),
//       padding: EdgeInsets.only(bottom: 16));
// }

