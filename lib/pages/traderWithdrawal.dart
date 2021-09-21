import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oyfxos/model/model.dart';
import 'package:oyfxos/pages/helper.dart';
import 'package:http/http.dart' as http;

// class BuildStream extends StatefulWidget {
//   const BuildStream({Key? key}) : super(key: key);

//   @override
//   _BuildStreamState createState() => _BuildStreamState();
// }

// class _BuildStreamState extends State<BuildStream> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<TraderWithdrawal>(
//         stream: getTraderWithdrawals(Duration(seconds: 2)),
//         builder:
//             (BuildContext context, AsyncSnapshot<TraderWithdrawal> snapshot) {
//           if (snapshot.hasData)
//             return ListView.builder(
//               itemCount: snapshot.data!.userWithdrawal.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Card(
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       child: Text('${index + 1}'),
//                       radius: 20.0,
//                     ),
//                     title: Text(
//                       "${snapshot.data!.userWithdrawal[index].supervisorName}",
//                     ),
//                     subtitle: Text(
//                       "Date ${snapshot.data!.userWithdrawal[index].dateCreated}",
//                     ),
//                     trailing: Text(
//                         "\$${snapshot.data!.userWithdrawal[index].amount}"),
//                   ),
//                 );
//               },
//             );
//           return Container(
//               padding: EdgeInsets.all(16),
//               color: Colors.black.withOpacity(0.8),
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     _getLoadingIndicator(),
//                     _getHeading(),
//                   ]));
//         });
//   }
// }

// Stream<TraderWithdrawal> getTraderWithdrawals(Duration refreshTime) async* {
//   while (true) {
//     await Future.delayed(refreshTime);

//     yield await getTraderWithdrawal();
//   }
// }

// Widget _getHeading() {
//   return Padding(
//       child: Text(
//         'Please wait …',
//         style: TextStyle(color: Colors.white, fontSize: 16),
//         textAlign: TextAlign.center,
//       ),
//       padding: EdgeInsets.only(bottom: 4));
// }

// Widget _getLoadingIndicator() {
//   return Padding(
//       child: Container(
//           child: CircularProgressIndicator(strokeWidth: 3),
//           width: 32,
//           height: 32),
//       padding: EdgeInsets.only(bottom: 16));
// }

// Future<TraderWithdrawal> getTraderWithdrawal() async {
//   String userEmail = userData!.email;
//   TraderWithdrawal traderWithdrawal;
//   final response = await http.get(
//     Uri.parse(
//         'https://tunishub.com/oyfx_api/api/withdrawal/read_user_withdrawal.php?email=$userEmail'),
//   );
//   print(response.statusCode);

//   print(response.body);

//   traderWithdrawal = new TraderWithdrawal.fromJson(json.decode(response.body));
//   traderWithdrawal.userWithdrawal.forEach((element) {
//     print(element.supervisorName);
//   });

//   return traderWithdrawal;
// }

class BuildStream extends StatefulWidget {
  const BuildStream({Key? key}) : super(key: key);

  @override
  _BuildStreamState createState() => _BuildStreamState();
}

class _BuildStreamState extends State<BuildStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TraderWithdrawal>(
        stream: getTraderWithdrawals(Duration(seconds: 5)),
        builder:
            (BuildContext context, AsyncSnapshot<TraderWithdrawal> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.userWithdrawal.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        '${snapshot.data!.userWithdrawal.length - index}',
                      ),
                      radius: 20.0,
                    ),
                    title: Text(
                      "${snapshot.data!.userWithdrawal[index].supervisorName}",
                    ),
                    subtitle: Text(
                      "Date ${snapshot.data!.userWithdrawal[index].dateCreated}",
                    ),
                    trailing: Text(
                      "\$${snapshot.data!.userWithdrawal[index].amount}",
                    ),
                  ),
                );
              },
            );
          } else {
            if (Platform.isIOS) {
              return Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.white.withOpacity(0.8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CupertinoActivityIndicator(
                        radius: 20.0,
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.white.withOpacity(0.8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [CircularProgressIndicator()],
                  ),
                ),
              );
            }
          }
        });
  }
}

Stream<TraderWithdrawal> getTraderWithdrawals(Duration refreshTime) async* {
  while (true) {
    await Future.delayed(refreshTime);

    yield await getTraderWithdrawal();
  }
}

// Widget _getHeading() {
//   return Padding(
//       child: Text(
//         'Please wait …',
//         style: TextStyle(color: Colors.white, fontSize: 16),
//         textAlign: TextAlign.center,
//       ),
//       padding: EdgeInsets.only(bottom: 4));
// }

// Widget _getLoadingIndicator() {
//   return Padding(
//       child: Container(
//           child: CircularProgressIndicator(strokeWidth: 3),
//           width: 32,
//           height: 32),
//       padding: EdgeInsets.only(bottom: 16));
// }

Future<TraderWithdrawal> getTraderWithdrawal() async {
  String userEmail = userData!.email;
  //String userType = userData!.userTypeId;
  TraderWithdrawal traderWithdrawal;

  try {
    if (userData!.userTypeId == "1") {
      final response = await http
          .get(
            Uri.parse(
              'https://tunishub.com/oyfx_api/api/withdrawal/read_user_withdrawal.php?email=$userEmail',
            ),
          )
          .timeout(Duration(seconds: 5));
      print(response.statusCode);
      print('Stream: $userEmail');
      print(response.body);

      traderWithdrawal =
          new TraderWithdrawal.fromJson(json.decode(response.body));
      traderWithdrawal.userWithdrawal.forEach((element) {
        print(element.supervisorName);
      });

      if (response.statusCode == 200) {
        return traderWithdrawal;
      } else {
        throw Exception('Failed');
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

      traderWithdrawal =
          new TraderWithdrawal.fromJson(json.decode(supervisorResponse.body));
      traderWithdrawal.userWithdrawal.forEach((element) {
        print(element.supervisorName);
      });

      if (supervisorResponse.statusCode == 200) {
        return traderWithdrawal;
      } else {
        throw Exception('Failed');
      }
    }
  } on SocketException catch (_) {
    throw Exception();
  } on TimeoutException catch (_) {
    throw Exception();
  }
}
