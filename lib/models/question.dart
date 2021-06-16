class Question {
  String question;
  String correctAnswer;
  List<dynamic> answers;

  Question({this.question, this.correctAnswer, this.answers});

  factory Question.fromJson(Map<String, dynamic> json) {
    Question question = Question(
      question: json['question'],
      correctAnswer: json['correct_answer'],
      answers: json['incorrect_answers'],
    );
    question._shuffleAnswers();
    return question;
  }

  void _shuffleAnswers() {
    answers.add(correctAnswer);
    answers.shuffle();
  }
}
