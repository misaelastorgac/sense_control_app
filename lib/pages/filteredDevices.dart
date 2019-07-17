import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login_demo/pages/authentication.dart';
import 'package:firebase_database/firebase_database.dart';

class FilteredDevices extends StatefulWidget {
  FilteredDevices(
      {Key key,
      this.title,
      this.devicesList,
      this.habilityList,
      this.userId,
      this.namesList,
      this.auth})
      : super(key: key);

  final String title;
  List<String> devicesList = new List();
  List<String> habilityList = new List();
  List<String> namesList = new List();
  //Map<String, bool> values = {};
  final String userId;
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _MyAppState();
}

class _MyAppState extends State<FilteredDevices> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String globalstate;
  final Map<String, bool> values = {};
  List<String> devicesList = new List();
  List<String> habilitiesList = new List();
  List<String> namesList = new List();

  var userId;

  //_MyAppState() {}

  @override
  void initState() {
    super.initState();
    devicesList = widget.devicesList;
    userId = widget.userId;
    namesList = widget.namesList;
    deviceState(userId, devicesList);
    habilitiesList = widget.habilityList;
  }

  @override
  void dispose() {
    super.dispose();
  }

  deviceState(String userid, List<String> devicesList) async {
    for (var i = 0; i < devicesList.length; i++) {
      values[devicesList[i]] = false;
    }
  }

  onPlay() async {
    FirebaseDatabase database = new FirebaseDatabase();
    DatabaseReference _userRef = database.reference().child('instructions');
    for (var i = 0; i < values.length; i++) {
      var deviceId =
          values.keys.firstWhere((k) => values[k] == true, orElse: () => null);
      if (deviceId == null) {
        break;
      }
      print(deviceId);

      print(habilitiesList.length);

      if (habilitiesList.length == 1) {
        print("aqui");
        _userRef.push().set({
          'deviceid': deviceId,
          'userid': userId,
          'instruction': "Start",
          'habilityone': habilitiesList[0],
          'time': new DateTime.now().toString(),
        });
      }

      if (habilitiesList.length == 2) {
        _userRef.push().set({
          'deviceid': deviceId,
          'userid': userId,
          'instruction': "Start",
          'habilityone': habilitiesList[0],
          'habilitytwo': habilitiesList[1],
          'time': new DateTime.now().toString(),
        });
      }

      if (habilitiesList.length == 3) {
        _userRef.push().set({
          'deviceid': deviceId,
          'userid': userId,
          'instruction': "Start",
          'habilityone': habilitiesList[0],
          'habilitytwo': habilitiesList[1],
          'habilitythree': habilitiesList[2],
          'time': new DateTime.now().toString(),
        });
      }
               values[deviceId] = false;

    }
  }

  onStop() async {
    FirebaseDatabase database = new FirebaseDatabase();
    DatabaseReference _userRef = database.reference().child('instructions');
    for (var i = 0; i < values.length; i++) {
      var deviceId =
          values.keys.firstWhere((k) => values[k] == true, orElse: () => null);
      if (deviceId == null) {
        break;
      }
      print(deviceId);

      print(habilitiesList.length);

      if (habilitiesList.length == 1) {
        print("aqui");
        _userRef.push().set({
          'deviceid': deviceId,
          'userid': userId,
          'instruction': "Stop",
          'habilityone': habilitiesList[0],
        });
      }

      if (habilitiesList.length == 2) {
        _userRef.push().set({
          'deviceid': deviceId,
          'userid': userId,
          'instruction': "Stop",
          'habilityone': habilitiesList[0],
          'habilitytwo': habilitiesList[1],
        });
      }

      if (habilitiesList.length == 3) {
        _userRef.push().set({
          'deviceid': deviceId,
          'userid': userId,
          'instruction': "Stop",
          'habilityone': habilitiesList[0],
          'habilitytwo': habilitiesList[1],
          'habilitythree': habilitiesList[2],
        });
      }

         values[deviceId] = false;

    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: widget.devicesList.map((String key) {
                return new CheckboxListTile(
                  activeColor: Colors.blue[1000],
                  title: new Row(
                    children: <Widget>[
                      new Icon(Icons.smartphone),
                      new Text("     " + key),
                    ],
                  ),
                  value: values[key],
                  onChanged: (bool value) {
                    setState(() {
                      values[key] = value;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () => onPlay()
                  // setState(() => state = "Start");
                  ,
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[Icon(Icons.play_arrow), Text("Start")],
                  ),
                ),
                FlatButton(
                    onPressed: () => onStop(),
                    color: Colors.white,
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[Icon(Icons.stop), Text("Stop")],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
