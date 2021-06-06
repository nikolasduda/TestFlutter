import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/viewmodels/viewmodel_question_structure_list.dart';

class TestPage extends StatefulWidget {
  final ViewModelQuestionStructureList vmQuestionList;

  TestPage({@required this.vmQuestionList});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<int> radioIndexes = Iterable<int>.generate(4).toList();

  Future<bool> _onWillPop() async {
    if (widget.vmQuestionList.currentQuestionIndex > 0) {
      setState(() {
        widget.vmQuestionList.setPreviousPage();
      });
      return true;
    }
    Navigator.pop(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
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
                        widget
                            .vmQuestionList
                            .tests[widget.vmQuestionList.currentQuestionIndex]
                            .question,
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
                  ButtonBar(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: radioIndexes
                            .map(
                              (index) => Row(children: [
                                Radio(
                                  value: index,
                                  groupValue:
                                      widget.vmQuestionList.selectedRadio,
                                  onChanged: (val) {
                                    setState(() {
                                      widget.vmQuestionList.setSelectRadio(val);
                                    });
                                  },
                                ),
                                Text(widget
                                    .vmQuestionList
                                    .tests[widget
                                        .vmQuestionList.currentQuestionIndex]
                                    .answers[index]),
                              ]),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.vmQuestionList.runButtonEvents(context);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigo,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            textStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                            )),
                        child: Text(widget.vmQuestionList.getButtonText())),
                    Padding(padding: EdgeInsets.only(bottom: 150)),
                  ],
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          _onWillPop();
        });
  }
}
