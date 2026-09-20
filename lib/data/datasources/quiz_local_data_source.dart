import 'package:quiz/domain/entities/question.dart';
import 'package:quiz/domain/entities/quiz_result.dart';

abstract class QuizLocalDataSource {
  Future<List<Question>> getQuestions();

  Future<void> saveQuizResult(QuizResult result);

  Future<List<QuizResult>> getQuizHistory();
}
