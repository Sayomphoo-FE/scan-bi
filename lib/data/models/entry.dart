class EntryModel {
  final String id;
  final String type; // "income" | "expense"
  final String title;
  final String iconType; // "emoji" | "material"
  final String iconValue;
  final double amount;
  final String currencyCode;
  final double amountBase;
  final String occurredAt; // ISO 8601 date "YYYY-MM-DD"
  final String? groupId;
  final String? receiptImagePath;
  final String createdAt;
  final String updatedAt;

  const EntryModel({
    required this.id,
    required this.type,
    required this.title,
    required this.iconType,
    required this.iconValue,
    required this.amount,
    required this.currencyCode,
    required this.amountBase,
    required this.occurredAt,
    this.groupId,
    this.receiptImagePath,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isIncome => type == 'income';
  bool get isExpense => type == 'expense';

  EntryModel copyWith({
    String? id,
    String? type,
    String? title,
    String? iconType,
    String? iconValue,
    double? amount,
    String? currencyCode,
    double? amountBase,
    String? occurredAt,
    String? groupId,
    String? receiptImagePath,
    String? createdAt,
    String? updatedAt,
  }) {
    return EntryModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      iconType: iconType ?? this.iconType,
      iconValue: iconValue ?? this.iconValue,
      amount: amount ?? this.amount,
      currencyCode: currencyCode ?? this.currencyCode,
      amountBase: amountBase ?? this.amountBase,
      occurredAt: occurredAt ?? this.occurredAt,
      groupId: groupId ?? this.groupId,
      receiptImagePath: receiptImagePath ?? this.receiptImagePath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'iconType': iconType,
      'iconValue': iconValue,
      'amount': amount,
      'currencyCode': currencyCode,
      'amountBase': amountBase,
      'occurredAt': occurredAt,
      'groupId': groupId,
      'receiptImagePath': receiptImagePath,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory EntryModel.fromMap(Map<String, dynamic> map) {
    return EntryModel(
      id: map['id'] as String,
      type: map['type'] as String,
      title: map['title'] as String,
      iconType: map['iconType'] as String,
      iconValue: map['iconValue'] as String,
      amount: (map['amount'] as num).toDouble(),
      currencyCode: map['currencyCode'] as String,
      amountBase: (map['amountBase'] as num).toDouble(),
      occurredAt: map['occurredAt'] as String,
      groupId: map['groupId'] as String?,
      receiptImagePath: map['receiptImagePath'] as String?,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }
}
