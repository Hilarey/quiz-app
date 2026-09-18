class QuestionModel {
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;

  const QuestionModel({
    required this.question,
    required this.answers,
    required this.correctAnswerIndex,
  });
}
