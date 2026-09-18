import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/core/enums/app_status.dart';
import 'package:quiz/domain/use_cases/get_quiz_history.dart';

import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetQuizHistory getQuizHistory;

  HistoryCubit({required this.getQuizHistory}) : super(const HistoryState());

  Future<void> loadHistory() async {
    emit(HistoryState(status: AppStatus.loading, results: state.results));

    try {
      final results = await getQuizHistory();

      emit(HistoryState(status: AppStatus.success, results: results));
    } catch (e) {
      emit(
        HistoryState(status: AppStatus.error, results: state.results, errorMessage: e.toString()),
      );
    }
  }
}
