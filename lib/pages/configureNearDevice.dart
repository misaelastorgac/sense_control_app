import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login_demo/pages/filteredDevices.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_login_demo/pages/findNearDevices.dart';
import 'package:flutter_login_demo/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigureNearDevice extends StatefulWidget {
  ConfigureNearDevice({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new ConfigureNearDeviceState();
}

class ConfigureNearDeviceState extends State<ConfigureNearDevice> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  int distance;


  setDistanceToLookAround(BuildContext context, int distance) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt("distanceToLookAround", distance);

     Navigator.pop(context, distance.toString());


  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: new AppBar(
        title: new Text("Configure Near Device Mode"),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              new TextField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.device_unknown),
                  hintText: 'Enter distance to search around',
                  labelText: 'Distance in meters',
                ),
                autofocus: true,
                onChanged: (String value) {
                  distance = int.parse(value);
                },
              ),
              new Divider(
                height: 30,
                color: Colors.blue,
              ),
              new Container(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: new RaisedButton(
                    child: const Text('SAVE'),
                    color: Colors.blue,
                    onPressed: () => setDistanceToLookAround(context,distance),
                  ))
            ],
          )),
    );
  }
}
