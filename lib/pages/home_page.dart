import 'package:flutter/material.dart';
import 'package:flutter_login_demo/pages/collected_data_page.dart';
import 'package:flutter_login_demo/pages/authentication.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert' show Encoding, json;
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
    this.auth,
    this.userId,
    this.onSignedOut,
  }) : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String globalstate;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  

    Future<bool> _sendAction(String state) async {
      final postUrl = 'https://fcm.googleapis.com/fcm/send';
      final data = {
        "notification": {"body": "The state has been changed", "title": "Sense App'"},
        "data": {"status": "$state"},
        "to": "/topics/"+widget.userId,
      };

      final headers = {
        'content-type': 'application/json',
        'Authorization': 'key=AAAAi7XpfEw:APA91bGVV_FDHpziuwOzCxy229-NdJD2mPSxTIOatXdDbrQFoux6BuhWR6088sJ23zy__71ij4oHP5TC3W-hVtTM9pMTplB5li5YwGsjHjOm3NTpcw9ZxCOuFSGMpXE0A9CxM7PmCxPB'
      };

      final response = await http.post(postUrl,
          body: json.encode(data),
          encoding: Encoding.getByName('utf-8'),
          headers: headers);

      if (response.statusCode == 200) {
        print(response.toString());
        return true;
      } else {
         print(response.toString());
        return false;
      }
    }
  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text('Censing'),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 00,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: new Text("P"),
              ),
              accountName: new Text("Prueba"),
              accountEmail: new Text("Prueba@gmail.com"),
            ),
            new Divider(),
            new ListTile(
              trailing: new Icon(Icons.settings),
              title: new Text("Functions"),
              onTap: () => Navigator.of(context).pop(),
            ),
            new ListTile(
                trailing: new Icon(Icons.timeline),
                title: new Text("Data Collected"),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CollectedData("Censing"),
                    ))),
            new Divider(),
            new ListTile(
              trailing: new Icon(Icons.exit_to_app),
              title: new Text("Logout"),
              onTap: () => _signOut(),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              onPressed: () => _sendAction("Start")
                  // setState(() => state = "Start");
                  ,
              color: Colors.white,
              padding: EdgeInsets.all(10.0),
              child: Column(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[Icon(Icons.play_arrow), Text("Play")],
              ),
            ),
            FlatButton(
              onPressed: () => _sendAction("Pause"),
              color: Colors.white,
              padding: EdgeInsets.all(10.0),
              child: Column(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[Icon(Icons.pause), Text("Pause ")],
              ),
            ),
            FlatButton(
              onPressed: () => _sendAction("Stop"),
              color: Colors.white,
              padding: EdgeInsets.all(10.0),
              child: Column(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[Icon(Icons.stop), Text("Stop")],
              ),
            )
          ],
        ),
      ),
    );
  }
}
