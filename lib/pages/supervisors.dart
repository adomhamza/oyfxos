import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oyfxos/model/model.dart';
import 'package:oyfxos/pages/ProgressHUD.dart';
import 'package:oyfxos/pages/drawer.dart';

import 'dialog.dart';
import 'helper.dart';

class Supervisor extends StatefulWidget {
  final Login? userData;

  const Supervisor({Key? key, this.userData}) : super(key: key);

  @override
  _SupervisorState createState() => _SupervisorState();
}

class _SupervisorState extends State<Supervisor> {
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
        isApiCallProcess = false;
      });
      showAlertDialog(
        title: 'Connection Error',
        context: context,
        content: 'Could not retrieve data. Please try again later',
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
    setState(() {
      progressCode = true;
    });
  }

  updateUsers(String userId, String userTypeId) async {
    try {
      final response = await http
          .post(Uri.parse('https://tunishub.com/oyfx_api/api/user/update.php'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode({
                "user_id": userId,
                "user_type_id": userTypeId,
              }))
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        updateSupervisors =
            UpdateSupervisors.fromJson(json.decode(response.body));
        isApiCallProcess = false;

        final snackBar = SnackBar(
          content: Text("Successful"),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        progressCode = true;
        setState(() {});
      }
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
    } on SocketException catch (_) {
      setState(() {
        isApiCallProcess = false;
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
                      "Update user status",
                    ),
                    actions: [
                      TextButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("Yes"),
                        onPressed: () async {
                          setState(() {
                            isApiCallProcess = true;
                          });
                          Navigator.of(context).pop();
                          await submit(allUser);
                        },
                      )
                    ],
                  ),
                ],
              ));
    } else {
      return await showDialog(
          context: context,
          builder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AlertDialog(
                    title: Text(
                      "Update user status",
                    ),
                    actions: [
                      TextButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("Yes"),
                        onPressed: () async {
                          setState(() {
                            isApiCallProcess = true;
                          });
                          Navigator.of(context).pop();
                          await submit(allUser);
                        },
                      )
                    ],
                  ),
                ],
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
    String userId = allUser.userId;
    String userTypeId = allUser.userTypeId == "1" ? "2" : "1";

    await updateUsers(userId, userTypeId);
    onRefresh();
    // if (updateSupervisors!.status == 200) {

    // }
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
            'Update User Status',
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
                                subtitle:
                                    Text("${listUsersData[index].dateCreated}"),
                                trailing: listUsersData[index].userTypeId == "1"
                                    ? ElevatedButton(
                                        style: raisedButtonStyle,
                                        onPressed: () {
                                          sd(context, listUsersData[index]);
                                        },
                                        child: Text(
                                          'Promote',
                                          style: TextStyle(color: Colors.brown),
                                        ),
                                      )
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          // shape: RoundedRectangleBorder(
                                          //   borderRadius: BorderRadius.circular(32),
                                          //   //borderRadius: BorderRadius.all(Radius.circular(32)),
                                          // ),
                                          padding: EdgeInsets.all(12),
                                          primary: Colors.red[200],
                                        ),
                                        onPressed: () {
                                          sd(context, listUsersData[index]);
                                        },
                                        child: Text(
                                          'Demote',
                                          style: TextStyle(color: Colors.brown),
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
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
