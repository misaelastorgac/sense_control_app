import 'package:flutter/material.dart';

class CollectedData extends StatelessWidget {
  final String title;
  CollectedData(this.title);

  @override
  Widget build(BuildContext) {
    return new Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Image.asset('assets/collecteddata.png'),
                RichText(
                  text: TextSpan(
                    text: 'Collected ',
                    children: <TextSpan>[
                      TextSpan(
                          text: '',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' data!'),
                    ],
                  ),
                )
              ]),
        ));
  }
}
