class MonthlySummary {
  final double totalIncome;
  final double totalExpense;

  const MonthlySummary({required this.totalIncome, required this.totalExpense});

  double get balance => totalIncome - totalExpense;

  double get expensePercent =>
      totalIncome == 0 ? 0 : (totalExpense / totalIncome * 100);

  /// Flex value for the green (income) section of the progress bar.
  /// Represents the proportion of income to total (income + expense).
  double get greenFlex {
    final total = totalIncome + totalExpense;
    if (total == 0) return 1.0;
    return totalIncome / total;
  }

  /// Flex value for the red (expense) section of the progress bar.
  /// Represents the proportion of expense to total (income + expense).
  double get redFlex {
    final total = totalIncome + totalExpense;
    if (total == 0) return 1.0;
    return totalExpense / total;
  }

  const MonthlySummary.empty()
      : totalIncome = 0,
        totalExpense = 0;
}
