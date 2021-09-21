import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:oyfxos/model/model.dart';
import 'package:oyfxos/pages/ProgressHUD.dart';
import 'package:oyfxos/pages/balance.dart';
import 'package:http/http.dart' as http;
import 'package:oyfxos/pages/dialog.dart';
import 'package:oyfxos/pages/helper.dart';
import 'package:oyfxos/pages/users.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerEmail = new TextEditingController();
  final TextEditingController _controllerPassword = new TextEditingController();
  bool hidePassword = true;
  bool isApiCallProcess = false;

  login(
    String email,
    String password,
  ) async {
    try {
      final response = await http
          .post(Uri.parse('https://tunishub.com/oyfx_api/api/user/login.php'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode({
                "email": email,
                "password": password,
              }))
          .timeout(Duration(seconds: 5));
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 404) {
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
        content: 'Please check internet and try again',
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
        content: 'Please contact support or try again later',
        defaultActionText: 'OK',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        //child: Image.asset(),
      ),
    );
    final email = TextFormField(
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.email,
          color: Theme.of(context).colorScheme.secondary,
        ),
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Email is required";
        } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
            .hasMatch(value)) {
          return "Please enter valid email address";
        }
        return null;
      },
    );

    final password = TextFormField(
      controller: _controllerPassword,
      autofocus: false,
      obscureText: hidePassword,
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
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
          icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
        ),
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () async {
          String userEmail = _controllerEmail.text;
          String password = _controllerPassword.text;
          if (_formKey.currentState!.validate()) {
            setState(() {
              isApiCallProcess = true;
            });
            await login(userEmail, password);
            if (userData != null) {
              if (userData!.status == 200) {
                setState(() {
                  isApiCallProcess = false;
                });

                final snackBar = SnackBar(
                  content: Text(userData!.message),
                  duration: Duration(seconds: 1),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                // SnackBar();
                var route = new MaterialPageRoute(
                  builder: (BuildContext context) => new BalancePage(
                    userData: userData,
                  ),
                );
                var routes = new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new Users(userData: userData),
                );
                if (userData!.userTypeId == "1") {
                  Navigator.of(context).push(route);
                } else {
                  Navigator.of(context).pushReplacement(routes);
                }

                //print(respones.body);
              } else if (userData!.status == 401) {
                setState(() {
                  isApiCallProcess = false;
                });

                final snackBar = SnackBar(
                  content: Text(userData!.message),
                  duration: Duration(seconds: 1),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                //print(respones.statusCode);
              }
            }
          }
        },
        child: Text('Log In',
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
      ),
    );

    // final forgotLabel = TextButton(
    //   child: Text(
    //     'Forgot password?',
    //     style: TextStyle(color: Colors.black54),
    //   ),
    //   onPressed: () {},
    // );
    final registerLabel = TextButton(
      child: Text(
        'No Account?  Register Here',
        style: TextStyle(color: Colors.amberAccent),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed('registerPage');
      },
    );
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                logo,
                SizedBox(height: 48.0),
                email,
                SizedBox(height: 8.0),
                password,
                SizedBox(height: 24.0),
                loginButton,
                registerLabel,
                //forgotLabel
              ],
            ),
          ),
        ),
      ),
    );
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32),
      //borderRadius: BorderRadius.all(Radius.circular(32)),
    ),
    padding: EdgeInsets.all(12),
    primary: Colors.lightBlueAccent,
  );

  // FutureBuilder<Login> buildFutureBuilder() {
  //   return FutureBuilder<Login>(
  //       future: _fututeLogin,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           return BalancePage();
  //         } else if (snapshot.hasError) {
  //           return Text("err: ${snapshot.error}");
  //         }
  //         return CircularProgressIndicator();
  //       });
  // }
}
