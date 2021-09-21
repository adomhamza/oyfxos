import 'package:flutter/material.dart';
import 'package:oyfxos/data/local_storage.dart';
import 'package:oyfxos/pages/balance.dart';
import 'package:oyfxos/pages/login_page.dart';
import 'package:oyfxos/pages/profile_page.dart';
import 'package:oyfxos/pages/register.dart';
//import 'package:oyfxos/pages/withdrawals_display.dart';
import 'package:oyfxos/pages/withdrawals_display.dart';
//import 'package:oyfxos/pages/withdrawals_display2.dart';
import 'package:provider/provider.dart';

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'OYFX';

  @override
  Widget build(BuildContext context) {
    return Provider<AppDatabase>(
      create: (context) => AppDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(secondary: Colors.redAccent),
          // primaryColor: Colors.white,
          // primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => LoginPage(),
          'registerPage': (context) => RegisterPage(),
          'profilePage': (context) => ProfilePage(),
          'withdrawalPage': (context) => WithdrawDisplayPage(),
          'balancePage': (context) => BalancePage(),
        },
      ),
      dispose: (context, db) => db.close(),
    );
  }
}
