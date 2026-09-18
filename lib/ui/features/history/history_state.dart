import 'package:quiz/core/enums/app_status.dart';
import 'package:quiz/domain/entities/quiz_result.dart';

class HistoryState {
  final AppStatus status;
  final List<QuizResult> results;
  final String? errorMessage;

  const HistoryState({this.status = AppStatus.initial, this.results = const [], this.errorMessage});

  HistoryState copyWith({AppStatus? status, List<QuizResult>? results, String? errorMessage}) {
    return HistoryState(
      status: status ?? this.status,
      results: results ?? this.results,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
