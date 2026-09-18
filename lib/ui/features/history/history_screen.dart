import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/core/enums/app_status.dart';
import 'package:quiz/ui/features/history/history_cubit.dart';
import 'package:quiz/ui/features/history/history_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz History'), centerTitle: true),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state.status == AppStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == AppStatus.error) {
            return Center(child: Text(state.errorMessage ?? 'Something went wrong'));
          }

          if (state.results.isEmpty) {
            return const Center(child: Text('No quiz results yet'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: state.results.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final result = state.results[index];

              return _ResultCard(
                date: _formatDate(result.date),
                score: '${result.correctAnswers} / ${result.totalQuestions}',
              );
            },
          );
        },
      ),
    );
  }
}

String _formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');

  return '$day.$month.${date.year}';
}

class _ResultCard extends StatelessWidget {
  final String date;
  final String score;

  const _ResultCard({required this.date, required this.score});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quiz', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(date),
              ],
            ),
            Text(score, style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
