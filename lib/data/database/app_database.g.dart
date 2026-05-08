// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
part of 'app_database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class EntriesTableData extends DataClass
    implements Insertable<EntriesTableData> {
  final String id;
  final String type;
  final String title;
  final String iconType;
  final String iconValue;
  final double amount;
  final String currencyCode;
  final double amountBase;
  final String occurredAt;
  final String? groupId;
  final String? receiptImagePath;
  final String createdAt;
  final String updatedAt;
  const EntriesTableData({
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['title'] = Variable<String>(title);
    map['icon_type'] = Variable<String>(iconType);
    map['icon_value'] = Variable<String>(iconValue);
    map['amount'] = Variable<double>(amount);
    map['currency_code'] = Variable<String>(currencyCode);
    map['amount_base'] = Variable<double>(amountBase);
    map['occurred_at'] = Variable<String>(occurredAt);
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<String>(groupId);
    }
    if (!nullToAbsent || receiptImagePath != null) {
      map['receipt_image_path'] = Variable<String>(receiptImagePath);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  EntriesTableCompanion toCompanion(bool nullToAbsent) {
    return EntriesTableCompanion(
      id: Value(id),
      type: Value(type),
      title: Value(title),
      iconType: Value(iconType),
      iconValue: Value(iconValue),
      amount: Value(amount),
      currencyCode: Value(currencyCode),
      amountBase: Value(amountBase),
      occurredAt: Value(occurredAt),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
      receiptImagePath: receiptImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptImagePath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory EntriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntriesTableData(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      title: serializer.fromJson<String>(json['title']),
      iconType: serializer.fromJson<String>(json['iconType']),
      iconValue: serializer.fromJson<String>(json['iconValue']),
      amount: serializer.fromJson<double>(json['amount']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      amountBase: serializer.fromJson<double>(json['amountBase']),
      occurredAt: serializer.fromJson<String>(json['occurredAt']),
      groupId: serializer.fromJson<String?>(json['groupId']),
      receiptImagePath: serializer.fromJson<String?>(json['receiptImagePath']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'title': serializer.toJson<String>(title),
      'iconType': serializer.toJson<String>(iconType),
      'iconValue': serializer.toJson<String>(iconValue),
      'amount': serializer.toJson<double>(amount),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'amountBase': serializer.toJson<double>(amountBase),
      'occurredAt': serializer.toJson<String>(occurredAt),
      'groupId': serializer.toJson<String?>(groupId),
      'receiptImagePath': serializer.toJson<String?>(receiptImagePath),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  EntriesTableData copyWith({
    String? id,
    String? type,
    String? title,
    String? iconType,
    String? iconValue,
    double? amount,
    String? currencyCode,
    double? amountBase,
    String? occurredAt,
    Value<String?> groupId = const Value.absent(),
    Value<String?> receiptImagePath = const Value.absent(),
    String? createdAt,
    String? updatedAt,
  }) =>
      EntriesTableData(
        id: id ?? this.id,
        type: type ?? this.type,
        title: title ?? this.title,
        iconType: iconType ?? this.iconType,
        iconValue: iconValue ?? this.iconValue,
        amount: amount ?? this.amount,
        currencyCode: currencyCode ?? this.currencyCode,
        amountBase: amountBase ?? this.amountBase,
        occurredAt: occurredAt ?? this.occurredAt,
        groupId: groupId.present ? groupId.value : this.groupId,
        receiptImagePath: receiptImagePath.present
            ? receiptImagePath.value
            : this.receiptImagePath,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('EntriesTableData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('iconType: $iconType, ')
          ..write('iconValue: $iconValue, ')
          ..write('amount: $amount, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('amountBase: $amountBase, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('groupId: $groupId, ')
          ..write('receiptImagePath: $receiptImagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
        id,
        type,
        title,
        iconType,
        iconValue,
        amount,
        currencyCode,
        amountBase,
        occurredAt,
        groupId,
        receiptImagePath,
        createdAt,
        updatedAt,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntriesTableData &&
          other.id == this.id &&
          other.type == this.type &&
          other.title == this.title &&
          other.iconType == this.iconType &&
          other.iconValue == this.iconValue &&
          other.amount == this.amount &&
          other.currencyCode == this.currencyCode &&
          other.amountBase == this.amountBase &&
          other.occurredAt == this.occurredAt &&
          other.groupId == this.groupId &&
          other.receiptImagePath == this.receiptImagePath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EntriesTableCompanion extends UpdateCompanion<EntriesTableData> {
  final Value<String> id;
  final Value<String> type;
  final Value<String> title;
  final Value<String> iconType;
  final Value<String> iconValue;
  final Value<double> amount;
  final Value<String> currencyCode;
  final Value<double> amountBase;
  final Value<String> occurredAt;
  final Value<String?> groupId;
  final Value<String?> receiptImagePath;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const EntriesTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.iconType = const Value.absent(),
    this.iconValue = const Value.absent(),
    this.amount = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.amountBase = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.groupId = const Value.absent(),
    this.receiptImagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntriesTableCompanion.insert({
    required String id,
    required String type,
    required String title,
    required String iconType,
    required String iconValue,
    required double amount,
    required String currencyCode,
    required double amountBase,
    required String occurredAt,
    this.groupId = const Value.absent(),
    this.receiptImagePath = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        type = Value(type),
        title = Value(title),
        iconType = Value(iconType),
        iconValue = Value(iconValue),
        amount = Value(amount),
        currencyCode = Value(currencyCode),
        amountBase = Value(amountBase),
        occurredAt = Value(occurredAt),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<EntriesTableData> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? title,
    Expression<String>? iconType,
    Expression<String>? iconValue,
    Expression<double>? amount,
    Expression<String>? currencyCode,
    Expression<double>? amountBase,
    Expression<String>? occurredAt,
    Expression<String>? groupId,
    Expression<String>? receiptImagePath,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (iconType != null) 'icon_type': iconType,
      if (iconValue != null) 'icon_value': iconValue,
      if (amount != null) 'amount': amount,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (amountBase != null) 'amount_base': amountBase,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (groupId != null) 'group_id': groupId,
      if (receiptImagePath != null) 'receipt_image_path': receiptImagePath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntriesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<String>? title,
    Value<String>? iconType,
    Value<String>? iconValue,
    Value<double>? amount,
    Value<String>? currencyCode,
    Value<double>? amountBase,
    Value<String>? occurredAt,
    Value<String?>? groupId,
    Value<String?>? receiptImagePath,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? rowid,
  }) {
    return EntriesTableCompanion(
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (iconType.present) {
      map['icon_type'] = Variable<String>(iconType.value);
    }
    if (iconValue.present) {
      map['icon_value'] = Variable<String>(iconValue.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (amountBase.present) {
      map['amount_base'] = Variable<double>(amountBase.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<String>(occurredAt.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (receiptImagePath.present) {
      map['receipt_image_path'] = Variable<String>(receiptImagePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntriesTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('iconType: $iconType, ')
          ..write('iconValue: $iconValue, ')
          ..write('amount: $amount, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('amountBase: $amountBase, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('groupId: $groupId, ')
          ..write('receiptImagePath: $receiptImagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EntriesTableTable extends EntriesTable
    with TableInfo<$EntriesTableTable, EntriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconTypeMeta = const VerificationMeta(
    'iconType',
  );
  @override
  late final GeneratedColumn<String> iconType = GeneratedColumn<String>(
    'icon_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconValueMeta = const VerificationMeta(
    'iconValue',
  );
  @override
  late final GeneratedColumn<String> iconValue = GeneratedColumn<String>(
    'icon_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountBaseMeta = const VerificationMeta(
    'amountBase',
  );
  @override
  late final GeneratedColumn<double> amountBase = GeneratedColumn<double>(
    'amount_base',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<String> occurredAt = GeneratedColumn<String>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
    'group_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES entry_groups(id)',
  );
  static const VerificationMeta _receiptImagePathMeta = const VerificationMeta(
    'receiptImagePath',
  );
  @override
  late final GeneratedColumn<String> receiptImagePath = GeneratedColumn<String>(
    'receipt_image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
        id,
        type,
        title,
        iconType,
        iconValue,
        amount,
        currencyCode,
        amountBase,
        occurredAt,
        groupId,
        receiptImagePath,
        createdAt,
        updatedAt,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<EntriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('icon_type')) {
      context.handle(
        _iconTypeMeta,
        iconType.isAcceptableOrUnknown(data['icon_type']!, _iconTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_iconTypeMeta);
    }
    if (data.containsKey('icon_value')) {
      context.handle(
        _iconValueMeta,
        iconValue.isAcceptableOrUnknown(data['icon_value']!, _iconValueMeta),
      );
    } else if (isInserting) {
      context.missing(_iconValueMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('amount_base')) {
      context.handle(
        _amountBaseMeta,
        amountBase.isAcceptableOrUnknown(data['amount_base']!, _amountBaseMeta),
      );
    } else if (isInserting) {
      context.missing(_amountBaseMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    }
    if (data.containsKey('receipt_image_path')) {
      context.handle(
        _receiptImagePathMeta,
        receiptImagePath.isAcceptableOrUnknown(
          data['receipt_image_path']!,
          _receiptImagePathMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EntriesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntriesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      iconType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_type'],
      )!,
      iconValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_value'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      amountBase: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount_base'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}occurred_at'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_id'],
      ),
      receiptImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_image_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EntriesTableTable createAlias(String alias) {
    return $EntriesTableTable(attachedDatabase, alias);
  }
}

class EntryGroupsTableData extends DataClass
    implements Insertable<EntryGroupsTableData> {
  final String id;
  final String name;
  final String iconType;
  final String iconValue;
  final String createdAt;
  const EntryGroupsTableData({
    required this.id,
    required this.name,
    required this.iconType,
    required this.iconValue,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['icon_type'] = Variable<String>(iconType);
    map['icon_value'] = Variable<String>(iconValue);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  EntryGroupsTableCompanion toCompanion(bool nullToAbsent) {
    return EntryGroupsTableCompanion(
      id: Value(id),
      name: Value(name),
      iconType: Value(iconType),
      iconValue: Value(iconValue),
      createdAt: Value(createdAt),
    );
  }

  factory EntryGroupsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntryGroupsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      iconType: serializer.fromJson<String>(json['iconType']),
      iconValue: serializer.fromJson<String>(json['iconValue']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'iconType': serializer.toJson<String>(iconType),
      'iconValue': serializer.toJson<String>(iconValue),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  EntryGroupsTableData copyWith({
    String? id,
    String? name,
    String? iconType,
    String? iconValue,
    String? createdAt,
  }) =>
      EntryGroupsTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        iconType: iconType ?? this.iconType,
        iconValue: iconValue ?? this.iconValue,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('EntryGroupsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconType: $iconType, ')
          ..write('iconValue: $iconValue, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, iconType, iconValue, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntryGroupsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.iconType == this.iconType &&
          other.iconValue == this.iconValue &&
          other.createdAt == this.createdAt);
}

class EntryGroupsTableCompanion extends UpdateCompanion<EntryGroupsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> iconType;
  final Value<String> iconValue;
  final Value<String> createdAt;
  final Value<int> rowid;
  const EntryGroupsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.iconType = const Value.absent(),
    this.iconValue = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntryGroupsTableCompanion.insert({
    required String id,
    required String name,
    required String iconType,
    required String iconValue,
    required String createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        iconType = Value(iconType),
        iconValue = Value(iconValue),
        createdAt = Value(createdAt);
  static Insertable<EntryGroupsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? iconType,
    Expression<String>? iconValue,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (iconType != null) 'icon_type': iconType,
      if (iconValue != null) 'icon_value': iconValue,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntryGroupsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? iconType,
    Value<String>? iconValue,
    Value<String>? createdAt,
    Value<int>? rowid,
  }) {
    return EntryGroupsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      iconType: iconType ?? this.iconType,
      iconValue: iconValue ?? this.iconValue,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconType.present) {
      map['icon_type'] = Variable<String>(iconType.value);
    }
    if (iconValue.present) {
      map['icon_value'] = Variable<String>(iconValue.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntryGroupsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconType: $iconType, ')
          ..write('iconValue: $iconValue, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EntryGroupsTableTable extends EntryGroupsTable
    with TableInfo<$EntryGroupsTableTable, EntryGroupsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntryGroupsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconTypeMeta = const VerificationMeta(
    'iconType',
  );
  @override
  late final GeneratedColumn<String> iconType = GeneratedColumn<String>(
    'icon_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconValueMeta = const VerificationMeta(
    'iconValue',
  );
  @override
  late final GeneratedColumn<String> iconValue = GeneratedColumn<String>(
    'icon_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        iconType,
        iconValue,
        createdAt,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entry_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<EntryGroupsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_type')) {
      context.handle(
        _iconTypeMeta,
        iconType.isAcceptableOrUnknown(data['icon_type']!, _iconTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_iconTypeMeta);
    }
    if (data.containsKey('icon_value')) {
      context.handle(
        _iconValueMeta,
        iconValue.isAcceptableOrUnknown(data['icon_value']!, _iconValueMeta),
      );
    } else if (isInserting) {
      context.missing(_iconValueMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EntryGroupsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntryGroupsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      iconType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_type'],
      )!,
      iconValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_value'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $EntryGroupsTableTable createAlias(String alias) {
    return $EntryGroupsTableTable(attachedDatabase, alias);
  }
}

class CurrenciesTableData extends DataClass
    implements Insertable<CurrenciesTableData> {
  final String code;
  final String name;
  final String symbol;
  final double rateToBase;
  const CurrenciesTableData({
    required this.code,
    required this.name,
    required this.symbol,
    required this.rateToBase,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['symbol'] = Variable<String>(symbol);
    map['rate_to_base'] = Variable<double>(rateToBase);
    return map;
  }

  CurrenciesTableCompanion toCompanion(bool nullToAbsent) {
    return CurrenciesTableCompanion(
      code: Value(code),
      name: Value(name),
      symbol: Value(symbol),
      rateToBase: Value(rateToBase),
    );
  }

  factory CurrenciesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CurrenciesTableData(
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      symbol: serializer.fromJson<String>(json['symbol']),
      rateToBase: serializer.fromJson<double>(json['rateToBase']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'symbol': serializer.toJson<String>(symbol),
      'rateToBase': serializer.toJson<double>(rateToBase),
    };
  }

  CurrenciesTableData copyWith({
    String? code,
    String? name,
    String? symbol,
    double? rateToBase,
  }) =>
      CurrenciesTableData(
        code: code ?? this.code,
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        rateToBase: rateToBase ?? this.rateToBase,
      );
  @override
  String toString() {
    return (StringBuffer('CurrenciesTableData(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('symbol: $symbol, ')
          ..write('rateToBase: $rateToBase')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, name, symbol, rateToBase);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CurrenciesTableData &&
          other.code == this.code &&
          other.name == this.name &&
          other.symbol == this.symbol &&
          other.rateToBase == this.rateToBase);
}

class CurrenciesTableCompanion extends UpdateCompanion<CurrenciesTableData> {
  final Value<String> code;
  final Value<String> name;
  final Value<String> symbol;
  final Value<double> rateToBase;
  final Value<int> rowid;
  const CurrenciesTableCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.symbol = const Value.absent(),
    this.rateToBase = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CurrenciesTableCompanion.insert({
    required String code,
    required String name,
    required String symbol,
    required double rateToBase,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name),
        symbol = Value(symbol),
        rateToBase = Value(rateToBase);
  static Insertable<CurrenciesTableData> custom({
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? symbol,
    Expression<double>? rateToBase,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (symbol != null) 'symbol': symbol,
      if (rateToBase != null) 'rate_to_base': rateToBase,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CurrenciesTableCompanion copyWith({
    Value<String>? code,
    Value<String>? name,
    Value<String>? symbol,
    Value<double>? rateToBase,
    Value<int>? rowid,
  }) {
    return CurrenciesTableCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      rateToBase: rateToBase ?? this.rateToBase,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (rateToBase.present) {
      map['rate_to_base'] = Variable<double>(rateToBase.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CurrenciesTableCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('symbol: $symbol, ')
          ..write('rateToBase: $rateToBase, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CurrenciesTableTable extends CurrenciesTable
    with TableInfo<$CurrenciesTableTable, CurrenciesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CurrenciesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
    'symbol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rateToBaseMeta = const VerificationMeta(
    'rateToBase',
  );
  @override
  late final GeneratedColumn<double> rateToBase = GeneratedColumn<double>(
    'rate_to_base',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [code, name, symbol, rateToBase];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'currencies';
  @override
  VerificationContext validateIntegrity(
    Insertable<CurrenciesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('symbol')) {
      context.handle(
        _symbolMeta,
        symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta),
      );
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    if (data.containsKey('rate_to_base')) {
      context.handle(
        _rateToBaseMeta,
        rateToBase.isAcceptableOrUnknown(
          data['rate_to_base']!,
          _rateToBaseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rateToBaseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  CurrenciesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CurrenciesTableData(
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      rateToBase: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rate_to_base'],
      )!,
    );
  }

  @override
  $CurrenciesTableTable createAlias(String alias) {
    return $CurrenciesTableTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $EntriesTableTable entriesTable = $EntriesTableTable(this);
  late final $EntryGroupsTableTable entryGroupsTable = $EntryGroupsTableTable(
    this,
  );
  late final $CurrenciesTableTable currenciesTable = $CurrenciesTableTable(
    this,
  );
  late final EntriesDao entriesDao = EntriesDao(this as AppDatabase);
  late final GroupsDao groupsDao = GroupsDao(this as AppDatabase);
  late final CurrenciesDao currenciesDao = CurrenciesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        entriesTable,
        entryGroupsTable,
        currenciesTable,
      ];
}
