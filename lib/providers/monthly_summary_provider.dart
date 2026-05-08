import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/monthly_summary.dart';
import '../data/models/year_month.dart';
import '../data/repositories/entry_repository.dart';
import 'database_provider.dart';

final monthlySummaryProvider = StreamProvider.family<MonthlySummary, YearMonth>(
  (ref, yearMonth) {
    final db = ref.watch(databaseProvider);
    final repo = EntryRepository(db);
    return repo.watchMonthlySummary(yearMonth);
  },
);
