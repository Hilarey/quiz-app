class CalculateResult {
  int call({required int correctAnswerIndex, required int selectedAnswerIndex}) {
    return correctAnswerIndex == selectedAnswerIndex ? 1 : 0;
  }
}
