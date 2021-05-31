import 'package:flutter/cupertino.dart';
import 'package:test_app/models/model_test_structure.dart';
import 'package:test_app/services/web_service.dart';
import 'package:test_app/viewmodels/viewmodel_test_structure.dart';
import '../Constants.dart';

class ViewModelTestStructureList with ChangeNotifier{
  List<ViewModelTestStructure> tests = [];
  int counter;
  int rightAnswers;
  bool visibility;
  int selectedRadio = -1;

  void getTest() async {
    initVariables();
    List<TestStructure> newTests = await WebService().getTests();
    tests = newTests.map((test) => ViewModelTestStructure(testStructure: test)).toList();
    tests.forEach((test) {
      shuffleAnswers(test);
    });
  }

  String getQuestion() {
    if (visibility) {
      return tests[counter].question;
    }
    return "Your result is $rightAnswers of 10";
  }

  void nextTest(BuildContext context) {
    if (!visibility) {
      Navigator.pop(context);
    }
    if (counter == Constants.questionNumber - 1)
      showResult();
    if (selectedRadio != -1) {
      isRightAnswer();
      increaseCounter();
      selectedRadio = -1;
    }
  }

  void isRightAnswer() {
    if (tests[counter].correctAnswer == tests[counter].answers[selectedRadio])
      rightAnswers++;
  }

  void increaseCounter() {
    if (counter < tests.length - 1)
      counter++;
  }

  void showResult() {
    visibility = false;
  }

  String getButtonText() {
    if (counter < tests.length - 1)
      return Constants.next;
    else if (counter == Constants.questionNumber - 1 && visibility)
      return Constants.last;
    else
      return Constants.ok;
  }

  void shuffleAnswers(ViewModelTestStructure test) {
    test.answers.add(test.correctAnswer);
    for(int i = 0; i < test.incorrectAnswer.length; i++) {
      test.answers.add(test.incorrectAnswer[i]);
    }
    test.answers.shuffle();
  }

  void setSelectRadio(dynamic val) {
    selectedRadio = val;
  }

  void initVariables() {
    counter = 0;
    rightAnswers = 0;
    visibility = true;
  }
}