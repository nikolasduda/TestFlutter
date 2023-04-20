class TestStructure {
  final String question;
  final String correctAnswer;
  final List<dynamic> incorrectAnswer;
  final List<dynamic> answers = [];

  TestStructure({this.question, this.correctAnswer, this.incorrectAnswer});

  factory TestStructure.fromJson(Map<String, dynamic> json) {
    return TestStructure(
      question: json['question'],
      correctAnswer: json['correct_answer'],
      incorrectAnswer: json['incorrect_answers'],
    );
  }
}