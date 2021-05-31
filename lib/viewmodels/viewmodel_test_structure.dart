import 'package:test_app/models/model_test_structure.dart';

class ViewModelTestStructure {
  TestStructure _testStructure;

  ViewModelTestStructure({TestStructure testStructure}): _testStructure = testStructure;

  String get question {
    return _testStructure.question;
  }

  String get correctAnswer {
    return _testStructure.correctAnswer;
  }

  List<dynamic> get incorrectAnswer {
    return _testStructure.incorrectAnswer;
  }

  List<dynamic> get answers {
    return _testStructure.answers;
  }
}