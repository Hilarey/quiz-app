import '../models/question_model.dart';
import '../models/quiz_result_model.dart';

abstract class QuizLocalDataSource {
  Future<List<QuestionModel>> getQuestions();

  Future<void> saveQuizResult(QuizResultModel result);

  Future<List<QuizResultModel>> getQuizHistory();
}
