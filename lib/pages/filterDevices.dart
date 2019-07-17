import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_login_demo/pages/filteredDevices.dart';

class FilterDevices extends StatefulWidget {
  FilterDevices({
    Key key,
    this.userId,
    this.devicesList,
  }) : super(key: key);

  final String userId;
  List<String> devicesList = new List();

  @override
  State<StatefulWidget> createState() => new _FilterDevicesState();
}

class _FilterDevicesState extends State<FilterDevices> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String globalstate;
  var userId;
  var selectedSemanticUbication,
      selectedBrand,
      selectedHabilityOne,
      selectedHabilityTwo,
      selectedHabilityThree,
      selectedDistance;

  QuerySnapshot querySnapshot;


  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    
  }

  @override
  void dispose() {
    super.dispose();
  }

  _deviceFilter(String ubication, String brand, String habilityOne,
      String habilityTwo, String habilityThree, int distance) async {
    List<String> devicesList = new List();
    List<String> namesList = new List();

    List<String> habilitiesList = new List();


    if (distance == null) {
      distance = 1000;
    }

    //print(habilityOne + " " + habilityTwo + " "+ habilityThree + " "+ distance.toString());
    final Map<String, bool> values = {};

    String id = widget.userId;

    CollectionReference col =
        Firestore.instance.collection("usuarios/$id/neardevices");

    Query ubicationQuery = col.where('semanticubication', isEqualTo: ubication);
    Query modelUbicationQuery = ubicationQuery.where('brand', isEqualTo: brand);
    Query habilityOneQuery =
        modelUbicationQuery.where('habilityone', isEqualTo: habilityOne);
    Query habilityTwoQuery =
        habilityOneQuery.where('habilitytwo', isEqualTo: habilityTwo);
    Query habilityThreeQuery =
        habilityTwoQuery.where('habilitythree', isEqualTo: habilityThree);

    if (habilityOne != null) {
      habilitiesList.add(habilityOne);
    }
    if (habilityTwo != null) {
      habilitiesList.add(habilityTwo);
    }
    if (habilityThree != null) {
      habilitiesList.add(habilityThree);
    }

    for (var i = 0; i < habilitiesList.length; i++) {
      //  print(habilitiesList.elementAt(i));
      //  print(habilitiesList.length);
    }

    await habilityThreeQuery.getDocuments().then((data) {
     // print(data.documents.length);
      data.documents.forEach((device) {
        // print(device['distance']);

        if (device['distance']<= distance) {
          devicesList.add(device['id']);
          namesList.add(device['Name']);
          values[device[id]] = false;
        }
      });
    });

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FilteredDevices(
                userId: userId,
                title: "Filtered Devices",
                devicesList: devicesList,
                habilityList: habilitiesList,
                namesList: namesList,
              ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    String id = userId;
    return new Container(
      color: Colors.lightBlue[100],
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        autovalidate: true,
        child: new ListView(
          children: <Widget>[
            new StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("semanticubications")
                    .snapshots(),
                initialData: querySnapshot,
                builder: (context, snapshot) {
                if (!snapshot.hasData) return new Container(width: 0.0, height: 0.0);
                  else {
                    List<DropdownMenuItem> currencyItems = [];
                    for (int i = 0; i < snapshot.data.documents.length; i++) {
                      DocumentSnapshot snap = snapshot.data.documents[i];
                      currencyItems.add(
                        DropdownMenuItem(
                          child: Text(
                            snap['semanticubication'],
                          ),
                          value: snap['semanticubication'],
                        ),
                      );
                    }
                    var selectedSemanticUbication2 = selectedSemanticUbication;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.place,
                          size: 25.0,
                          color: Colors.lightBlue[900],
                        ),
                        SizedBox(width: 30.0),
                        DropdownButton(
                          items: currencyItems,
                          onChanged: (selectUbication) {
                            setState(() {
                              selectedSemanticUbication = selectUbication;
                            });
                            final snackBar = SnackBar(
                              content: Text(
                                'Selected ubication is $selectUbication',
                                style: TextStyle(color: Colors.lightBlue[300]),
                              ),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                          },
                          value: selectedSemanticUbication2,
                          isExpanded: false,
                          hint: new Text(
                            "Choose Semantic Ubication",
                          ),
                        ),
                      ],
                    );
                  }
                }),
           new StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("brands").snapshots(),
                initialData: querySnapshot,
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                     return new Container(width: 0.0, height: 0.0);
                  else {
                    List<DropdownMenuItem> currencyItems = [];
                    for (int i = 0; i < snapshot.data.documents.length; i++) {
                      DocumentSnapshot snap = snapshot.data.documents[i];
                      currencyItems.add(
                        DropdownMenuItem(
                          child: Text(
                            snap['brand'],
                          ),
                          value: snap['brand'],
                        ),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.smartphone,
                          size: 25.0,
                          color: Colors.lightBlue[900],
                        ),
                        SizedBox(width: 30.0),
                        DropdownButton(
                          items: currencyItems,
                          onChanged: (selectBrand) {
                            setState(() {
                              selectedBrand = selectBrand;
                            });

                            final snackBar = SnackBar(
                              content: Text(
                                'Selected Brand is $selectBrand',
                                style: TextStyle(color: Colors.lightBlue[300]),
                              ),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                          },
                          value: selectedBrand,
                          isExpanded: false,
                          hint: new Text(
                            "Choose Brand",
                          ),
                        ),
                      ],
                    );
                  }
                }),
            new StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("habilities").snapshots(),
                initialData: querySnapshot,
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return new Container(width: 0.0, height: 0.0);
                  else {
                    List<DropdownMenuItem> currencyItems = [];
                    for (int i = 0; i < snapshot.data.documents.length; i++) {
                      DocumentSnapshot snap = snapshot.data.documents[i];
                      currencyItems.add(
                        DropdownMenuItem(
                          child: Text(
                            snap['hability'],
                          ),
                          value: snap['hability'],
                        ),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.panorama_horizontal,
                          size: 25.0,
                          color: Colors.lightBlue[900],
                        ),
                        SizedBox(width: 30.0),
                        DropdownButton(
                          items: currencyItems,
                          onChanged: (selectHabilityOne) {
                            setState(() {
                              selectedHabilityOne = selectHabilityOne;
                            });

                            final snackBar = SnackBar(
                              content: Text(
                                'Selected Ability is $selectHabilityOne',
                                style: TextStyle(color: Colors.lightBlue[300]),
                              ),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                          },
                          value: selectedHabilityOne,
                          isExpanded: false,
                          hint: new Text(
                            "Choose Ability",
                          ),
                        ),
                      ],
                    );
                  }
                }),
            new StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("habilities").snapshots(),
                initialData: querySnapshot,
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return new Container(width: 0.0, height: 0.0);
                  else {
                    List<DropdownMenuItem> currencyItems = [];
                    for (int i = 0; i < snapshot.data.documents.length; i++) {
                      DocumentSnapshot snap = snapshot.data.documents[i];
                      currencyItems.add(
                        DropdownMenuItem(
                          child: Text(
                            snap['hability'],
                          ),
                          value: snap['hability'],
                        ),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.panorama_fish_eye,
                          size: 25.0,
                          color: Colors.lightBlue[900],
                        ),
                        SizedBox(width: 30.0),
                        DropdownButton(
                          items: currencyItems,
                          onChanged: (selectHabilityTwo) {
                            setState(() {
                              selectedHabilityTwo = selectHabilityTwo;
                            });

                            final snackBar = SnackBar(
                              content: Text(
                                'Selected Ability is $selectHabilityTwo',
                                style: TextStyle(color: Colors.lightBlue[300]),
                              ),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                          },
                          value: selectedHabilityTwo,
                          isExpanded: false,
                          hint: new Text(
                            "Choose Ability",
                          ),
                        ),
                      ],
                    );
                  }
                }),
           new StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("habilities").snapshots(),
                initialData: querySnapshot,
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return new Container(width: 0.0, height: 0.0);
                  else {
                    List<DropdownMenuItem> currencyItems = [];
                    for (int i = 0; i < snapshot.data.documents.length; i++) {
                      DocumentSnapshot snap = snapshot.data.documents[i];
                      currencyItems.add(
                        DropdownMenuItem(
                          child: Text(
                            snap['hability'],
                          ),
                          value: snap['hability'],
                        ),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.panorama_wide_angle,
                          size: 25.0,
                          color: Colors.lightBlue[900],
                        ),
                        SizedBox(width: 30.0),
                        DropdownButton(
                          items: currencyItems,
                          onChanged: (selectHabilityThree) {
                            setState(() {
                              selectedHabilityThree = selectHabilityThree;
                            });

                            final snackBar = SnackBar(
                              content: Text(
                                'Selected Ability is $selectHabilityThree',
                                style: TextStyle(color: Colors.lightBlue[300]),
                              ),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                          },
                          value: selectedHabilityThree,
                          isExpanded: false,
                          hint: new Text(
                            "Choose Ability",
                          ),
                        ),
                      ],
                    );
                  }
                }),
            new StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("distances").snapshots(),
                initialData: querySnapshot,
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                   return new Container(width: 0.0, height: 0.0);
                  else {
                    List<DropdownMenuItem> currencyItems = [];
                    for (int i = 0; i < snapshot.data.documents.length; i++) {
                      DocumentSnapshot snap = snapshot.data.documents[i];
                      currencyItems.add(
                        DropdownMenuItem(
                          child: Text(
                            snap['distance'] + ' Meters',
                          ),
                          value: snap['distance'],
                        ),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.trending_down,
                          size: 25.0,
                          color: Colors.lightBlue[900],
                        ),
                        SizedBox(width: 30.0),
                        DropdownButton(
                          items: currencyItems,
                          onChanged: (selectDistance) {
                            setState(() {
                              selectedDistance = selectDistance;
                            });

                            final snackBar = SnackBar(
                              content: Text(
                                'Selected Distance is $selectDistance meters',
                                style: TextStyle(color: Colors.lightBlue[300]),
                              ),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                          },
                          value: selectedDistance,
                          isExpanded: false,
                          hint: new Text(
                            "Distance",
                          ),
                        ),
                      ],
                    );
                  }
                }),
            Padding(
                padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                child: new MaterialButton(
                    elevation: 5.0,
                    minWidth: 200.0,
                    height: 45.0,
                    color: Colors.blue,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: new Text('Search Devices',
                        style:
                            new TextStyle(fontSize: 18.0, color: Colors.white)),
                    onPressed: () => _deviceFilter(
                        selectedSemanticUbication,
                        selectedBrand,
                        selectedHabilityOne,
                        selectedHabilityTwo,
                        selectedHabilityThree,
                        int.parse(selectedDistance))))
          ],
        ),
      ),
    );
  }
}
