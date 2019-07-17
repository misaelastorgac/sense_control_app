import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login_demo/pages/filteredDevices.dart';
import 'package:firebase_database/firebase_database.dart';

class SingleDevicePage extends StatefulWidget {
  SingleDevicePage({
    Key key,
    this.deviceId,
    this.userId,
  }) : super(key: key);

  final String deviceId;
  final String userId;
  List<String> devicesList = new List();

  @override
  State<StatefulWidget> createState() => new _SingleDevicePageState();
}

class _SingleDevicePageState extends State<SingleDevicePage> {
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _value1Changed(bool value) => setState(() => _value1 = value);
  void _value2Changed(bool value) => setState(() => _value2 = value);
  void _value3Changed(bool value) => setState(() => _value3 = value);

  onPlay(String habilityone, String habilitytwo, String habilitythree) async {
    FirebaseDatabase database = new FirebaseDatabase();
    DatabaseReference _userRef = database.reference().child('instructions');

    if (_value1 == true && _value2 == false && _value3 == false) {
      _userRef.push().set({
        'deviceid': widget.deviceId,
        'userid': widget.userId,
        'instruction': "Start",
        'habilityone': habilityone,
        'time': new DateTime.now().toString(),
      });
    }

    if (_value1 == true && _value2 == true && _value3 == false) {
      _userRef.push().set({
        'deviceid': widget.deviceId,
        'userid': widget.userId,
        'instruction': "Start",
        'habilityone': habilityone,
        'habilitytwo': habilitytwo,
        'time': new DateTime.now().toString(),
      });
    }

    if (_value1 == true && _value2 == false && _value3 == true) {
      _userRef.push().set({
        'deviceid': widget.deviceId,
        'userid': widget.userId,
        'instruction': "Start",
        'habilityone': habilityone,
        'habilitytwo': habilitythree,
        'time': new DateTime.now().toString(),
      });
    }

    if (_value1 == false && _value2 == true && _value3 == false) {
      _userRef.push().set({
        'deviceid': widget.deviceId,
        'userid': widget.userId,
        'instruction': "Start",
        'habilityone': habilitytwo,
        'time': new DateTime.now().toString(),
      });
    }

    if (_value1 == false && _value2 == true && _value3 == true) {
      _userRef.push().set({
        'deviceid': widget.deviceId,
        'userid': widget.userId,
        'instruction': "Start",
        'habilityone': habilitytwo,
        'habilitytwo': habilitythree,
        'time': new DateTime.now().toString(),
      });
    }

    if (_value1 == false && _value2 == false && _value3 == true) {
      _userRef.push().set({
        'deviceid': widget.deviceId,
        'userid': widget.userId,
        'instruction': "Start",
        'habilityone': habilitythree,
        'time': new DateTime.now().toString(),
      });
    }

    if (_value1 == true && _value2 == true && _value3 == true) {
      _userRef.push().set({
        'deviceid': widget.deviceId,
        'userid': widget.userId,
        'instruction': "Start",
        'habilityone': habilityone,
        'habilitytwo': habilitytwo,
        'habilitythree': habilitythree,
        'time': new DateTime.now().toString(),
      });
    }
  }

