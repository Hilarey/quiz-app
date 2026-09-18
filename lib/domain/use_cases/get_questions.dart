import '../entities/question.dart';
import '../repositories/quiz_repository.dart';

class GetQuestions {
  final QuizRepository repository;

  GetQuestions(this.repository);

  Future<List<Question>> call() {
    return repository.getQuestions();
  }
}
