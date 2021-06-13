import 'package:html_unescape/html_unescape.dart';

class Question {
  String question;
  String correctAnswer;
  List<dynamic> answers;

  Question({this.question, this.correctAnswer, this.answers});

  factory Question.fromJson(Map<String, dynamic> json, HtmlUnescape unescape) {
    Question question = Question(
      question: json['question'],
      correctAnswer: json['correct_answer'],
      answers: json['incorrect_answers'],
    );
    question._shuffleAnswers();
    question._deleteUnreadableSymbols(unescape);
    return question;
  }

  void _shuffleAnswers() {
    answers.add(correctAnswer);
    answers.shuffle();
  }

  void _deleteUnreadableSymbols(HtmlUnescape unescape) {
    question = unescape.convert(question);
    correctAnswer = unescape.convert(correctAnswer);
    for (int i = 0; i < answers.length; i++) {
      answers[i] = unescape.convert(answers[i]);
    }
  }
}
