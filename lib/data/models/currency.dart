class CurrencyModel {
  final String code;
  final String name;
  final String symbol;
  final double rateToBase;

  const CurrencyModel({
    required this.code,
    required this.name,
    required this.symbol,
    required this.rateToBase,
  });

  CurrencyModel copyWith({
    String? code,
    String? name,
    String? symbol,
    double? rateToBase,
  }) {
    return CurrencyModel(
      code: code ?? this.code,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      rateToBase: rateToBase ?? this.rateToBase,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'symbol': symbol,
      'rateToBase': rateToBase,
    };
  }

  factory CurrencyModel.fromMap(Map<String, dynamic> map) {
    return CurrencyModel(
      code: map['code'] as String,
      name: map['name'] as String,
      symbol: map['symbol'] as String,
      rateToBase: (map['rateToBase'] as num).toDouble(),
    );
  }

  @override
  String toString() => '$name ($code) $symbol';
}
