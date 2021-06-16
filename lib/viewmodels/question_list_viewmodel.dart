import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/models/question.dart';
import 'package:test_app/services/web_service.dart';
import '../constants.dart';

class QuestionListViewModel {
  List<Question> questions = [];
  List<String> userAnswers = [];
  int currentQuestionIndex;

  void startTest() async {
    clearTest();
    questions = await WebService().getQuestions();
  }

  void saveAnswer(int selectedRadio) {
    if (currentQuestionIndex < userAnswers.length && userAnswers.isNotEmpty) {
      userAnswers.removeAt(currentQuestionIndex);
    }
    if (currentQuestionIndex < questions.length) {
      userAnswers.insert(currentQuestionIndex,
          questions[currentQuestionIndex].answers[selectedRadio]);
    }
  }

  int getSelectedRadio() {
    if (currentQuestionIndex == userAnswers.length) {
      return -1;
    }
    return questions[currentQuestionIndex]
        .answers
        .indexWhere((answer) => answer == userAnswers[currentQuestionIndex]);
  }

  bool isQuestionIndexInRange() {
    return currentQuestionIndex < questions.length - 1;
  }

  void redirectToResultPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/result_page',
        arguments: getResult());
  }

  void nextQuestion() {
    increaseCurrentQuestionIndex();
  }

  void increaseCurrentQuestionIndex() {
    if (isQuestionIndexInRange()) {
      currentQuestionIndex++;
    }
  }

  String getButtonText() {
    if (isQuestionIndexInRange()) {
      return Constants.next;
    }
    return Constants.last;
  }

  void clearTest() {
    currentQuestionIndex = 0;
    userAnswers.clear();
  }

  void runButtonEvents(BuildContext context) {
    if (currentQuestionIndex < userAnswers.length) {
      if (currentQuestionIndex == questions.length - 1) {
        redirectToResultPage(context);
      }
      nextQuestion();
    }
  }

  String getResult() {
    int numberOfCorrectAnswers = 0;
    for (int i = 0; i < userAnswers.length; i++) {
      if (userAnswers[i] == questions[i].correctAnswer) {
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

  void previousQuestion() {
    decreaseCurrentQuestionIndex();
  }

  void decreaseCurrentQuestionIndex() {
    if (currentQuestionIndex != 0) {
      currentQuestionIndex--;
    }
  }
}
