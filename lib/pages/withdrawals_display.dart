import 'package:flutter/material.dart';
//import 'package:oyfxos/data/local_storage.dart';
import 'package:oyfxos/model/model.dart';
import 'package:oyfxos/pages/helper.dart';
import 'package:oyfxos/pages/traderWithdrawal.dart';
import 'package:oyfxos/pages/withdrawal.dart';
//import 'package:oyfxos/pages/helper.dart';
//import 'package:oyfxos/pages/new_withdrawal_input.dart';
//import 'package:provider/provider.dart';

class WithdrawDisplayPage extends StatefulWidget {
  final Login? userData;
  final Supervisor? supervisorData;

  const WithdrawDisplayPage({Key? key, this.userData, this.supervisorData})
      : super(key: key);

  @override
  _WithdrawDisplayPageState createState() => _WithdrawDisplayPageState();
}

class _WithdrawDisplayPageState extends State<WithdrawDisplayPage> {
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                listUserWithdrawalDetails.clear();
                getTraderWithdrawal();
                setState(() {
                  isApiCallProcess = false;
                });
              },
              icon: Icon(Icons.refresh))
        ],
        title: Text(
          'Withdrawals',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Withdrawal(),
          ),
          //     NewWithdrawalInput(),
        ],
      ),
    );
  }
}
