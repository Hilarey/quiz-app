import '../entities/question.dart';
import '../entities/quiz_result.dart';

abstract class QuizRepository {
  Future<List<Question>> getQuestions();

  Future<void> saveQuizResult(QuizResult result);

  Future<List<QuizResult>> getQuizHistory();
}
