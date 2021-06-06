class QuestionStructure {
  final String question;
  final String correctAnswer;
  final List<dynamic> answers;

  QuestionStructure({this.question, this.correctAnswer, this.answers});

  factory QuestionStructure.fromJson(Map<String, dynamic> json) {
    QuestionStructure questionStructure = QuestionStructure(
      question: json['question'],
      correctAnswer: json['correct_answer'],
      answers: json['incorrect_answers'],
    );
    questionStructure.shuffleAnswers();
    return questionStructure;
  }

  void shuffleAnswers() {
    answers.add(correctAnswer);
    answers.shuffle();
  }
}
