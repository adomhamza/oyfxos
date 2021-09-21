import 'package:flutter/material.dart';
import 'package:oyfxos/api/api.dart';
import 'package:oyfxos/model/model.dart';
import 'package:oyfxos/pages/ProgressHUD.dart';
import 'package:oyfxos/pages/drawer.dart';
import 'package:oyfxos/pages/login_page.dart';
import 'package:uuid/uuid.dart';

class BalancePage extends StatefulWidget {
  final Login? userData;

  const BalancePage({Key? key, this.userData}) : super(key: key);

  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  final TextEditingController _controllerClosing = new TextEditingController();
  final TextEditingController _controllerOpening = new TextEditingController();
  String dropdownValue = 'Opening Balance';
  final _formKey = GlobalKey<FormState>();

  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: Scaffold(
        drawer: DrawerPage(),
        appBar: AppBar(
          title: Text("Balance Sheet"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return LoginPage();
                    }),
                  );
                },
                icon: Icon(Icons.logout_rounded))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: dropdownValue,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['Opening Balance', 'Closing Balance']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(
              height: 100.0,
            ),
            Center(
              child: (dropdownValue == 'Opening Balance')
                  ? Form(
                      key: _formKey,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        child: TextFormField(
                          controller: _controllerOpening,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Amount is required";
                            }

                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Opening Equity Balance',
                          ),
                        ),
                      ),
                    )
                  : Form(
                      key: _formKey,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        child: TextFormField(
                          controller: _controllerClosing,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Amount is required";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Closing Equity Balance',
                          ),
                        ),
                      ),
                    ),
            ),
            SizedBox(
              height: 20.0,
            ),
            (dropdownValue == 'Opening Balance')
                ? ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isApiCallProcess = true;
                        });
                        String amount = _controllerOpening.text;
                        String email = widget.userData!.email;
                        String openingBalId = Uuid().v4().toString();

                        APIService apiService = APIService();
                        apiService
                            .open(
                          openingBalId,
                          amount,
                          email,
                        )
                            .then((response) {
                          if (response.statusCode == 201) {
                            setState(() {
                              isApiCallProcess = false;
                              _controllerOpening.clear();
                            });
                            final snackBar = SnackBar(
                              content: Text("Success"),
                              duration: Duration(seconds: 5),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 24.0, right: 24.0),
                      child: Text('Submit',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                        //borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      padding: EdgeInsets.all(12),
                      primary: Colors.lightBlueAccent,
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isApiCallProcess = true;
                        });
                        String amount = _controllerClosing.text;
                        String email = widget.userData!.email;
                        String closingBalId = Uuid().v4().toString();
                        APIService apiService = APIService();
                        apiService
                            .close(
                          closingBalId,
                          amount,
                          email,
                        )
                            .then((response) {
                          if (response.statusCode == 201) {
                            setState(() {
                              isApiCallProcess = false;
                              _controllerClosing.clear();
                            });
                            final snackBar = SnackBar(
                              content: Text("Success"),
                              duration: Duration(seconds: 5),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 24.0,
                        right: 24.0,
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    style: raisedButtonStyle,
                  )
          ],
        ),
      ),
    );
  }
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(32),
    //borderRadius: BorderRadius.all(Radius.circular(32)),
  ),
  padding: EdgeInsets.all(12),
  primary: Colors.red,
);
