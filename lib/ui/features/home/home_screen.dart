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

class HomeScreen extends StatelessWidget {
  final GetQuestions getQuestions;
  final CalculateResult calculateResult;
  final SaveQuizResult saveQuizResult;
  final GetQuizHistory getQuizHistory;

  const HomeScreen({
    super.key,
    required this.getQuestions,
    required this.calculateResult,
    required this.saveQuizResult,
    required this.getQuizHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz App')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.quiz_outlined, size: 80),
              const SizedBox(height: 24),
              Text(
                'Test your knowledge!',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Answer the questions and check your result.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
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
                  child: const Text('Start Quiz'),
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
