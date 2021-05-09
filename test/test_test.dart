// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter_test/flutter_test.dart';

import 'package:test_app/main.dart';

void main() {
  group("TestManager", () {
    test("should return 'i'th question", () {
      TestManager testManager = new TestManager();
      Parser.question.add("hi");
      Parser.question.add("boba");
      Parser.question.add("i");
      Parser.question.add("am");
      Parser.question.add("biba");
      var result = testManager.getQuestion(4);
      expect(result, Parser.question[4]);
    });

    test("should return 'i'th correct answer", () {
      TestManager testManager = new TestManager();
      Parser.correctAnswer.add("hi");
      Parser.correctAnswer.add("boba");
      Parser.correctAnswer.add("i");
      Parser.correctAnswer.add("am");
      Parser.correctAnswer.add("biba");
      var result = testManager.getRightAnswer(2);
      expect(result, Parser.correctAnswer[2]);
    });

    test("should return 'i'th incorrect answers", () {
      TestManager testManager = new TestManager();
      Parser.correctAnswer.clear();
      Parser.correctAnswer.add("hi");
      Parser.correctAnswer.add("biba");
      List<String> temp = ["i", "am", "oldman"];
      List<String> temp2 = ["i", "am", "boba"];
      Parser.incorrectAnswers.add(temp);
      Parser.incorrectAnswers.add(temp2);
      var result = testManager.getAnswers(1);
      Set<String> expected = {"biba", "i", "am", "boba"};
      expect(result, expected);
    });
  });
  group("Parser", ()
  {
    test("should replace all &#039; and &quot;", () {
      Parser parser = new Parser();
      String quot = "&quot;&#039;aboba&#039;&quot;";
      String result = parser.deleteSymbols(quot);
      String expected = "\"'aboba'\"";
      expect(result, expected);
    });

    test("should make lists empty", () {
      Parser parser = new Parser();
      Parser.question.add("value");
      Parser.correctAnswer.add("value");
      var value = ["value", "value", "value"];
      Parser.incorrectAnswers.add(value);
      parser.clear();
      expect(Parser.question.isEmpty, true);
      expect(Parser.correctAnswer.isEmpty, true);
      expect(Parser.incorrectAnswers.isEmpty, true);
    });
  });
}
