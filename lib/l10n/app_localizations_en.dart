// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Scan BI';

  @override
  String get income => 'Income';

  @override
  String get expense => 'Expense';

  @override
  String get title => 'Title';

  @override
  String get titleHint => 'e.g. Lunch at restaurant';

  @override
  String get amount => 'Amount';

  @override
  String get amountHint => '0.00';

  @override
  String get date => 'Date';

  @override
  String get scanReceipt => 'Scan Receipt';

  @override
  String get addEntry => 'Add Entry';

  @override
  String get editEntry => 'Edit Entry';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get deleteEntry => 'Delete Entry';

  @override
  String get deleteEntryConfirm =>
      'Are you sure you want to delete this entry?';

  @override
  String get cancel => 'Cancel';

  @override
  String get titleRequired => 'Title is required';

  @override
  String get amountRequired => 'Amount is required';

  @override
  String get invalidNumber => 'Enter a valid number';

  @override
  String get home => 'Home';

  @override
  String get groups => 'Groups';

  @override
  String get settings => 'Settings';

  @override
  String get balance => 'Balance';

  @override
  String get incomeExpense => 'Income & Expense';

  @override
  String get expenses => 'Expenses';

  @override
  String get progress => 'Progress';

  @override
  String get currencyRate => 'Rate to THB';

  @override
  String get currencyCode => 'Currency';

  @override
  String get addGroup => 'Add Group';

  @override
  String get editGroup => 'Edit Group';

  @override
  String get groupName => 'Group Name';

  @override
  String get groupNameHint => 'e.g. Groceries';

  @override
  String get groupIcon => 'Icon';

  @override
  String get groupColor => 'Color';

  @override
  String get deleteGroup => 'Delete Group';

  @override
  String get deleteGroupConfirm =>
      'Are you sure you want to delete this group?';

  @override
  String get backup => 'Backup';

  @override
  String get currencies => 'Currency Management';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get systemDefault => 'System Default';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get restore => 'Restore';

  @override
  String get lastBackup => 'Last Backup';

  @override
  String get noBackup => 'No backup yet';

  @override
  String get error => 'Error';

  @override
  String get loading => 'Loading...';
}
