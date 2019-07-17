import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login_demo/pages/findNearDevices.dart';
import 'package:flutter_login_demo/pages/filterDevices.dart';
import 'package:flutter_login_demo/pages/authentication.dart';
import 'package:flutter_login_demo/pages/configureNearDevice.dart';

import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String id;
  //var location = new Location();

  var selectedUbication, selectedBrand;

  int _selectedPage = 0;
  var _pageOptions = [];

  String distanceToLookAround;

  @override
  initState() {
    super.initState();
    repeatLookForNearDevices();
    //getDistanceToLookAround();

    final String id = widget.userId;
    final String dist = "hola";
    _pageOptions = [
      FilterDevices(
        userId: id,
      ),
      FindNearDevices(
        userId: id,
        distanceToLookAround: distanceToLookAround ,
      )
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  lookForNearDevices() async {
    try {
      var location = new Location();
      LocationData userLocation;
      userLocation = await location.getLocation();
      var latitude = userLocation.latitude;
      var longitude = userLocation.longitude;
      DateTime now = DateTime.now();

      FirebaseDatabase database = new FirebaseDatabase();
      DatabaseReference _userRef =
          database.reference().child('devicetriangulation');

      _userRef.push().set({
        'iduser': widget.userId,
        'latitude': latitude,
        'longitude': longitude,
        //'timestamp': DateTime.now();,
      });
    } catch (e) {
      e.toString();
    }
  }

  repeatLookForNearDevices() {
    const oneMin = const Duration(minutes: 1);
    new Timer.periodic(oneMin, (Timer t) => lookForNearDevices());
    print("Repitiendo");
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          title: new Text('Sense Control App'),
          elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 00,
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                currentAccountPicture: new CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  child: new Text("Picture"),
                ),
                accountName: new Text("Misael"),
                accountEmail: new Text("misaelastorgac@gmail.com"),
              ),
              new Divider(),
              new ListTile(
                trailing: new Icon(Icons.settings),
                title: new Text("Control of Devices"),
                onTap: () => Navigator.of(context).pop(),
              ),
              new ListTile(
                  trailing: new Icon(Icons.network_wifi),
                  title: new Text("Configure Find Near Devices Mode "),
                  onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfigureNearDevice()))
                          .then((string) {
                        distanceToLookAround = string;
                        print(distanceToLookAround);
                      })),
              new Divider(),
              new ListTile(
                trailing: new Icon(Icons.exit_to_app),
                title: new Text("Logout"),
                onTap: () => _signOut(),
              ),
            ],
          ),
        ),
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Filters'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.signal_wifi_4_bar),
              title: Text('Find Near Devices'),
            ),
          ],
          currentIndex: _selectedPage,
          selectedItemColor: Colors.lightBlue[900],
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
        ));
  }
}
