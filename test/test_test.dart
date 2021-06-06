import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/Constants.dart';
import 'package:test_app/models/model_question_structure.dart';
import 'package:test_app/viewmodels/viewmodel_question_structure_list.dart';

void main() {
  String json =
      '{"result":[{"question":"The original mascot of the popular Nintendo game, &quot;Splatoon&quot; was going to be...","correct_answer":"Mario","incorrect_answers":["Inklings","Octolings","Zelda"]}]}';
  Map<String, dynamic> tests = jsonDecode(json);
  Iterable list = tests['result'];
  List<QuestionStructure> questions =
      list.map((test) => QuestionStructure.fromJson(test)).toList();
  group("ModelTestStructure", () {
    test("factory should return right splitting into a structure", () async {
      expect(questions[0].question,
          "The original mascot of the popular Nintendo game, &quot;Splatoon&quot; was going to be...");
      expect(questions[0].correctAnswer, "Mario");
      List<dynamic> answers = [];
      answers.add(questions[0].correctAnswer);
      answers.add("Inklings");
      answers.add("Octolings");
      answers.add("Zelda");
      expect(questions[0].answers.length, answers.length);
    });
  });

  group("vmQuestionStructureList", () {
    ViewModelQuestionStructureList viewModelTestStructureList =
        ViewModelQuestionStructureList();

    test("should save answer", () {
      viewModelTestStructureList.tests.add(QuestionStructure(
          question: "Am i oldman?",
          correctAnswer: "yes",
          answers: ["yes", "no", "maybe", "i am oldman"]));
      viewModelTestStructureList.currentQuestionIndex = 0;
      viewModelTestStructureList.selectedRadio = 0;
      viewModelTestStructureList.saveAnswer();
      expect("yes", viewModelTestStructureList.userAnswers[0]);
    });

    group("increaseCurrentQuestionIndex()", () {
      test("should increase counter", () {
        viewModelTestStructureList.currentQuestionIndex = 0;
        viewModelTestStructureList.increaseCurrentQuestionIndex();
        expect(1, viewModelTestStructureList.currentQuestionIndex);
      });

      test("shouldn't increase counter", () {
        viewModelTestStructureList.currentQuestionIndex = 9;
        viewModelTestStructureList.increaseCurrentQuestionIndex();
        expect(9, viewModelTestStructureList.currentQuestionIndex);
      });
    });

    group("getButtonText()", () {
      for (int i = 0; i < 10; i++) {
        viewModelTestStructureList.tests.add(QuestionStructure());
      }
      test("should return 'next' text: currentQuestionIndex = 0", () {
        viewModelTestStructureList.currentQuestionIndex = 0;
        expect(viewModelTestStructureList.getButtonText(), Constants.next);
      });

      test("should return 'next' text: currentQuestionIndex = 8", () {
        viewModelTestStructureList.currentQuestionIndex = 8;
        expect(viewModelTestStructureList.getButtonText(), Constants.next);
      });

      test("should return 'find out the result' text", () {
        viewModelTestStructureList.currentQuestionIndex = 9;
        expect(viewModelTestStructureList.getButtonText(), Constants.last);
      });
    });
  });
}
