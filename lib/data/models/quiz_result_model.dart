class QuizResultModel {
  final int correctAnswers;
  final int totalQuestions;
  final DateTime date;

  const QuizResultModel({
    required this.correctAnswers,
    required this.totalQuestions,
    required this.date,
  });
}
