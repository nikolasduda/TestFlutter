import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/viewmodels/viewmodel_test_structure_list.dart';
import 'package:test_app/views/test_page.dart';
import '../Constants.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ViewModelTestStructureList viewModelTestStructureList = ViewModelTestStructureList();

  @override
  void initState() {
    super.initState();
  }

  void showTests(context) async{
    await viewModelTestStructureList.getTest();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) {
              return TestPage(vmTests: viewModelTestStructureList);
            },
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TestApp")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 200),
                ),
                Flexible(
                  child: Text(
                    Constants.mainNote,
                    style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 40,
                      fontFamily: 'Roboto',),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      showTests(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.indigo,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        )
                    ),
                    child: Text(
                      Constants.buttonText,
                    )
                ),
                Padding(padding: EdgeInsets.only(bottom: 150)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}