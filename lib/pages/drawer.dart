import 'package:flutter/material.dart';
import 'package:oyfxos/pages/balance.dart';
import 'package:oyfxos/pages/helper.dart';
import 'package:oyfxos/pages/login_page.dart';
import 'package:oyfxos/pages/supervisors.dart';
import 'package:oyfxos/pages/users.dart';
import 'package:oyfxos/pages/withdrawal_login.dart';
import 'package:oyfxos/pages/withdrawals.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (userData!.userTypeId == "1")
        ? Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName:
                      Text('${userData!.firstName} ${userData!.lastName}'),
                  accountEmail: Text('${userData!.email}'),
                  currentAccountPicture: CircleAvatar(
                    child: Text(
                      '${userData!.lastName[0]}',
                      style: TextStyle(
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    var route = new MaterialPageRoute(
                      builder: (BuildContext context) => new BalancePage(
                        userData: userData,
                      ),
                    );
                    Navigator.of(context).push(route);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.money),
                  title: Text('Withdrawal'),
                  onTap: () {
                    var route = new MaterialPageRoute(
                      builder: (BuildContext context) => new WithdrawalLogin(
                        userData: userData,
                      ),
                    );
                    Navigator.of(context).push(route);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.money),
                  title: Text('Withdrawal Display'),
                  onTap: () {
                    var route = new MaterialPageRoute(
                      builder: (BuildContext context) => new Withdrawals(
                        userData: userData,
                        supervisorData: supervisorData,
                      ),
                    );
                    Navigator.of(context).push(route);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout_rounded),
                  title: Text(
                    "Logout",
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return LoginPage();
                      }),
                    );
                  },
                ),
              ],
            ),
          )
        : Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName:
                      Text('${userData!.firstName} ${userData!.lastName}'),
                  accountEmail: Text('${userData!.email}'),
                  currentAccountPicture: CircleAvatar(
                    child: Text(
                      '${userData!.lastName[0]}',
                      style: TextStyle(
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    var route = new MaterialPageRoute(
                      builder: (BuildContext context) => new Users(
                        userData: userData,
                      ),
                    );
                    Navigator.of(context).push(route);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.money_outlined),
                  title: Text('All Withdrawals'),
                  onTap: () {
                    var route = new MaterialPageRoute(
                      builder: (BuildContext context) => new Withdrawals(
                        userData: userData,
                        supervisorData: supervisorData,
                      ),
                    );
                    Navigator.of(context).push(route);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('All Supervisors'),
                  onTap: () {
                    var route = new MaterialPageRoute(
                      builder: (BuildContext context) => new Supervisor(
                        userData: userData,
                      ),
                    );
                    Navigator.of(context).push(route);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout_rounded),
                  title: Text(
                    "Logout",
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return LoginPage();
                      }),
                    );
                  },
                ),
              ],
            ),
          );
  }
}
