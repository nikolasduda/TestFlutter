import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/Constants.dart';
import 'package:test_app/models/model_test_structure.dart';
import 'package:test_app/services/web_service.dart';
import 'package:test_app/viewmodels/viewmodel_test_structure.dart';
import 'package:test_app/viewmodels/viewmodel_test_structure_list.dart';

void main() {
  String json = '{"response_code":0,"results":[{"category":"Entertainment: Video Games","type":"multiple","difficulty":"medium","question":"The original mascot of the popular Nintendo game, &quot;Splatoon&quot; was going to be...","correct_answer":"Mario","incorrect_answers":["Inklings","Octolings","Zelda"]},{"category":"Entertainment: Video Games","type":"multiple","difficulty":"medium","question":"What happened to Half-Life 2 prior to its release, which resulted in Valve starting over the development of the game?","correct_answer":"The source code got leaked","incorrect_answers":["They weren&#039;t satisfied with the result","The story was not good enough","Way too many bugs to be fixed"]},{"category":"History","type":"multiple","difficulty":"medium","question":"What is the oldest US state?","correct_answer":"Delaware","incorrect_answers":["Rhode Island","Maine","Virginia"]},{"category":"Mythology","type":"multiple","difficulty":"hard","question":"Nidhogg is a mythical creature from what mythology?","correct_answer":"Norse","incorrect_answers":["Egyptian","Greek","Hindu"]},{"category":"Science & Nature","type":"multiple","difficulty":"medium","question":"About how old is Earth?","correct_answer":"4.5 Billion Years","incorrect_answers":["3.5 Billion Years","2.5 Billion Years","5.5 Billion Years"]},{"category":"Science & Nature","type":"multiple","difficulty":"hard","question":"What is &quot;Stenoma&quot;?","correct_answer":"A genus of moths","incorrect_answers":["A combat stimulant from WW2","A type of seasoning","A port city in the carribean"]},{"category":"General Knowledge","type":"multiple","difficulty":"medium","question":"Directly between the Washington Monument and the Reflecting Pool is a memorial to which war?","correct_answer":"World War II","incorrect_answers":["Vietnam War","American Civil War","American Revolutionary War"]},{"category":"History","type":"multiple","difficulty":"medium","question":"After his loss at the Battle of Waterloo, Napoleon Bonaparte was exiled to which island?","correct_answer":"St. Helena","incorrect_answers":["Elba","Corsica","Canary"]},{"category":"Entertainment: Film","type":"multiple","difficulty":"hard","question":"The film Mad Max: Fury Road features the Dies Irae  from which composer&#039;s requiem?","correct_answer":"Verdi","incorrect_answers":["Mozart","Berlioz","Brahms"]},{"category":"Entertainment: Film","type":"multiple","difficulty":"medium","question":"The killer in the 1981 film &#039;My Bloody Valentine&#039; wears what sort of outfit?","correct_answer":"Mining gear","incorrect_answers":["Clown costume","Santa suit","Police uniform"]}]}';
  Map<String, dynamic> tests = jsonDecode(json);
  Iterable list = tests['results'];
  List<TestStructure> newTests = list.map((test) => TestStructure.fromJson(test)).toList();
  group("ModelTestStructure", () {
    test("factory should return right splitting into a structure", () async {
      expect(newTests[0].question, "The original mascot of the popular Nintendo game, &quot;Splatoon&quot; was going to be...");
      expect(newTests[0].correctAnswer, "Mario");
      List<dynamic> answers = [];
      answers.add("Inklings");
      answers.add("Octolings");
      answers.add("Zelda");
      expect(newTests[0].incorrectAnswer, answers);
    });
  });

  group("WebService", () {
    WebService webService = WebService();
    test("should return list of tests with a length of 10", () async {
      List<TestStructure> tests = await webService.getTests();
      int length = 10;
      expect(length, tests.length);
    });
  });

  group("VMTestStructureList", () {
    ViewModelTestStructureList viewModelTestStructureList = ViewModelTestStructureList();
    group("getQuestion()", () {
      test("should return question if answers are visible", () async {
        await viewModelTestStructureList.getTest();
        expect(viewModelTestStructureList.getQuestion(),
            viewModelTestStructureList.tests[0].question);
      });

      test("getQuestion() should return result", () async {
        await viewModelTestStructureList.getTest();
        viewModelTestStructureList.visibility = false;
        expect(
            viewModelTestStructureList.getQuestion(), "Your result is 0 of 10");
      });
    });

    group("increaseCounter()", () {
      test("should increase counter", () async {
        await viewModelTestStructureList.getTest();
        viewModelTestStructureList.increaseCounter();
        expect(1, viewModelTestStructureList.counter);
      });

      test("don't should increase counter", () async {
        await viewModelTestStructureList.getTest();
        viewModelTestStructureList.counter = 9;
        viewModelTestStructureList.increaseCounter();
        expect(9, viewModelTestStructureList.counter);
      });
    });

    group("getButtonText()", () {
      test("should return 'next' text", () async {
        await viewModelTestStructureList.getTest();
        expect(viewModelTestStructureList.getButtonText(), Constants.next);
      });

      test("should return 'find out the result' text", () async {
        await viewModelTestStructureList.getTest();
        viewModelTestStructureList.counter = 9;
        expect(viewModelTestStructureList.getButtonText(), Constants.last);
      });

      test("should return 'ok' text", () async {
        await viewModelTestStructureList.getTest();
        viewModelTestStructureList.counter = 9;
        viewModelTestStructureList.visibility = false;
        expect(viewModelTestStructureList.getButtonText(), Constants.ok);
      });
    });

    group("shuffleAnswers()", () {
      test("should shuffle list", () async {
        viewModelTestStructureList.tests = newTests.map((test) => ViewModelTestStructure(testStructure: test)).toList();
        var test = viewModelTestStructureList.tests[0];
        viewModelTestStructureList.shuffleAnswers(test);
        var test2 = [];
        test2.add(test.correctAnswer);
        for(int i = 0; i < test.incorrectAnswer.length; i++) {
          test2.add(test.incorrectAnswer[i]);
        }
        expect(test.answers, isNot(test2));
      });
    });
  });
}
