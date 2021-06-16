import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:test_app/models/question.dart';
import 'package:test_app/viewmodels/question_list_viewmodel.dart';

class TestPage extends StatefulWidget {
  final QuestionListViewModel vmQuestionList;

  TestPage({@required this.vmQuestionList});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<int> radioIndexes = Iterable<int>.generate(4).toList();
  HtmlUnescape unescape = HtmlUnescape();
  Question questionModel;

  Future<bool> _onWillPop() async {
    if (widget.vmQuestionList.currentQuestionIndex > 0) {
      setState(
        () {
          widget.vmQuestionList.previousQuestion();
        },
      );
      return true;
    }
    Navigator.pop(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    questionModel = widget
        .vmQuestionList.questions[widget.vmQuestionList.currentQuestionIndex];
    return WillPopScope(
      child: Scaffold(
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
                    unescape.convert(questionModel.question),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Roboto',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: radioIndexes
                    .map(
                      (index) => Row(
                        children: [
                          Radio(
                            value: index,
                            groupValue:
                                widget.vmQuestionList.getSelectedRadio(),
                            onChanged: (val) {
                              setState(
                                () {
                                  widget.vmQuestionList.saveAnswer(val);
                                },
                              );
                            },
                          ),
                          Text(unescape.convert(questionModel.answers[index])),
                        ],
                      ),
                    )
                    .toList(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 40),
                child: ElevatedButton(
                  onPressed: () {
                    setState(
                      () {
                        widget.vmQuestionList.runButtonEvents(context);
                      },
                    );
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
                    widget.vmQuestionList.getButtonText(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        _onWillPop();
      },
    );
  }
}
