import 'package:flutter/material.dart';
import 'package:quiz/data/datasources/quiz_local_data_source_impl.dart';
import 'package:quiz/data/repositories/quiz_repository_impl.dart';
import 'package:quiz/domain/use_cases/calculate_result.dart';
import 'package:quiz/domain/use_cases/get_questions.dart';
import 'package:quiz/domain/use_cases/get_quiz_history.dart';
import 'package:quiz/domain/use_cases/save_quiz_result.dart';
import 'package:quiz/ui/quiz_app.dart';

void main() {
  final localDataSource = QuizLocalDataSourceImpl();

  final repository = QuizRepositoryImpl(localDataSource: localDataSource);

  runApp(
    QuizApp(
      getQuestions: GetQuestions(repository),
      calculateResult: CalculateResult(),
      saveQuizResult: SaveQuizResult(repository),
      getQuizHistory: GetQuizHistory(repository),
    ),
  );
}
