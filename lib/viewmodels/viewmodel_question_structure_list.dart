import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/models/model_question_structure.dart';
import 'package:test_app/services/web_service.dart';
import '../Constants.dart';

class ViewModelQuestionStructureList {
  List<QuestionStructure> tests = [];
  List<String> userAnswers = [];
  int currentQuestionIndex;
  int selectedRadio;

  void setQuestions() async {
    restartTest();
    tests = await WebService().getQuestions();
  }

  void saveAnswer() {
    userAnswers.add(tests[currentQuestionIndex].answers[selectedRadio]);
  }

  void redirectToResultPage(BuildContext context) {
    if (currentQuestionIndex == Constants.questionNumber - 1) {
      Navigator.pushReplacementNamed(context, '/result_page', arguments: getResult());
    }
  }

  void nextQuestion() {
    if (selectedRadio != -1) {
      increaseCurrentQuestionIndex();
      selectedRadio = -1;
    }
  }

  void increaseCurrentQuestionIndex() {
    if (currentQuestionIndex < tests.length - 1) {
      currentQuestionIndex++;
    }
  }

  String getButtonText() {
    if (currentQuestionIndex < tests.length - 1) {
      return Constants.next;
    }
    return Constants.last;
  }

  void setSelectRadio(int val) {
    selectedRadio = val;
  }

  void restartTest() {
    currentQuestionIndex = 0;
    selectedRadio = -1;
    userAnswers.clear();
  }

  void runButtonEvents(BuildContext context) {
    if (selectedRadio != -1) {
      saveAnswer();
      redirectToResultPage(context);
      nextQuestion();
    }
  }

  String getResult() {
    int numberOfCorrectAnswers = 0;
    for(int i = 0; i < userAnswers.length; i++) {
      if (userAnswers[i] == tests[i].correctAnswer){
        numberOfCorrectAnswers++;
      }
    }

    String result = "Your result is $numberOfCorrectAnswers of 10 \n";

    if (numberOfCorrectAnswers > 6) {
      result += "Test passed.";
    } else {
      result += "Test failed.";
    }

    return result;
  }

  void setPreviousPage() {
    currentQuestionIndex--;
    userAnswers.removeAt(userAnswers.length - 1);
    selectedRadio = -1;
  }
}
