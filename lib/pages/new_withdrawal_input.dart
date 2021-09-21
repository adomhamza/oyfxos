import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oyfxos/api/api.dart';
//import 'package:oyfxos/data/local_storage.dart';
import 'package:oyfxos/model/model.dart';
import 'package:oyfxos/pages/ProgressHUD.dart';
import 'package:oyfxos/pages/balance.dart';
//import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class NewWithdrawalInput extends StatefulWidget {
  final Login? userData;
  final Supervisor? supervisorData;

  const NewWithdrawalInput({Key? key, this.userData, this.supervisorData})
      : super(key: key);

  @override
  _NewWithdrawalInputState createState() => _NewWithdrawalInputState();
}

class _NewWithdrawalInputState extends State<NewWithdrawalInput> {
  TextEditingController controllerWithdrawalAmount =
      new TextEditingController();
  bool isApiCallProcess = false;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
    final email = TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      controller: controllerWithdrawalAmount,
      decoration: InputDecoration(
        hintText: "Please enter Withdrawal Amount",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Withdrawal Amount is Required";
        }
        return null;
      },
    );
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            setState(() {
              APIService apiService = APIService();
              String withdrawalId = Uuid().v4().toString();
              String userEmail = widget.userData!.email;
              String traderName =
                  "${widget.userData!.firstName} ${widget.userData!.lastName}";
              String supervisorEmail = widget.supervisorData!.email;
              String supervisorName =
                  "${widget.supervisorData!.firstName} ${widget.supervisorData!.lastName}";
              int amount = int.parse(controllerWithdrawalAmount.text);
              isApiCallProcess = true;
              apiService
                  .withdrawal(withdrawalId, amount, userEmail, supervisorEmail,
                      traderName, supervisorName)
                  .then((response) {
                if (response.statusCode == 201) {
                  setState(() {
                    isApiCallProcess = false;
                    controllerWithdrawalAmount.clear();
                  });

                  final snackBar = SnackBar(
                    content: Text("Successful"),
                    duration: Duration(seconds: 5),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  var route = new MaterialPageRoute(
                    builder: (BuildContext context) => new BalancePage(),
                  );
                  Navigator.of(context).push(route);
                  // SnackBar();
                } else if (response.statusCode == 503) {
                  setState(() {
                    isApiCallProcess = false;
                  });

                  final snackBar = SnackBar(
                    content: Text("Wrong Email/Password"),
                    duration: Duration(seconds: 5),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              });
            });
          }
        },
        child:
            Text('Send', style: TextStyle(color: Colors.white, fontSize: 20.0)),
      ),
    );

    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("data"),
          elevation: 0.0,
        ),
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
                loginButton,
              ],
            ),
          ),
        ),
      ),
    );
    // Padding(
    //   padding: const EdgeInsets.all(16.0),
    //   child: Form(
    //     key: _formKey,
    //     child: Row(
    //       children: [
    //         Expanded(
    //           child: TextFormField(
    //             keyboardType: TextInputType.number,
    //             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    //             controller: controllerWithdrawalAmount,
    //             decoration: InputDecoration(
    //               hintText: "Please enter Withdrawal Amount",
    //             ),
    //             validator: (value) {
    //               if (value == null || value.trim().isEmpty) {
    //                 return "Withdrawal Amount is Required";
    //               }
    //               return null;
    //             },
    //           ),
    //         ),
    //         IconButton(
    //           icon: Icon(Icons.send_rounded),
    //           tooltip: 'Send',
    //           color: Colors.red,
    //           onPressed: () {
    //             if (_formKey.currentState!.validate()) {
    //               String withdrawalId = Uuid().v4().toString();
    //               String userEmail = widget.value!.userEmail;
    //               String supervisorEmail = widget.value2!.supervisorEmail;
    //               int amount = int.parse(controllerWithdrawalAmount.text);
    //               APIService apiService = APIService();
    //               apiService.withdrawal(
    //                 withdrawalId,
    //                 amount,
    //                 supervisorEmail,
    //                 userEmail,
    //               );
    //               // var getFirstName = controllerFirstName.text;
    //               // var getLastName = controllerLastName.text;
    //               // var getUserName = controllerUserName.text;
    //               // var getPassword = controllerPassword.text;

    //               // MySharedPreferences.instance
    //               //     .setStringValue("fname", getFirstName);
    //               // MySharedPreferences.instance
    //               //     .setStringValue("lname", getLastName);
    //               // MySharedPreferences.instance
    //               //     .setStringValue("username", getUserName);
    //               // MySharedPreferences.instance
    //               //     .setStringValue("password", getPassword);
    //               // MySharedPreferences.instance
    //               //     .setBooleanValue("loggedin", true);

    //             }
    //           },
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
