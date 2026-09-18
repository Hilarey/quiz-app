import 'package:quiz/core/enums/app_status.dart';
import 'package:quiz/domain/entities/question.dart';

class QuizState {
  final AppStatus status;
  final List<Question> questions;
  final int currentQuestionIndex;
  final int? selectedAnswerIndex;
  final int correctAnswers;
  final String? errorMessage;

  const QuizState({
    this.status = AppStatus.initial,
    this.questions = const [],
    this.currentQuestionIndex = 0,
    this.selectedAnswerIndex,
    this.correctAnswers = 0,
    this.errorMessage,
  });

  QuizState copyWith({
    AppStatus? status,
    List<Question>? questions,
    int? currentQuestionIndex,
    int? selectedAnswerIndex,
    int? correctAnswers,
    String? errorMessage,
  }) {
    return QuizState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedAnswerIndex: selectedAnswerIndex ?? this.selectedAnswerIndex,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
