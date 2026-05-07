class MonthlySummary {
  final double totalIncome;
  final double totalExpense;

  const MonthlySummary({
    required this.totalIncome,
    required this.totalExpense,
  });

  double get balance => totalIncome - totalExpense;

  double get expensePercent =>
      totalIncome == 0 ? 0 : (totalExpense / totalIncome * 100);

  /// Flex value for the red (expense) section of the progress bar.
  /// Clamped between 1.0 and 3.0.
  double get redFlex {
    if (totalIncome == 0) return 3.0;
    if (balance <= 0) return 3.0;
    final ratio = totalExpense / totalIncome;
    return ratio.clamp(1.0, 3.0);
  }

  /// Flex value for the green (remaining) section — always 1.
  double get greenFlex => 1.0;

  const MonthlySummary.empty()
      : totalIncome = 0,
        totalExpense = 0;
}
