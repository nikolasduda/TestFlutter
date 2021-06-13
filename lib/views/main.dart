import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/viewmodels/viewmodel_question_list.dart';
import 'package:test_app/views/test_page.dart';
import '../constants.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  QuestionListViewModel questionListViewModel = QuestionListViewModel();

  void redirectToQuestions() async {
    await questionListViewModel.startTest();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return TestPage(vmQuestionList: questionListViewModel);
        },
      ),
    );
  }

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
                  Constants.mainNote,
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
                  redirectToQuestions();
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
                  Constants.buttonText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
