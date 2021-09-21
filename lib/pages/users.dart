import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:oyfxos/model/model.dart';
import 'package:oyfxos/pages/ProgressHUD.dart';
import 'package:oyfxos/pages/drawer.dart';
import 'package:uuid/uuid.dart';

import 'dialog.dart';
import 'helper.dart';

class Users extends StatefulWidget {
  final Login? userData;

  const Users({Key? key, this.userData}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controllerWithdrawalAmount =
      new TextEditingController();

  bool progressCode = false;
  bool isApiCallProcess = false;
  //bool _disableBtns = true;
  getUsers() async {
    ListUsers listUsers;
    try {
      final response = await http.get(
        Uri.parse('https://tunishub.com/oyfx_api/api/user/read.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        listUsers = new ListUsers.fromJson(json.decode(response.body));
        listUsers.allUsers.forEach((element) {
          print(element.firstName);
          listUsersData.add(element);
        });
      } else {
        progressCode = true;
        setState(() {});
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

  withdrawal(
    String withdrawalId,
    int amount,
    String userEmail,
    String supervisorEmail,
    String traderName,
    String supervisorName,
  ) async {
    try {
      final response = await http
          .post(
              Uri.parse(
                  'https://tunishub.com/oyfx_api/api/withdrawal/create.php'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode({
                "withdrawal_id": withdrawalId,
                "amount": amount,
                "supervisor_email": supervisorEmail,
                "email": userEmail,
                "trader_name": traderName,
                "supervisor_name": supervisorName
              }))
          .timeout(Duration(seconds: 5));
      print(response.statusCode);
      if (response.statusCode == 201) {
        setState(() {
          isApiCallProcess = false;
          controllerWithdrawalAmount.clear();
        });

        final snackBar = SnackBar(
          content: Text("Successful"),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        // return response;
      } else if (response.statusCode == 503) {
        final snackBar = SnackBar(
          content: Text("Withdrawal failed"),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } on TimeoutException catch (_) {
      setState(() {
        isApiCallProcess = false;
        controllerWithdrawalAmount.clear();
      });

      showAlertDialog(
        title: 'Connection Timeout',
        context: context,
        content: 'Please check internet and try again',
        defaultActionText: 'OK',
      );
    } on SocketException catch (_) {
      setState(() {
        isApiCallProcess = false;
        controllerWithdrawalAmount.clear();
      });
      showAlertDialog(
        title: 'Connection Error',
        context: context,
        content: 'Please check internet connectivity',
        defaultActionText: 'OK',
      );
    } catch (_) {
      setState(() {
        isApiCallProcess = false;
        controllerWithdrawalAmount.clear();
      });
      showAlertDialog(
        title: 'Error',
        context: context,
        content: 'Please contact support or try again later',
        defaultActionText: 'OK',
      );
    }
  }

  sd(BuildContext context, AllUser allUser) async {
    if (Platform.isIOS) {
      return await showCupertinoDialog(
          context: context,
          builder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoAlertDialog(
                    title: Text(
                      "Enter Withdrawal Amount",
                    ),
                    content: Center(
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              onChanged: (source) {
                                if (source == "0") {
                                  final snackBar = SnackBar(
                                    content: Text("Amount cannot be zero"),
                                    duration: Duration(seconds: 2),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }

                                //   _disableBtns = false;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: controllerWithdrawalAmount,
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            controllerWithdrawalAmount.clear();
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                          setState(() {
                            isApiCallProcess = true;
                          });
                          await submit(allUser);
                          Navigator.of(context).pop();
                        },
                        child: Text("Send"),
                      )
                    ],
                  ),
                ],
              ));
    } else {
      return await showDialog(
          context: context,
          builder: (context) => Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AlertDialog(
                      title: Text(
                        "Enter Withdrawal Amount",
                      ),
                      content: Center(
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                  onChanged: (source) {
                                    if (source == "0") {
                                      final snackBar = SnackBar(
                                        content: Text("Amount cannot be zero"),
                                        duration: Duration(seconds: 2),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }

                                    //   _disableBtns = false;
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: controllerWithdrawalAmount,
                                  decoration: InputDecoration()),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              controllerWithdrawalAmount.clear();
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              isApiCallProcess = true;
                            });
                            await submit(allUser);
                            Navigator.of(context).pop();
                          },
                          child: Text("Send"),
                        )
                      ],
                    ),
                  ],
                ),
              ));
    }
  }

  Future<void> onRefresh() async {
    listUsersData.clear();
    progressCode = false;
    setState(() {});
    getUsers();
  }

  @override
  void initState() {
    super.initState();
    listUsersData.clear();
    getUsers();
  }

  submit(AllUser allUser) async {
    String withdrawalId = Uuid().v4().toString();
    String supervisorEmail = userData!.email;
    String traderName = "${allUser.firstName} ${allUser.lastName}";
    int amount = int.parse(controllerWithdrawalAmount.text);
    String userEmail = allUser.email;
    String supervisorName = "${userData!.firstName} ${userData!.lastName}";
    isApiCallProcess = true;
    if (amount != 0) {
      withdrawal(
        withdrawalId,
        amount,
        userEmail,
        supervisorEmail,
        traderName,
        supervisorName,
      );
    } else {
      isApiCallProcess = false;

      final snackBar = SnackBar(
        content: Text("Failed: Amount cannot be zero"),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      child: Scaffold(
        drawer: DrawerPage(),
        appBar: AppBar(
          //automaticallyImplyLeading: true,
          actions: [
            IconButton(
              onPressed: () {
                listUsersData.clear();
                progressCode = false;
                setState(() {});
                getUsers();
              },
              icon: Icon(Icons.refresh),
              color: Colors.black,
            )
          ],
          title: Text(
            'Make Withdrawal',
          ),
        ),
        body: Container(
          child: Column(
            children: [
              listUsersData.isNotEmpty
                  ? Expanded(
                      child: RefreshIndicator(
                          onRefresh: onRefresh,
                          child: ListView.builder(
                            itemCount: listUsersData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child:
                                        Text('${listUsersData.length - index}'),
                                    radius: 20.0,
                                  ),
                                  title: Text(
                                    "${listUsersData[index].lastName} ${listUsersData[index].firstName}",
                                  ),
                                  subtitle: Text(
                                      "${listUsersData[index].dateCreated}"),
                                  trailing: ElevatedButton(
                                    style: raisedButtonStyle,
                                    onPressed: () {
                                      sd(context, listUsersData[index]);
                                    },
                                    child: Text(
                                      'Withdraw',
                                      style: TextStyle(color: Colors.brown),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                    )
                  : listUsersData.isEmpty && progressCode == false
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
                      : listUsersData.isEmpty && progressCode == true
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
      ),
    );
  }
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  // shape: RoundedRectangleBorder(
  //   borderRadius: BorderRadius.circular(32),
  //   //borderRadius: BorderRadius.all(Radius.circular(32)),
  // ),
  padding: EdgeInsets.all(12),
  primary: Colors.lightBlueAccent,
);
