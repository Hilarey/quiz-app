import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/core/enums/app_status.dart';
import 'package:quiz/ui/features/quiz/quiz_cubit.dart';
import 'package:quiz/ui/features/quiz/quiz_state.dart';
import 'package:quiz/ui/features/result/result_screen.dart';
import 'package:quiz/domain/use_cases/calculate_result.dart';
import 'package:quiz/domain/use_cases/get_questions.dart';
import 'package:quiz/domain/use_cases/get_quiz_history.dart';
import 'package:quiz/domain/use_cases/save_quiz_result.dart';

class QuizScreen extends StatelessWidget {
  final GetQuestions getQuestions;
  final CalculateResult calculateResult;
  final SaveQuizResult saveQuizResult;
  final GetQuizHistory getQuizHistory;

  const QuizScreen({
    super.key,
    required this.getQuestions,
    required this.calculateResult,
    required this.saveQuizResult,
    required this.getQuizHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz'), centerTitle: true),
      body: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state.status == AppStatus.loading || state.status == AppStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == AppStatus.error) {
            return Center(child: Text(state.errorMessage ?? 'Something went wrong'));
          }

          if (state.questions.isEmpty) {
            return const Center(child: Text('No questions available'));
          }

          final question = state.questions[state.currentQuestionIndex];
          final isLastQuestion = state.currentQuestionIndex == state.questions.length - 1;

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LinearProgressIndicator(
                  value: (state.currentQuestionIndex + 1) / state.questions.length,
                ),
                const SizedBox(height: 32),
                Text(
                  'Question ${state.currentQuestionIndex + 1} '
                  'of ${state.questions.length}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: Text(
                    question.question,
                    key: ValueKey(state.currentQuestionIndex),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 32),
                ...List.generate(question.answers.length, (index) {
                  final isSelected = state.selectedAnswerIndex == index;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: OutlinedButton(
                      onPressed: state.selectedAnswerIndex == null
                          ? () {
                              context.read<QuizCubit>().selectAnswer(index);
                            }
                          : null,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: isSelected
                            ? Theme.of(context).colorScheme.primaryContainer
                            : null,
                      ),
                      child: Text(question.answers[index]),
                    ),
                  );
                }),
                const Spacer(),
                ElevatedButton(
                  onPressed: state.selectedAnswerIndex == null
                      ? null
                      : () async {
                          final isFinished = await context.read<QuizCubit>().nextQuestion();

                          if (isFinished && context.mounted) {
                            final resultState = context.read<QuizCubit>().state;

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => ResultScreen(
                                  correctAnswers: resultState.correctAnswers,
                                  totalQuestions: resultState.questions.length,
                                  getQuestions: getQuestions,
                                  calculateResult: calculateResult,
                                  saveQuizResult: saveQuizResult,
                                  getQuizHistory: getQuizHistory,
                                ),
                              ),
                            );
                          }
                        },
                  child: Text(isLastQuestion ? 'Finish Quiz' : 'Next Question'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
