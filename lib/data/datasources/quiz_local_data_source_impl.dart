import 'dart:convert';

import 'package:quiz/domain/entities/question.dart';
import 'package:quiz/domain/entities/quiz_result.dart';
import 'package:quiz/domain/repositories/quiz_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizLocalDataSourceImpl implements QuizRepository {
  static const _historyKey = 'quiz_history';

  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  @override
  Future<List<Question>> getQuestions() async {
    return const [
      Question(
        question: 'What is Flutter?',
        answers: ['A framework', 'A database', 'A programming language', 'An operating system'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'Which language does Flutter use?',
        answers: ['Java', 'Dart', 'Swift', 'Kotlin'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'Who develops Flutter?',
        answers: ['Microsoft', 'Apple', 'Google', 'Meta'],
        correctAnswerIndex: 2,
      ),
    ];
  }

  @override
  Future<void> saveQuizResult(QuizResult result) async {
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
  Future<List<QuizResult>> getQuizHistory() async {
    final savedHistory = await _preferences.getStringList(_historyKey) ?? [];

    return savedHistory.map((item) {
      final json = jsonDecode(item) as Map<String, dynamic>;

      return QuizResult(
        correctAnswers: json['correctAnswers'] as int,
        totalQuestions: json['totalQuestions'] as int,
        date: DateTime.parse(json['date'] as String),
      );
    }).toList();
  }
}
