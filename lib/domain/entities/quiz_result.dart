class QuizResult {
  final int correctAnswers;
  final int totalQuestions;
  final DateTime date;

  const QuizResult({
    required this.correctAnswers,
    required this.totalQuestions,
    required this.date,
  });
}
