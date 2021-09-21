import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:oyfxos/model/model.dart';
import 'package:oyfxos/pages/ProgressHUD.dart';
import 'package:oyfxos/pages/balance.dart';
import 'package:oyfxos/pages/dialog.dart';
import 'package:oyfxos/pages/helper.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController controllerFirstName = new TextEditingController();
  TextEditingController controllerLastName = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();
  //TextEditingController controllerPhone = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  TextEditingController controllerConfirmPassword = new TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool isApiCallProcess = false;

  register(
    String userId,
    int userTypeId,
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    try {
      final response = await http
          .post(Uri.parse('https://tunishub.com/oyfx_api/api/user/create.php'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode({
                "first_name": firstName,
                "last_name": lastName,
                "email": email,
                "password": password,
                "user_type_id": userTypeId,
                "user_id": userId,
              }))
          .timeout(Duration(seconds: 5));
      print(response.statusCode);
      if (response.statusCode == 201 ||
          response.statusCode == 404 ||
          response.statusCode == 503) {
        String responseString = response.body;
        userData = Login.fromJson(json.decode(responseString));
        setState(() {});
      } else {
        throw Exception('Failed');
      }
    } on SocketException catch (_) {
      setState(() {
        isApiCallProcess = false;
      });
      showAlertDialog(
        title: 'Connection Error',
        context: context,
        content: 'Please Check Internet',
        defaultActionText: 'OK',
      );
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
        content: 'Email already exist.',
        defaultActionText: 'OK',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(),
          body: Center(
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                children: <Widget>[
                  logo,
                  TextFormField(
                    controller: controllerFirstName,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      hintText: 'First Name',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "First Name is Required";
                      } else if (value.length < 3) {
                        return "First Name should be NOT be less than 3 characters long";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),

                  TextFormField(
                    controller: controllerLastName,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      hintText: 'Last Name',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Last Name is Required";
                      } else if (value.length < 3) {
                        return "Last Name should be NOT be less than 3 characters long";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),

                  TextFormField(
                    controller: controllerEmail,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      hintText: 'Email',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email is required";
                      } else if (!RegExp(
                              "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return "Please enter valid email address";
                      }
                      return null;
                    },
                  ),
                  //SizedBox(height: 60),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: <Widget>[
                  //     Text("Phone:", style: TextStyle(fontSize: 18)),
                  //     SizedBox(width: 20),
                  //     Expanded(
                  //       child: TextFormField(
                  //         keyboardType: TextInputType.number,
                  //         inputFormatters: [
                  //           FilteringTextInputFormatter.digitsOnly
                  //         ],
                  //         controller: controllerPhone,
                  //         decoration: InputDecoration(
                  //           hintText: "Please enter Phone number",
                  //         ),
                  //         validator: (value) {
                  //           if (value == null || value.trim().isEmpty) {
                  //             return "Phone number is Required";
                  //           }
                  //           return null;
                  //         },
                  //       ),
                  //     )
                  //   ],
                  // ),
                  SizedBox(height: 30),

                  TextFormField(
                    controller: controllerPassword,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.4),
                        icon: Icon(hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      hintText: 'Password',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                    obscureText: hidePassword,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Password is Required";
                      } else if (value.length < 8) {
                        return "Password should be NOT be less than 8 characters long";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),

                  TextFormField(
                    controller: controllerConfirmPassword,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hideConfirmPassword = !hideConfirmPassword;
                          });
                        },
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.4),
                        icon: Icon(hideConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      hintText: 'Confirm Password',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                    obscureText: hideConfirmPassword,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Confirm Password";
                      } else if (value.length < 8) {
                        return "Password should be NOT be less than 8 characters long";
                      } else if (controllerPassword.text !=
                          controllerConfirmPassword.text) {
                        return "Passwords do NOT match";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 40),

                  ElevatedButton(
                    style: raisedButtonStyle,
                    child: Text("Submit",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // var getFirstName = controllerFirstName.text;
                        // var getLastName = controllerLastName.text;
                        // var getUserName = controllerUserName.text;
                        // var getPassword = controllerPassword.text;

                        // MySharedPreferences.instance
                        //     .setStringValue("fname", getFirstName);
                        // MySharedPreferences.instance
                        //     .setStringValue("lname", getLastName);
                        // MySharedPreferences.instance
                        //     .setStringValue("username", getUserName);
                        // MySharedPreferences.instance
                        //     .setStringValue("password", getPassword);
                        // MySharedPreferences.instance
                        //     .setBooleanValue("loggedin", true);
                        // registerUser();
                        // print('Succes');
                        setState(() {
                          isApiCallProcess = true;
                        });
                        String userId = Uuid().v4().toString();
                        int userTypeId = 1;
                        String firstName = controllerFirstName.text;
                        String lastName = controllerLastName.text;
                        String email = controllerEmail.text;
                        String password = controllerPassword.text;
                        //int phone = int.parse(controllerPhone.text);
                        await register(
                          userId,
                          userTypeId,
                          firstName,
                          lastName,
                          email,
                          password,
                        );
                        if (userData != null) {
                          if (userData!.status == 201) {
                            setState(() {
                              isApiCallProcess = false;
                              controllerFirstName.clear();
                              controllerLastName.clear();
                              controllerEmail.clear();
                              controllerPassword.clear();
                              controllerConfirmPassword.clear();
                            });

                            final snackBar = SnackBar(
                              content: Text(userData!.message),
                              duration: Duration(seconds: 2),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            // SnackBar();
                            var route = new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new BalancePage(
                                userData: userData,
                              ),
                            );

                            Navigator.of(context).push(route);
                          } else if (userData!.status == 404) {
                            setState(() {
                              isApiCallProcess = false;
                            });

                            final snackBar = SnackBar(
                              content: Text(userData!.message),
                              duration: Duration(seconds: 2),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                        print("password: $password");
                        print("email: $email");
                        print("user_id: $userId");
                        print("lastName: $lastName");
                        print("firstName: $firstName");
                        print("userTypeId: $userTypeId");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future registerUser() async {
  //   Map mapdata = {
  //     "first_name": controllerFirstName.text,
  //     "last_name": controllerLastName.text,
  //     "username": controllerUserName.text,
  //     "phone": controllerPhone.text,
  //     "password": controllerPassword.text,
  //     "user_type_id": "18",
  //     "user_id": Uuid().v4().toString()
  //   };
  //   http.Response response = await http.post(
  //       Uri.https('tunishub.com', '/oyfx_api/api/user/create.php'),
  //       body: mapdata);
  //   var data = jsonDecode(response.body);
  //   print(data);
  // }
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(32),
    //borderRadius: BorderRadius.all(Radius.circular(32)),
  ),
  padding: EdgeInsets.all(12),
  primary: Colors.lightBlueAccent,
);
final logo = Hero(
  tag: 'hero',
  child: CircleAvatar(
    backgroundColor: Colors.transparent,
    radius: 48.0,
    //child: Image.asset(),
  ),
);
