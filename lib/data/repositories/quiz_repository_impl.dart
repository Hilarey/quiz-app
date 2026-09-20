import '../../domain/entities/question.dart';
import '../../domain/entities/quiz_result.dart';
import '../../domain/repositories/quiz_repository.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizRepository localDataSource;

  QuizRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Question>> getQuestions() async {
    final models = await localDataSource.getQuestions();

    return models
        .map(
          (model) => Question(
            question: model.question,
            answers: model.answers,
            correctAnswerIndex: model.correctAnswerIndex,
          ),
        )
        .toList();
  }

  @override
  Future<void> saveQuizResult(QuizResult result) {
    final model = QuizResult(
      correctAnswers: result.correctAnswers,
      totalQuestions: result.totalQuestions,
      date: result.date,
    );

    return localDataSource.saveQuizResult(model);
  }

  @override
  Future<List<QuizResult>> getQuizHistory() async {
    final models = await localDataSource.getQuizHistory();

    return models
        .map(
          (model) => QuizResult(
            correctAnswers: model.correctAnswers,
            totalQuestions: model.totalQuestions,
            date: model.date,
          ),
        )
        .toList();
  }
}
