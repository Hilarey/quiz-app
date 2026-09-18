import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/domain/use_cases/calculate_result.dart';
import 'package:quiz/domain/use_cases/get_questions.dart';
import 'package:quiz/domain/use_cases/get_quiz_history.dart';
import 'package:quiz/domain/use_cases/save_quiz_result.dart';
import 'package:quiz/ui/features/history/history_cubit.dart';
import 'package:quiz/ui/features/history/history_screen.dart';
import 'package:quiz/ui/features/quiz/quiz_cubit.dart';
import 'package:quiz/ui/features/quiz/quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final GetQuestions getQuestions;
  final CalculateResult calculateResult;
  final SaveQuizResult saveQuizResult;
  final GetQuizHistory getQuizHistory;

  const ResultScreen({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.getQuestions,
    required this.calculateResult,
    required this.saveQuizResult,
    required this.getQuizHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emoji_events_outlined, size: 80),
              const SizedBox(height: 24),
              Text(
                'Quiz Completed!',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text('Your result', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(
                '$correctAnswers / $totalQuestions',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => QuizCubit(
                            getQuestions: getQuestions,
                            calculateResult: calculateResult,
                            saveQuizResult: saveQuizResult,
                          )..loadQuiz(),
                          child: QuizScreen(
                            getQuestions: getQuestions,
                            calculateResult: calculateResult,
                            saveQuizResult: saveQuizResult,
                            getQuizHistory: getQuizHistory,
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text('Try Again'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) =>
                              HistoryCubit(getQuizHistory: getQuizHistory)..loadHistory(),
                          child: const HistoryScreen(),
                        ),
                      ),
                    );
                  },
                  child: const Text('Quiz History'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
