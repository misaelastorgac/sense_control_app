import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_login_demo/pages/singleDevicePage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FindNearDevices extends StatefulWidget {
 

  FindNearDevices({
    Key key,
    this.userId,
    this.distanceToLookAround,
  }) : super(key: key);

  final String userId;
  final String distanceToLookAround;

  @override
  State<StatefulWidget> createState() => new _FindNearDevicesState();
}

class _FindNearDevicesState extends State<FindNearDevices> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String globalstate;
  var userId;
  var selectedUbication, selectedBrand;
  var distanceToLookAround;
  List<String> nearDevicesList = new List();

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    distanceToLookAround = widget.distanceToLookAround;
   //distanceToLookAround = 500;
 print(distanceToLookAround);
 print(userId);
   //print(widget.userId);
  }

  @override
  void dispose() {
    super.dispose();
  }





  sendToDevicePage(String id, String userid) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SingleDevicePage(
                deviceId: id,
                userId: userid,
              ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        Expanded(
            child: SizedBox(
          child: new StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('usuarios/$userId/neardevices').where('distance', isLessThanOrEqualTo : 1000)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator(backgroundColor: Colors.blue[10000],);
                print(snapshot.data.documents.length);
              //  print(widget.distanceToLookAround);
                final int cardLength = snapshot.data.documents.length;
                return new ListView.builder(
                  itemCount: cardLength,
                  itemBuilder: (BuildContext x, int index) {
                    final DocumentSnapshot _card =
                        snapshot.data.documents[index];
                    return new ListTile(
                      title: new Row(
                        children: <Widget>[
                          new Icon(Icons.smartphone),
                          new Text("     " + _card['id']),
                        ],
                      ),
                      onTap: () => sendToDevicePage(_card['id'], userId),
                      subtitle: new Text("            " + _card['semanticubication'] +"   |   " + _card['distance'].round().toString()+" Meters"),
                    );
                  },
                );
              }),
        ))
      ],
    );
  }
}
