import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/core/enums/app_status.dart';
import 'package:quiz/domain/entities/quiz_result.dart';
import 'package:quiz/domain/use_cases/calculate_result.dart';
import 'package:quiz/domain/use_cases/get_questions.dart';
import 'package:quiz/domain/use_cases/save_quiz_result.dart';
import 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final GetQuestions getQuestions;
  final CalculateResult calculateResult;
  final SaveQuizResult saveQuizResult;

  QuizCubit({
    required this.getQuestions,
    required this.calculateResult,
    required this.saveQuizResult,
  }) : super(const QuizState());

  Future<void> loadQuiz() async {
    emit(state.copyWith(status: AppStatus.loading, errorMessage: null));

    try {
      final questions = await getQuestions();

      emit(state.copyWith(status: AppStatus.success, questions: questions));
    } catch (e) {
      emit(state.copyWith(status: AppStatus.error, errorMessage: e.toString()));
    }
  }

  void selectAnswer(int answerIndex) {
    final question = state.questions[state.currentQuestionIndex];

    final earnedPoint = calculateResult(
      correctAnswerIndex: question.correctAnswerIndex,
      selectedAnswerIndex: answerIndex,
    );

    emit(
      state.copyWith(
        selectedAnswerIndex: answerIndex,
        correctAnswers: state.correctAnswers + earnedPoint,
      ),
    );
  }

  Future<void> finishQuiz() async {
    final result = QuizResult(
      correctAnswers: state.correctAnswers,
      totalQuestions: state.questions.length,
      date: DateTime.now(),
    );

    await saveQuizResult(result);
    emit(state.copyWith(status: AppStatus.success));
  }

  Future<bool> nextQuestion() async {
    final nextIndex = state.currentQuestionIndex + 1;

    if (nextIndex < state.questions.length) {
      emit(
        QuizState(
          status: state.status,
          questions: state.questions,
          currentQuestionIndex: nextIndex,
          correctAnswers: state.correctAnswers,
        ),
      );

      return false;
    }

    await finishQuiz();
    return true;
  }
}
