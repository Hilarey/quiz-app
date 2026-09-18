import '../entities/quiz_result.dart';
import '../repositories/quiz_repository.dart';

class SaveQuizResult {
  final QuizRepository repository;

  SaveQuizResult(this.repository);

  Future<void> call(QuizResult result) {
    return repository.saveQuizResult(result);
  }
}
