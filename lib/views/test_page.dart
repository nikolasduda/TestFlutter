import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/viewmodels/viewmodel_test_structure_list.dart';

class TestPage extends StatefulWidget {
  final ViewModelTestStructureList vmTests;
  TestPage({@required this.vmTests});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>{

  @override
  void initState() {
    super.initState();
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
                    widget.vmTests.getQuestion(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Roboto',
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Row(children: [
              widget.vmTests.visibility ? ButtonBar(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Radio(
                          value: 0,
                          groupValue: widget.vmTests.selectedRadio,
                          onChanged: (val) {
                            setState(() {
                              widget.vmTests.setSelectRadio(val);
                            });
                          },
                        ),
                        Text(widget.vmTests.tests[widget.vmTests.counter].answers[0])
                      ]),
                      Row(children: [
                        Radio(
                          value: 1,
                          groupValue: widget.vmTests.selectedRadio,
                          onChanged: (val) {
                            setState(() {
                              widget.vmTests.setSelectRadio(val);
                            });
                          },
                        ),
                        Text(widget.vmTests.tests[widget.vmTests.counter].answers[1]),
                      ]),
                      Row(children: [
                        Radio(
                          value: 2,
                          groupValue: widget.vmTests.selectedRadio,
                          onChanged: (val) {
                            setState(() {
                              widget.vmTests.setSelectRadio(val);
                            });
                          },
                        ),
                        Text(widget.vmTests.tests[widget.vmTests.counter].answers[2]),
                      ]),
                      Row(children: [
                        Radio(
                          value: 3,
                          groupValue: widget.vmTests.selectedRadio,
                          onChanged: (val) {
                            setState(() {
                              widget.vmTests.setSelectRadio(val);
                            });
                          },
                        ),
                        Text(widget.vmTests.tests[widget.vmTests.counter].answers[3]),
                      ])
                    ],
                  ),
                ],
              ) : Container(),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        widget.vmTests.nextTest(context);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.indigo,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        )),
                    child: Text(widget.vmTests.getButtonText())),
                Padding(padding: EdgeInsets.only(bottom: 150)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}