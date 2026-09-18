import 'package:flutter/material.dart';
import 'package:quiz/domain/use_cases/calculate_result.dart';
import 'package:quiz/domain/use_cases/get_questions.dart';
import 'package:quiz/domain/use_cases/get_quiz_history.dart';
import 'package:quiz/domain/use_cases/save_quiz_result.dart';
import 'package:quiz/ui/features/home/home_screen.dart';

class QuizApp extends StatelessWidget {
  final GetQuestions getQuestions;
  final CalculateResult calculateResult;
  final SaveQuizResult saveQuizResult;
  final GetQuizHistory getQuizHistory;

  const QuizApp({
    super.key,
    required this.getQuestions,
    required this.calculateResult,
    required this.saveQuizResult,
    required this.getQuizHistory,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: HomeScreen(
        getQuestions: getQuestions,
        calculateResult: calculateResult,
        saveQuizResult: saveQuizResult,
        getQuizHistory: getQuizHistory,
      ),
    );
  }
}
