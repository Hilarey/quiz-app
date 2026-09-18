import '../entities/quiz_result.dart';
import '../repositories/quiz_repository.dart';

class GetQuizHistory {
  final QuizRepository repository;

  GetQuizHistory(this.repository);

  Future<List<QuizResult>> call() {
    return repository.getQuizHistory();
  }
}