  onStop(String habilityone, String habilitytwo, String habilitythree) async {
    FirebaseDatabase database = new FirebaseDatabase();
    DatabaseReference _userRef = database.reference().child('instructions');

    if (_value1 == true && _value2 == false && _value3 == false) {
      _userRef.push().set({
        'deviceid': widget.deviceId,
        'userid': widget.userId,
        'instruction': "Stop",
        'habilityone': habilityone,
        'time': new DateTime.now().toString(),
      });
    }

    if (_value1 == true && _value2 == true && _value3 == false) {
      _userRef.push().set({
        'deviceid': widget.deviceId,
        'userid': widget.userId,
        'instruction': "Stop",
        'habilityone': habilityone,
        'habilitytwo': habilitytwo,
        'time': new DateTime.now().toString(),
      });
    }

    if (_value1 == true && _value2 == false && _value3 == true) {
      _userRef.push().set({
        'deviceid': widget.deviceId,
        'userid': widget.userId,
        'instruction': "Stop",
        'habilityone': habilityone,
        'habilitytwo': habilitythree,
        'time': new DateTime.now().toString(),
      });
    }

    if (_value1 == false && _value2 == true && _value3 == false) {
      _userRef.push().set({
        'deviceid': widget.deviceId,
        'userid': widget.userId,
        'instruction': "Stop",
        'habilityone': habilitytwo,
        'time': new DateTime.now().toString(),
      });
    }

    if (_value1 == false && _value2 == true && _value3 == true) {
      _userRef.push().set({
        'deviceid': widget.deviceId,
        'userid': widget.userId,
        'instruction': "Stop",
        'habilityone': habilitytwo,
        'habilitytwo': habilitythree,
        'time': new DateTime.now().toString(),
      });
    }

    if (_value1 == false && _value2 == false && _value3 == true) {
      _userRef.push().set({
        'deviceid': widget.deviceId,
        'userid': widget.userId,
        'instruction': "Stop",
        'habilityone': habilitythree,
        'time': new DateTime.now().toString(),
      });
    }

    if (_value1 == true && _value2 == true && _value3 == true) {
      _userRef.push().set({
        'deviceid': widget.deviceId,
        'userid': widget.userId,
        'instruction': "Stop",
        'habilityone': habilityone,
        'habilitytwo': habilitytwo,
        'habilitythree': habilitythree,
        'time': new DateTime.now().toString(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String deviceid = widget.deviceId;
    String userid = widget.userId;

    return new Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: new AppBar(
        title: new Text(deviceid),
      ),
      body: new Row(
        children: <Widget>[
          Expanded(
              child: SizedBox(
            height: 600.0,
            child: new StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("usuarios/$userid/neardevices")
                    .where('id', isEqualTo: deviceid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text('Connecting...');
                  final DocumentSnapshot _card = snapshot.data.documents[0];

                  return new Container(
                    padding: new EdgeInsets.all(32.0),
                    child: new Column(
                      children: <Widget>[
                        new Icon(
                          Icons.smartphone,
                          size: 30,
                        ),
                        new Text(
                          'Device Name: ' + _card['name'],
                        ),
                        new Text('Device Id: ' + _card['id']),
                        new Text('Semantic Ubication: ' +
                            _card['semanticubication']),
                        new Text('Distance: ' +
                            _card['distance'].toString() +
                            ' Meters'),
                        new CheckboxListTile(
                          value: _value1,
                          onChanged: _value1Changed,
                          title: new Text(_card['habilityone']),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Colors.blue[1000],
                        ),
                        new CheckboxListTile(
                          value: _value2,
                          onChanged: _value2Changed,
                          title: new Text(_card['habilitytwo']),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Colors.blue[1000],
                        ),
                        new CheckboxListTile(
                          value: _value3,
                          onChanged: _value3Changed,
                          title: new Text(_card['habilitythree']),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Colors.blue[1000],
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () => onPlay(_card['habilityone'],
                                  _card['habilitytwo'], _card['habilitythree'])
                              // setState(() => state = "Start");
                              ,
                              color: Colors.blue[100],
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                // Replace with a Row for horizontal icon + text
                                children: <Widget>[
                                  Icon(Icons.play_arrow),
                                  Text("Start")
                                ],
                              ),
                            ),
                            FlatButton(
                                onPressed: () => onStop(
                                    _card['habilityone'],
                                    _card['habilitytwo'],
                                    _card['habilitythree']),
                                color: Colors.blue[100],
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  // Replace with a Row for horizontal icon + text
                                  children: <Widget>[
                                    Icon(Icons.stop),
                                    Text("Stop")
                                  ],
                                ))
                          ],
                        )
                      ],
                    ),
                  );
                }),
          ))
        ],
      ),
    );
  }
}
