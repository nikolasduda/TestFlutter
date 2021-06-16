import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TestApp"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FractionallySizedBox(
              child: Container(
                margin: EdgeInsets.only(top: 30),
                child: Text(
                  ModalRoute.of(context).settings.arguments,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    fontFamily: 'Roboto',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
                child: Text(
                  Constants.ok,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
