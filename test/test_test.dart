import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:test_app/constants.dart';
import 'package:test_app/models/question.dart';
import 'package:test_app/viewmodels/question_list_viewmodel.dart';

void main() {
  String json =
       '{"question":"The original mascot of the popular Nintendo game, &quot;Splatoon&quot; was going to be...","correct_answer":"Mario","incorrect_answers":["Inklings","Octolings","Zelda"]}';
  Map<String, dynamic> jsonQuestions = jsonDecode(json);

  group("ModelQuestion", () {
    List<Question> questions = [];
    var unescape = HtmlUnescape();
    questions.add(Question.fromJson(jsonQuestions));
    test("factory should return right splitting into a structure", () async {
      expect(unescape.convert(questions[0].question),
          "The original mascot of the popular Nintendo game, \"Splatoon\" was going to be...");
      expect(questions[0].correctAnswer, "Mario");
      List<dynamic> answers = [];
      answers.add(questions[0].correctAnswer);
      answers.add("Inklings");
      answers.add("Octolings");
      answers.add("Zelda");
      expect(questions[0].answers.length, answers.length);
    });
  });

  group("vmQuestionList", () {
    QuestionListViewModel questionListViewModel =
        QuestionListViewModel();

    test("should save answer", () {
      questionListViewModel.questions.clear();
      questionListViewModel.questions.add(Question(
          question: "Am i oldman?",
          correctAnswer: "yes",
          answers: ["yes", "no", "maybe", "i am oldman"]));
      questionListViewModel.currentQuestionIndex = 0;
      questionListViewModel.saveAnswer(0);
      expect("yes", questionListViewModel.userAnswers[0]);
    });

    group("increaseCurrentQuestionIndex()", () {
      test("should increase counter", () {
        questionListViewModel.currentQuestionIndex = 0;
        questionListViewModel.increaseCurrentQuestionIndex();
        expect(1, questionListViewModel.currentQuestionIndex);
      });

      test("shouldn't increase counter", () {
        questionListViewModel.currentQuestionIndex = 9;
        questionListViewModel.increaseCurrentQuestionIndex();
        expect(9, questionListViewModel.currentQuestionIndex);
      });
    });

    group("getButtonText()", () {
      for (int i = 0; i < 10; i++) {
        questionListViewModel.questions.add(Question());
      }
      test("should return 'next' text: currentQuestionIndex = 0", () {
        questionListViewModel.currentQuestionIndex = 0;
        expect(questionListViewModel.getButtonText(), Constants.next);
      });

      test("should return 'next' text: currentQuestionIndex = 8", () {
        questionListViewModel.currentQuestionIndex = 8;
        expect(questionListViewModel.getButtonText(), Constants.next);
      });

      test("should return 'find out the result' text", () {
        questionListViewModel.currentQuestionIndex = 9;
        expect(questionListViewModel.getButtonText(), Constants.last);
      });
    });
  });
}
