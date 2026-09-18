import 'dart:convert';

import 'package:quiz/data/datasources/quiz_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/question_model.dart';
import '../models/quiz_result_model.dart';

class QuizLocalDataSourceImpl implements QuizLocalDataSource {
  static const _historyKey = 'quiz_history';

  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  @override
  Future<List<QuestionModel>> getQuestions() async {
    return const [
      QuestionModel(
        question: 'What is Flutter?',
        answers: ['A framework', 'A database', 'A programming language', 'An operating system'],
        correctAnswerIndex: 0,
      ),
      QuestionModel(
        question: 'Which language does Flutter use?',
        answers: ['Java', 'Dart', 'Swift', 'Kotlin'],
        correctAnswerIndex: 1,
      ),
      QuestionModel(
        question: 'Who develops Flutter?',
        answers: ['Microsoft', 'Apple', 'Google', 'Meta'],
        correctAnswerIndex: 2,
      ),
    ];
  }

  @override
  Future<void> saveQuizResult(QuizResultModel result) async {
    final history = await getQuizHistory();

    await _preferences.setStringList(_historyKey, [
      jsonEncode({
        'correctAnswers': result.correctAnswers,
        'totalQuestions': result.totalQuestions,
        'date': result.date.toIso8601String(),
      }),
      ...history.map(
        (item) => jsonEncode({
          'correctAnswers': item.correctAnswers,
          'totalQuestions': item.totalQuestions,
          'date': item.date.toIso8601String(),
        }),
      ),
    ]);
  }

  @override
  Future<List<QuizResultModel>> getQuizHistory() async {
    final savedHistory = await _preferences.getStringList(_historyKey) ?? [];

    return savedHistory.map((item) {
      final json = jsonDecode(item) as Map<String, dynamic>;

      return QuizResultModel(
        correctAnswers: json['correctAnswers'] as int,
        totalQuestions: json['totalQuestions'] as int,
        date: DateTime.parse(json['date'] as String),
      );
    }).toList();
  }
}
