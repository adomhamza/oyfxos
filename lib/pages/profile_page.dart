import 'package:flutter/material.dart';
import 'package:oyfxos/data/local_storage.dart';
import 'package:oyfxos/model/model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final Login? userData;
  const ProfilePage({Key? key, this.userData}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        height: 700,
        width: double.infinity,
        child: StreamBuilder(
          stream: database.watchAllUsers(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Trader>> snapshot) {
            if (snapshot.hasData)
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                          radius: 20.0,
                        ),
                        title: Text(
                            "${snapshot.data![index].firstName} ${snapshot.data![index].lastName}"),
                        subtitle: Text(
                            "Date Created ${snapshot.data![index].dateCreated}"),
                        trailing: IconButton(
                          icon: Icon(Icons.delete_outline),
                          onPressed: () {
                            setState(() {
                              database.deleteUser(snapshot.data![index]);
                            });
                          },
                          color: Colors.red,
                        )),
                  );
                },
              );
            return Container(
                padding: EdgeInsets.all(16),
                color: Colors.black.withOpacity(0.8),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _getLoadingIndicator(),
                      _getHeading(),
                      _getText('Text')
                    ]));
          },
        ),
      ),
    );
  }
}

Widget _getLoadingIndicator() {
  return Padding(
      child: Container(
          child: CircularProgressIndicator(strokeWidth: 3),
          width: 32,
          height: 32),
      padding: EdgeInsets.only(bottom: 16));
}

Widget _getHeading() {
  return Padding(
      child: Text(
        'Please wait …',
        style: TextStyle(color: Colors.white, fontSize: 16),
        textAlign: TextAlign.center,
      ),
      padding: EdgeInsets.only(bottom: 4));
}

Widget _getText(String displayedText) {
  return Text(
    displayedText,
    style: TextStyle(color: Colors.white, fontSize: 14),
    textAlign: TextAlign.center,
  );
}
