class AppConstants {
  AppConstants._();

  static const String appName = 'scan-bi';

  /// Open Exchange Rates API key — replace with your own key
  /// Get a free key at https://openexchangerates.org
  /// ⚠️ Never commit a real API key here. Use environment variables or
  /// a secure configuration file excluded from version control (.env).
  static const String exchangeRateApiKey = 'YOUR_API_KEY_HERE';

  static const String exchangeRateBaseUrl =
      'https://openexchangerates.org/api';

  /// Default base currency code
  static const String defaultBaseCurrency = 'THB';

  /// Shared preferences keys
  static const String prefBaseCurrency = 'base_currency';
  static const String prefLastBackup = 'last_backup';

  /// Firestore collection names
  static const String firestoreEntriesCollection = 'entries';
  static const String firestoreGroupsCollection = 'entry_groups';
  static const String firestoreCurrenciesCollection = 'currencies';

  /// Approximate USD → THB rate used for initial rate calculations
  /// (used when fetching fresh rates from Open Exchange Rates API)
  static const double usdToThbFallbackRate = 35.7;

  /// Progress bar limits
  static const double progressBarMaxRedFlex = 3.0;
  static const double progressBarMinRedFlex = 1.0;
}
