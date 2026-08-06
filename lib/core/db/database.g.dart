// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bankNameMeta = const VerificationMeta(
    'bankName',
  );
  @override
  late final GeneratedColumn<String> bankName = GeneratedColumn<String>(
    'bank_name',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 60),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accountNoSuffixMeta = const VerificationMeta(
    'accountNoSuffix',
  );
  @override
  late final GeneratedColumn<String> accountNoSuffix = GeneratedColumn<String>(
    'account_no_suffix',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 12),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _initialBalanceRialMeta =
      const VerificationMeta('initialBalanceRial');
  @override
  late final GeneratedColumn<int> initialBalanceRial = GeneratedColumn<int>(
    'initial_balance_rial',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastSmsBalanceRialMeta =
      const VerificationMeta('lastSmsBalanceRial');
  @override
  late final GeneratedColumn<int> lastSmsBalanceRial = GeneratedColumn<int>(
    'last_sms_balance_rial',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSmsBalanceAtMeta = const VerificationMeta(
    'lastSmsBalanceAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSmsBalanceAt =
      GeneratedColumn<DateTime>(
        'last_sms_balance_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    bankName,
    accountNoSuffix,
    initialBalanceRial,
    lastSmsBalanceRial,
    lastSmsBalanceAt,
    colorValue,
    sortOrder,
    isArchived,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Account> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('bank_name')) {
      context.handle(
        _bankNameMeta,
        bankName.isAcceptableOrUnknown(data['bank_name']!, _bankNameMeta),
      );
    }
    if (data.containsKey('account_no_suffix')) {
      context.handle(
        _accountNoSuffixMeta,
        accountNoSuffix.isAcceptableOrUnknown(
          data['account_no_suffix']!,
          _accountNoSuffixMeta,
        ),
      );
    }
    if (data.containsKey('initial_balance_rial')) {
      context.handle(
        _initialBalanceRialMeta,
        initialBalanceRial.isAcceptableOrUnknown(
          data['initial_balance_rial']!,
          _initialBalanceRialMeta,
        ),
      );
    }
    if (data.containsKey('last_sms_balance_rial')) {
      context.handle(
        _lastSmsBalanceRialMeta,
        lastSmsBalanceRial.isAcceptableOrUnknown(
          data['last_sms_balance_rial']!,
          _lastSmsBalanceRialMeta,
        ),
      );
    }
    if (data.containsKey('last_sms_balance_at')) {
      context.handle(
        _lastSmsBalanceAtMeta,
        lastSmsBalanceAt.isAcceptableOrUnknown(
          data['last_sms_balance_at']!,
          _lastSmsBalanceAtMeta,
        ),
      );
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Account(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      bankName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_name'],
      ),
      accountNoSuffix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_no_suffix'],
      ),
      initialBalanceRial: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}initial_balance_rial'],
      )!,
      lastSmsBalanceRial: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_sms_balance_rial'],
      ),
      lastSmsBalanceAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sms_balance_at'],
      ),
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class Account extends DataClass implements Insertable<Account> {
  final int id;
  final String name;
  final String? bankName;

  /// Trailing digits of the card/account as they appear in bank SMS —
  /// used to route an incoming message to the right account.
  final String? accountNoSuffix;
  final int initialBalanceRial;

  /// Balance as last reported by a bank SMS, used only to detect drift
  /// between recorded transactions and reality.
  final int? lastSmsBalanceRial;
  final DateTime? lastSmsBalanceAt;
  final int? colorValue;
  final int sortOrder;
  final bool isArchived;
  final DateTime createdAt;
  const Account({
    required this.id,
    required this.name,
    this.bankName,
    this.accountNoSuffix,
    required this.initialBalanceRial,
    this.lastSmsBalanceRial,
    this.lastSmsBalanceAt,
    this.colorValue,
    required this.sortOrder,
    required this.isArchived,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || bankName != null) {
      map['bank_name'] = Variable<String>(bankName);
    }
    if (!nullToAbsent || accountNoSuffix != null) {
      map['account_no_suffix'] = Variable<String>(accountNoSuffix);
    }
    map['initial_balance_rial'] = Variable<int>(initialBalanceRial);
    if (!nullToAbsent || lastSmsBalanceRial != null) {
      map['last_sms_balance_rial'] = Variable<int>(lastSmsBalanceRial);
    }
    if (!nullToAbsent || lastSmsBalanceAt != null) {
      map['last_sms_balance_at'] = Variable<DateTime>(lastSmsBalanceAt);
    }
    if (!nullToAbsent || colorValue != null) {
      map['color_value'] = Variable<int>(colorValue);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      name: Value(name),
      bankName: bankName == null && nullToAbsent
          ? const Value.absent()
          : Value(bankName),
      accountNoSuffix: accountNoSuffix == null && nullToAbsent
          ? const Value.absent()
          : Value(accountNoSuffix),
      initialBalanceRial: Value(initialBalanceRial),
      lastSmsBalanceRial: lastSmsBalanceRial == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSmsBalanceRial),
      lastSmsBalanceAt: lastSmsBalanceAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSmsBalanceAt),
      colorValue: colorValue == null && nullToAbsent
          ? const Value.absent()
          : Value(colorValue),
      sortOrder: Value(sortOrder),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
    );
  }

  factory Account.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      bankName: serializer.fromJson<String?>(json['bankName']),
      accountNoSuffix: serializer.fromJson<String?>(json['accountNoSuffix']),
      initialBalanceRial: serializer.fromJson<int>(json['initialBalanceRial']),
      lastSmsBalanceRial: serializer.fromJson<int?>(json['lastSmsBalanceRial']),
      lastSmsBalanceAt: serializer.fromJson<DateTime?>(
        json['lastSmsBalanceAt'],
      ),
      colorValue: serializer.fromJson<int?>(json['colorValue']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'bankName': serializer.toJson<String?>(bankName),
      'accountNoSuffix': serializer.toJson<String?>(accountNoSuffix),
      'initialBalanceRial': serializer.toJson<int>(initialBalanceRial),
      'lastSmsBalanceRial': serializer.toJson<int?>(lastSmsBalanceRial),
      'lastSmsBalanceAt': serializer.toJson<DateTime?>(lastSmsBalanceAt),
      'colorValue': serializer.toJson<int?>(colorValue),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Account copyWith({
    int? id,
    String? name,
    Value<String?> bankName = const Value.absent(),
    Value<String?> accountNoSuffix = const Value.absent(),
    int? initialBalanceRial,
    Value<int?> lastSmsBalanceRial = const Value.absent(),
    Value<DateTime?> lastSmsBalanceAt = const Value.absent(),
    Value<int?> colorValue = const Value.absent(),
    int? sortOrder,
    bool? isArchived,
    DateTime? createdAt,
  }) => Account(
    id: id ?? this.id,
    name: name ?? this.name,
    bankName: bankName.present ? bankName.value : this.bankName,
    accountNoSuffix: accountNoSuffix.present
        ? accountNoSuffix.value
        : this.accountNoSuffix,
    initialBalanceRial: initialBalanceRial ?? this.initialBalanceRial,
    lastSmsBalanceRial: lastSmsBalanceRial.present
        ? lastSmsBalanceRial.value
        : this.lastSmsBalanceRial,
    lastSmsBalanceAt: lastSmsBalanceAt.present
        ? lastSmsBalanceAt.value
        : this.lastSmsBalanceAt,
    colorValue: colorValue.present ? colorValue.value : this.colorValue,
    sortOrder: sortOrder ?? this.sortOrder,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
  );
  Account copyWithCompanion(AccountsCompanion data) {
    return Account(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      bankName: data.bankName.present ? data.bankName.value : this.bankName,
      accountNoSuffix: data.accountNoSuffix.present
          ? data.accountNoSuffix.value
          : this.accountNoSuffix,
      initialBalanceRial: data.initialBalanceRial.present
          ? data.initialBalanceRial.value
          : this.initialBalanceRial,
      lastSmsBalanceRial: data.lastSmsBalanceRial.present
          ? data.lastSmsBalanceRial.value
          : this.lastSmsBalanceRial,
      lastSmsBalanceAt: data.lastSmsBalanceAt.present
          ? data.lastSmsBalanceAt.value
          : this.lastSmsBalanceAt,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('bankName: $bankName, ')
          ..write('accountNoSuffix: $accountNoSuffix, ')
          ..write('initialBalanceRial: $initialBalanceRial, ')
          ..write('lastSmsBalanceRial: $lastSmsBalanceRial, ')
          ..write('lastSmsBalanceAt: $lastSmsBalanceAt, ')
          ..write('colorValue: $colorValue, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    bankName,
    accountNoSuffix,
    initialBalanceRial,
    lastSmsBalanceRial,
    lastSmsBalanceAt,
    colorValue,
    sortOrder,
    isArchived,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.id == this.id &&
          other.name == this.name &&
          other.bankName == this.bankName &&
          other.accountNoSuffix == this.accountNoSuffix &&
          other.initialBalanceRial == this.initialBalanceRial &&
          other.lastSmsBalanceRial == this.lastSmsBalanceRial &&
          other.lastSmsBalanceAt == this.lastSmsBalanceAt &&
          other.colorValue == this.colorValue &&
          other.sortOrder == this.sortOrder &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> bankName;
  final Value<String?> accountNoSuffix;
  final Value<int> initialBalanceRial;
  final Value<int?> lastSmsBalanceRial;
  final Value<DateTime?> lastSmsBalanceAt;
  final Value<int?> colorValue;
  final Value<int> sortOrder;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.bankName = const Value.absent(),
    this.accountNoSuffix = const Value.absent(),
    this.initialBalanceRial = const Value.absent(),
    this.lastSmsBalanceRial = const Value.absent(),
    this.lastSmsBalanceAt = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.bankName = const Value.absent(),
    this.accountNoSuffix = const Value.absent(),
    this.initialBalanceRial = const Value.absent(),
    this.lastSmsBalanceRial = const Value.absent(),
    this.lastSmsBalanceAt = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isArchived = const Value.absent(),
    required DateTime createdAt,
  }) : name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<Account> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? bankName,
    Expression<String>? accountNoSuffix,
    Expression<int>? initialBalanceRial,
    Expression<int>? lastSmsBalanceRial,
    Expression<DateTime>? lastSmsBalanceAt,
    Expression<int>? colorValue,
    Expression<int>? sortOrder,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (bankName != null) 'bank_name': bankName,
      if (accountNoSuffix != null) 'account_no_suffix': accountNoSuffix,
      if (initialBalanceRial != null)
        'initial_balance_rial': initialBalanceRial,
      if (lastSmsBalanceRial != null)
        'last_sms_balance_rial': lastSmsBalanceRial,
      if (lastSmsBalanceAt != null) 'last_sms_balance_at': lastSmsBalanceAt,
      if (colorValue != null) 'color_value': colorValue,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AccountsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? bankName,
    Value<String?>? accountNoSuffix,
    Value<int>? initialBalanceRial,
    Value<int?>? lastSmsBalanceRial,
    Value<DateTime?>? lastSmsBalanceAt,
    Value<int?>? colorValue,
    Value<int>? sortOrder,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
  }) {
    return AccountsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      bankName: bankName ?? this.bankName,
      accountNoSuffix: accountNoSuffix ?? this.accountNoSuffix,
      initialBalanceRial: initialBalanceRial ?? this.initialBalanceRial,
      lastSmsBalanceRial: lastSmsBalanceRial ?? this.lastSmsBalanceRial,
      lastSmsBalanceAt: lastSmsBalanceAt ?? this.lastSmsBalanceAt,
      colorValue: colorValue ?? this.colorValue,
      sortOrder: sortOrder ?? this.sortOrder,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (bankName.present) {
      map['bank_name'] = Variable<String>(bankName.value);
    }
    if (accountNoSuffix.present) {
      map['account_no_suffix'] = Variable<String>(accountNoSuffix.value);
    }
    if (initialBalanceRial.present) {
      map['initial_balance_rial'] = Variable<int>(initialBalanceRial.value);
    }
    if (lastSmsBalanceRial.present) {
      map['last_sms_balance_rial'] = Variable<int>(lastSmsBalanceRial.value);
    }
    if (lastSmsBalanceAt.present) {
      map['last_sms_balance_at'] = Variable<DateTime>(lastSmsBalanceAt.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('bankName: $bankName, ')
          ..write('accountNoSuffix: $accountNoSuffix, ')
          ..write('initialBalanceRial: $initialBalanceRial, ')
          ..write('lastSmsBalanceRial: $lastSmsBalanceRial, ')
          ..write('lastSmsBalanceAt: $lastSmsBalanceAt, ')
          ..write('colorValue: $colorValue, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CategoryKind, int> kind =
      GeneratedColumn<int>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<CategoryKind>($CategoriesTable.$converterkind);
  static const VerificationMeta _iconCodeMeta = const VerificationMeta(
    'iconCode',
  );
  @override
  late final GeneratedColumn<int> iconCode = GeneratedColumn<int>(
    'icon_code',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isSystemMeta = const VerificationMeta(
    'isSystem',
  );
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
    'is_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _systemKeyMeta = const VerificationMeta(
    'systemKey',
  );
  @override
  late final GeneratedColumn<String> systemKey = GeneratedColumn<String>(
    'system_key',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 40),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    kind,
    iconCode,
    colorValue,
    sortOrder,
    isSystem,
    systemKey,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_code')) {
      context.handle(
        _iconCodeMeta,
        iconCode.isAcceptableOrUnknown(data['icon_code']!, _iconCodeMeta),
      );
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_system')) {
      context.handle(
        _isSystemMeta,
        isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta),
      );
    }
    if (data.containsKey('system_key')) {
      context.handle(
        _systemKeyMeta,
        systemKey.isAcceptableOrUnknown(data['system_key']!, _systemKeyMeta),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: $CategoriesTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}kind'],
        )!,
      ),
      iconCode: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}icon_code'],
      ),
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system'],
      )!,
      systemKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}system_key'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CategoryKind, int, int> $converterkind =
      const EnumIndexConverter<CategoryKind>(CategoryKind.values);
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  final CategoryKind kind;
  final int? iconCode;
  final int? colorValue;
  final int sortOrder;

  /// System categories are seeded, undeletable, and excluded from the
  /// "properly categorized" share of the commitment score.
  final bool isSystem;

  /// Stable key for looking up seeded system rows (e.g. `debt_payment`).
  final String? systemKey;
  final DateTime createdAt;
  const Category({
    required this.id,
    required this.name,
    required this.kind,
    this.iconCode,
    this.colorValue,
    required this.sortOrder,
    required this.isSystem,
    this.systemKey,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['kind'] = Variable<int>($CategoriesTable.$converterkind.toSql(kind));
    }
    if (!nullToAbsent || iconCode != null) {
      map['icon_code'] = Variable<int>(iconCode);
    }
    if (!nullToAbsent || colorValue != null) {
      map['color_value'] = Variable<int>(colorValue);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_system'] = Variable<bool>(isSystem);
    if (!nullToAbsent || systemKey != null) {
      map['system_key'] = Variable<String>(systemKey);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      kind: Value(kind),
      iconCode: iconCode == null && nullToAbsent
          ? const Value.absent()
          : Value(iconCode),
      colorValue: colorValue == null && nullToAbsent
          ? const Value.absent()
          : Value(colorValue),
      sortOrder: Value(sortOrder),
      isSystem: Value(isSystem),
      systemKey: systemKey == null && nullToAbsent
          ? const Value.absent()
          : Value(systemKey),
      createdAt: Value(createdAt),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      kind: $CategoriesTable.$converterkind.fromJson(
        serializer.fromJson<int>(json['kind']),
      ),
      iconCode: serializer.fromJson<int?>(json['iconCode']),
      colorValue: serializer.fromJson<int?>(json['colorValue']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
      systemKey: serializer.fromJson<String?>(json['systemKey']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<int>(
        $CategoriesTable.$converterkind.toJson(kind),
      ),
      'iconCode': serializer.toJson<int?>(iconCode),
      'colorValue': serializer.toJson<int?>(colorValue),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isSystem': serializer.toJson<bool>(isSystem),
      'systemKey': serializer.toJson<String?>(systemKey),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Category copyWith({
    int? id,
    String? name,
    CategoryKind? kind,
    Value<int?> iconCode = const Value.absent(),
    Value<int?> colorValue = const Value.absent(),
    int? sortOrder,
    bool? isSystem,
    Value<String?> systemKey = const Value.absent(),
    DateTime? createdAt,
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    iconCode: iconCode.present ? iconCode.value : this.iconCode,
    colorValue: colorValue.present ? colorValue.value : this.colorValue,
    sortOrder: sortOrder ?? this.sortOrder,
    isSystem: isSystem ?? this.isSystem,
    systemKey: systemKey.present ? systemKey.value : this.systemKey,
    createdAt: createdAt ?? this.createdAt,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      iconCode: data.iconCode.present ? data.iconCode.value : this.iconCode,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
      systemKey: data.systemKey.present ? data.systemKey.value : this.systemKey,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('iconCode: $iconCode, ')
          ..write('colorValue: $colorValue, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isSystem: $isSystem, ')
          ..write('systemKey: $systemKey, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    kind,
    iconCode,
    colorValue,
    sortOrder,
    isSystem,
    systemKey,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.iconCode == this.iconCode &&
          other.colorValue == this.colorValue &&
          other.sortOrder == this.sortOrder &&
          other.isSystem == this.isSystem &&
          other.systemKey == this.systemKey &&
          other.createdAt == this.createdAt);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  final Value<CategoryKind> kind;
  final Value<int?> iconCode;
  final Value<int?> colorValue;
  final Value<int> sortOrder;
  final Value<bool> isSystem;
  final Value<String?> systemKey;
  final Value<DateTime> createdAt;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.iconCode = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.systemKey = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required CategoryKind kind,
    this.iconCode = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.systemKey = const Value.absent(),
    required DateTime createdAt,
  }) : name = Value(name),
       kind = Value(kind),
       createdAt = Value(createdAt);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? kind,
    Expression<int>? iconCode,
    Expression<int>? colorValue,
    Expression<int>? sortOrder,
    Expression<bool>? isSystem,
    Expression<String>? systemKey,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (iconCode != null) 'icon_code': iconCode,
      if (colorValue != null) 'color_value': colorValue,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isSystem != null) 'is_system': isSystem,
      if (systemKey != null) 'system_key': systemKey,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<CategoryKind>? kind,
    Value<int?>? iconCode,
    Value<int?>? colorValue,
    Value<int>? sortOrder,
    Value<bool>? isSystem,
    Value<String?>? systemKey,
    Value<DateTime>? createdAt,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      iconCode: iconCode ?? this.iconCode,
      colorValue: colorValue ?? this.colorValue,
      sortOrder: sortOrder ?? this.sortOrder,
      isSystem: isSystem ?? this.isSystem,
      systemKey: systemKey ?? this.systemKey,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<int>(
        $CategoriesTable.$converterkind.toSql(kind.value),
      );
    }
    if (iconCode.present) {
      map['icon_code'] = Variable<int>(iconCode.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (systemKey.present) {
      map['system_key'] = Variable<String>(systemKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('iconCode: $iconCode, ')
          ..write('colorValue: $colorValue, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isSystem: $isSystem, ')
          ..write('systemKey: $systemKey, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $RawSmsTable extends RawSms with TableInfo<$RawSmsTable, RawSm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RawSmsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _senderMeta = const VerificationMeta('sender');
  @override
  late final GeneratedColumn<String> sender = GeneratedColumn<String>(
    'sender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receivedAtMeta = const VerificationMeta(
    'receivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> receivedAt = GeneratedColumn<DateTime>(
    'received_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SmsParseStatus, int> parseStatus =
      GeneratedColumn<int>(
        'parse_status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<SmsParseStatus>($RawSmsTable.$converterparseStatus);
  static const VerificationMeta _matchedPatternIdMeta = const VerificationMeta(
    'matchedPatternId',
  );
  @override
  late final GeneratedColumn<int> matchedPatternId = GeneratedColumn<int>(
    'matched_pattern_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sender,
    body,
    receivedAt,
    parseStatus,
    matchedPatternId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'raw_sms';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawSm> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sender')) {
      context.handle(
        _senderMeta,
        sender.isAcceptableOrUnknown(data['sender']!, _senderMeta),
      );
    } else if (isInserting) {
      context.missing(_senderMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('received_at')) {
      context.handle(
        _receivedAtMeta,
        receivedAt.isAcceptableOrUnknown(data['received_at']!, _receivedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_receivedAtMeta);
    }
    if (data.containsKey('matched_pattern_id')) {
      context.handle(
        _matchedPatternIdMeta,
        matchedPatternId.isAcceptableOrUnknown(
          data['matched_pattern_id']!,
          _matchedPatternIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawSm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawSm(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      receivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}received_at'],
      )!,
      parseStatus: $RawSmsTable.$converterparseStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}parse_status'],
        )!,
      ),
      matchedPatternId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}matched_pattern_id'],
      ),
    );
  }

  @override
  $RawSmsTable createAlias(String alias) {
    return $RawSmsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SmsParseStatus, int, int> $converterparseStatus =
      const EnumIndexConverter<SmsParseStatus>(SmsParseStatus.values);
}

class RawSm extends DataClass implements Insertable<RawSm> {
  final int id;
  final String sender;
  final String body;
  final DateTime receivedAt;
  final SmsParseStatus parseStatus;
  final int? matchedPatternId;
  const RawSm({
    required this.id,
    required this.sender,
    required this.body,
    required this.receivedAt,
    required this.parseStatus,
    this.matchedPatternId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sender'] = Variable<String>(sender);
    map['body'] = Variable<String>(body);
    map['received_at'] = Variable<DateTime>(receivedAt);
    {
      map['parse_status'] = Variable<int>(
        $RawSmsTable.$converterparseStatus.toSql(parseStatus),
      );
    }
    if (!nullToAbsent || matchedPatternId != null) {
      map['matched_pattern_id'] = Variable<int>(matchedPatternId);
    }
    return map;
  }

  RawSmsCompanion toCompanion(bool nullToAbsent) {
    return RawSmsCompanion(
      id: Value(id),
      sender: Value(sender),
      body: Value(body),
      receivedAt: Value(receivedAt),
      parseStatus: Value(parseStatus),
      matchedPatternId: matchedPatternId == null && nullToAbsent
          ? const Value.absent()
          : Value(matchedPatternId),
    );
  }

  factory RawSm.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawSm(
      id: serializer.fromJson<int>(json['id']),
      sender: serializer.fromJson<String>(json['sender']),
      body: serializer.fromJson<String>(json['body']),
      receivedAt: serializer.fromJson<DateTime>(json['receivedAt']),
      parseStatus: $RawSmsTable.$converterparseStatus.fromJson(
        serializer.fromJson<int>(json['parseStatus']),
      ),
      matchedPatternId: serializer.fromJson<int?>(json['matchedPatternId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sender': serializer.toJson<String>(sender),
      'body': serializer.toJson<String>(body),
      'receivedAt': serializer.toJson<DateTime>(receivedAt),
      'parseStatus': serializer.toJson<int>(
        $RawSmsTable.$converterparseStatus.toJson(parseStatus),
      ),
      'matchedPatternId': serializer.toJson<int?>(matchedPatternId),
    };
  }

  RawSm copyWith({
    int? id,
    String? sender,
    String? body,
    DateTime? receivedAt,
    SmsParseStatus? parseStatus,
    Value<int?> matchedPatternId = const Value.absent(),
  }) => RawSm(
    id: id ?? this.id,
    sender: sender ?? this.sender,
    body: body ?? this.body,
    receivedAt: receivedAt ?? this.receivedAt,
    parseStatus: parseStatus ?? this.parseStatus,
    matchedPatternId: matchedPatternId.present
        ? matchedPatternId.value
        : this.matchedPatternId,
  );
  RawSm copyWithCompanion(RawSmsCompanion data) {
    return RawSm(
      id: data.id.present ? data.id.value : this.id,
      sender: data.sender.present ? data.sender.value : this.sender,
      body: data.body.present ? data.body.value : this.body,
      receivedAt: data.receivedAt.present
          ? data.receivedAt.value
          : this.receivedAt,
      parseStatus: data.parseStatus.present
          ? data.parseStatus.value
          : this.parseStatus,
      matchedPatternId: data.matchedPatternId.present
          ? data.matchedPatternId.value
          : this.matchedPatternId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawSm(')
          ..write('id: $id, ')
          ..write('sender: $sender, ')
          ..write('body: $body, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('parseStatus: $parseStatus, ')
          ..write('matchedPatternId: $matchedPatternId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sender, body, receivedAt, parseStatus, matchedPatternId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawSm &&
          other.id == this.id &&
          other.sender == this.sender &&
          other.body == this.body &&
          other.receivedAt == this.receivedAt &&
          other.parseStatus == this.parseStatus &&
          other.matchedPatternId == this.matchedPatternId);
}

class RawSmsCompanion extends UpdateCompanion<RawSm> {
  final Value<int> id;
  final Value<String> sender;
  final Value<String> body;
  final Value<DateTime> receivedAt;
  final Value<SmsParseStatus> parseStatus;
  final Value<int?> matchedPatternId;
  const RawSmsCompanion({
    this.id = const Value.absent(),
    this.sender = const Value.absent(),
    this.body = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.parseStatus = const Value.absent(),
    this.matchedPatternId = const Value.absent(),
  });
  RawSmsCompanion.insert({
    this.id = const Value.absent(),
    required String sender,
    required String body,
    required DateTime receivedAt,
    required SmsParseStatus parseStatus,
    this.matchedPatternId = const Value.absent(),
  }) : sender = Value(sender),
       body = Value(body),
       receivedAt = Value(receivedAt),
       parseStatus = Value(parseStatus);
  static Insertable<RawSm> custom({
    Expression<int>? id,
    Expression<String>? sender,
    Expression<String>? body,
    Expression<DateTime>? receivedAt,
    Expression<int>? parseStatus,
    Expression<int>? matchedPatternId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sender != null) 'sender': sender,
      if (body != null) 'body': body,
      if (receivedAt != null) 'received_at': receivedAt,
      if (parseStatus != null) 'parse_status': parseStatus,
      if (matchedPatternId != null) 'matched_pattern_id': matchedPatternId,
    });
  }

  RawSmsCompanion copyWith({
    Value<int>? id,
    Value<String>? sender,
    Value<String>? body,
    Value<DateTime>? receivedAt,
    Value<SmsParseStatus>? parseStatus,
    Value<int?>? matchedPatternId,
  }) {
    return RawSmsCompanion(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      body: body ?? this.body,
      receivedAt: receivedAt ?? this.receivedAt,
      parseStatus: parseStatus ?? this.parseStatus,
      matchedPatternId: matchedPatternId ?? this.matchedPatternId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sender.present) {
      map['sender'] = Variable<String>(sender.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (receivedAt.present) {
      map['received_at'] = Variable<DateTime>(receivedAt.value);
    }
    if (parseStatus.present) {
      map['parse_status'] = Variable<int>(
        $RawSmsTable.$converterparseStatus.toSql(parseStatus.value),
      );
    }
    if (matchedPatternId.present) {
      map['matched_pattern_id'] = Variable<int>(matchedPatternId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RawSmsCompanion(')
          ..write('id: $id, ')
          ..write('sender: $sender, ')
          ..write('body: $body, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('parseStatus: $parseStatus, ')
          ..write('matchedPatternId: $matchedPatternId')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id) ON DELETE SET NULL',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TxnType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<TxnType>($TransactionsTable.$convertertype);
  static const VerificationMeta _amountRialMeta = const VerificationMeta(
    'amountRial',
  );
  @override
  late final GeneratedColumn<int> amountRial = GeneratedColumn<int>(
    'amount_rial',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jYearMeta = const VerificationMeta('jYear');
  @override
  late final GeneratedColumn<int> jYear = GeneratedColumn<int>(
    'j_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jMonthMeta = const VerificationMeta('jMonth');
  @override
  late final GeneratedColumn<int> jMonth = GeneratedColumn<int>(
    'j_month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TxnStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<TxnStatus>($TransactionsTable.$converterstatus);
  @override
  late final GeneratedColumnWithTypeConverter<TxnSource, int> source =
      GeneratedColumn<int>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<TxnSource>($TransactionsTable.$convertersource);
  static const VerificationMeta _rawSmsIdMeta = const VerificationMeta(
    'rawSmsId',
  );
  @override
  late final GeneratedColumn<int> rawSmsId = GeneratedColumn<int>(
    'raw_sms_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES raw_sms (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _balanceAfterRialMeta = const VerificationMeta(
    'balanceAfterRial',
  );
  @override
  late final GeneratedColumn<int> balanceAfterRial = GeneratedColumn<int>(
    'balance_after_rial',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confirmedAtMeta = const VerificationMeta(
    'confirmedAt',
  );
  @override
  late final GeneratedColumn<DateTime> confirmedAt = GeneratedColumn<DateTime>(
    'confirmed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    categoryId,
    type,
    amountRial,
    occurredAt,
    jYear,
    jMonth,
    note,
    status,
    source,
    rawSmsId,
    balanceAfterRial,
    confirmedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('amount_rial')) {
      context.handle(
        _amountRialMeta,
        amountRial.isAcceptableOrUnknown(data['amount_rial']!, _amountRialMeta),
      );
    } else if (isInserting) {
      context.missing(_amountRialMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('j_year')) {
      context.handle(
        _jYearMeta,
        jYear.isAcceptableOrUnknown(data['j_year']!, _jYearMeta),
      );
    } else if (isInserting) {
      context.missing(_jYearMeta);
    }
    if (data.containsKey('j_month')) {
      context.handle(
        _jMonthMeta,
        jMonth.isAcceptableOrUnknown(data['j_month']!, _jMonthMeta),
      );
    } else if (isInserting) {
      context.missing(_jMonthMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('raw_sms_id')) {
      context.handle(
        _rawSmsIdMeta,
        rawSmsId.isAcceptableOrUnknown(data['raw_sms_id']!, _rawSmsIdMeta),
      );
    }
    if (data.containsKey('balance_after_rial')) {
      context.handle(
        _balanceAfterRialMeta,
        balanceAfterRial.isAcceptableOrUnknown(
          data['balance_after_rial']!,
          _balanceAfterRialMeta,
        ),
      );
    }
    if (data.containsKey('confirmed_at')) {
      context.handle(
        _confirmedAtMeta,
        confirmedAt.isAcceptableOrUnknown(
          data['confirmed_at']!,
          _confirmedAtMeta,
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      type: $TransactionsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      amountRial: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_rial'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      jYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}j_year'],
      )!,
      jMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}j_month'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      status: $TransactionsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      source: $TransactionsTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}source'],
        )!,
      ),
      rawSmsId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}raw_sms_id'],
      ),
      balanceAfterRial: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}balance_after_rial'],
      ),
      confirmedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}confirmed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TxnType, int, int> $convertertype =
      const EnumIndexConverter<TxnType>(TxnType.values);
  static JsonTypeConverter2<TxnStatus, int, int> $converterstatus =
      const EnumIndexConverter<TxnStatus>(TxnStatus.values);
  static JsonTypeConverter2<TxnSource, int, int> $convertersource =
      const EnumIndexConverter<TxnSource>(TxnSource.values);
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final int? accountId;
  final int? categoryId;
  final TxnType type;
  final int amountRial;
  final DateTime occurredAt;

  /// Denormalized Jalali year/month of [occurredAt] so monthly grouping
  /// is a plain indexed GROUP BY instead of a per-row conversion.
  final int jYear;
  final int jMonth;
  final String? note;
  final TxnStatus status;
  final TxnSource source;
  final int? rawSmsId;

  /// Balance the bank reported right after this transaction.
  final int? balanceAfterRial;
  final DateTime? confirmedAt;
  final DateTime createdAt;
  const Transaction({
    required this.id,
    this.accountId,
    this.categoryId,
    required this.type,
    required this.amountRial,
    required this.occurredAt,
    required this.jYear,
    required this.jMonth,
    this.note,
    required this.status,
    required this.source,
    this.rawSmsId,
    this.balanceAfterRial,
    this.confirmedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<int>(accountId);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    {
      map['type'] = Variable<int>(
        $TransactionsTable.$convertertype.toSql(type),
      );
    }
    map['amount_rial'] = Variable<int>(amountRial);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    map['j_year'] = Variable<int>(jYear);
    map['j_month'] = Variable<int>(jMonth);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    {
      map['status'] = Variable<int>(
        $TransactionsTable.$converterstatus.toSql(status),
      );
    }
    {
      map['source'] = Variable<int>(
        $TransactionsTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || rawSmsId != null) {
      map['raw_sms_id'] = Variable<int>(rawSmsId);
    }
    if (!nullToAbsent || balanceAfterRial != null) {
      map['balance_after_rial'] = Variable<int>(balanceAfterRial);
    }
    if (!nullToAbsent || confirmedAt != null) {
      map['confirmed_at'] = Variable<DateTime>(confirmedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      type: Value(type),
      amountRial: Value(amountRial),
      occurredAt: Value(occurredAt),
      jYear: Value(jYear),
      jMonth: Value(jMonth),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      status: Value(status),
      source: Value(source),
      rawSmsId: rawSmsId == null && nullToAbsent
          ? const Value.absent()
          : Value(rawSmsId),
      balanceAfterRial: balanceAfterRial == null && nullToAbsent
          ? const Value.absent()
          : Value(balanceAfterRial),
      confirmedAt: confirmedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(confirmedAt),
      createdAt: Value(createdAt),
    );
  }

  factory Transaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      accountId: serializer.fromJson<int?>(json['accountId']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      type: $TransactionsTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      amountRial: serializer.fromJson<int>(json['amountRial']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      jYear: serializer.fromJson<int>(json['jYear']),
      jMonth: serializer.fromJson<int>(json['jMonth']),
      note: serializer.fromJson<String?>(json['note']),
      status: $TransactionsTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      source: $TransactionsTable.$convertersource.fromJson(
        serializer.fromJson<int>(json['source']),
      ),
      rawSmsId: serializer.fromJson<int?>(json['rawSmsId']),
      balanceAfterRial: serializer.fromJson<int?>(json['balanceAfterRial']),
      confirmedAt: serializer.fromJson<DateTime?>(json['confirmedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accountId': serializer.toJson<int?>(accountId),
      'categoryId': serializer.toJson<int?>(categoryId),
      'type': serializer.toJson<int>(
        $TransactionsTable.$convertertype.toJson(type),
      ),
      'amountRial': serializer.toJson<int>(amountRial),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'jYear': serializer.toJson<int>(jYear),
      'jMonth': serializer.toJson<int>(jMonth),
      'note': serializer.toJson<String?>(note),
      'status': serializer.toJson<int>(
        $TransactionsTable.$converterstatus.toJson(status),
      ),
      'source': serializer.toJson<int>(
        $TransactionsTable.$convertersource.toJson(source),
      ),
      'rawSmsId': serializer.toJson<int?>(rawSmsId),
      'balanceAfterRial': serializer.toJson<int?>(balanceAfterRial),
      'confirmedAt': serializer.toJson<DateTime?>(confirmedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Transaction copyWith({
    int? id,
    Value<int?> accountId = const Value.absent(),
    Value<int?> categoryId = const Value.absent(),
    TxnType? type,
    int? amountRial,
    DateTime? occurredAt,
    int? jYear,
    int? jMonth,
    Value<String?> note = const Value.absent(),
    TxnStatus? status,
    TxnSource? source,
    Value<int?> rawSmsId = const Value.absent(),
    Value<int?> balanceAfterRial = const Value.absent(),
    Value<DateTime?> confirmedAt = const Value.absent(),
    DateTime? createdAt,
  }) => Transaction(
    id: id ?? this.id,
    accountId: accountId.present ? accountId.value : this.accountId,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    type: type ?? this.type,
    amountRial: amountRial ?? this.amountRial,
    occurredAt: occurredAt ?? this.occurredAt,
    jYear: jYear ?? this.jYear,
    jMonth: jMonth ?? this.jMonth,
    note: note.present ? note.value : this.note,
    status: status ?? this.status,
    source: source ?? this.source,
    rawSmsId: rawSmsId.present ? rawSmsId.value : this.rawSmsId,
    balanceAfterRial: balanceAfterRial.present
        ? balanceAfterRial.value
        : this.balanceAfterRial,
    confirmedAt: confirmedAt.present ? confirmedAt.value : this.confirmedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      type: data.type.present ? data.type.value : this.type,
      amountRial: data.amountRial.present
          ? data.amountRial.value
          : this.amountRial,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      jYear: data.jYear.present ? data.jYear.value : this.jYear,
      jMonth: data.jMonth.present ? data.jMonth.value : this.jMonth,
      note: data.note.present ? data.note.value : this.note,
      status: data.status.present ? data.status.value : this.status,
      source: data.source.present ? data.source.value : this.source,
      rawSmsId: data.rawSmsId.present ? data.rawSmsId.value : this.rawSmsId,
      balanceAfterRial: data.balanceAfterRial.present
          ? data.balanceAfterRial.value
          : this.balanceAfterRial,
      confirmedAt: data.confirmedAt.present
          ? data.confirmedAt.value
          : this.confirmedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('type: $type, ')
          ..write('amountRial: $amountRial, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('jYear: $jYear, ')
          ..write('jMonth: $jMonth, ')
          ..write('note: $note, ')
          ..write('status: $status, ')
          ..write('source: $source, ')
          ..write('rawSmsId: $rawSmsId, ')
          ..write('balanceAfterRial: $balanceAfterRial, ')
          ..write('confirmedAt: $confirmedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    categoryId,
    type,
    amountRial,
    occurredAt,
    jYear,
    jMonth,
    note,
    status,
    source,
    rawSmsId,
    balanceAfterRial,
    confirmedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.categoryId == this.categoryId &&
          other.type == this.type &&
          other.amountRial == this.amountRial &&
          other.occurredAt == this.occurredAt &&
          other.jYear == this.jYear &&
          other.jMonth == this.jMonth &&
          other.note == this.note &&
          other.status == this.status &&
          other.source == this.source &&
          other.rawSmsId == this.rawSmsId &&
          other.balanceAfterRial == this.balanceAfterRial &&
          other.confirmedAt == this.confirmedAt &&
          other.createdAt == this.createdAt);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<int?> accountId;
  final Value<int?> categoryId;
  final Value<TxnType> type;
  final Value<int> amountRial;
  final Value<DateTime> occurredAt;
  final Value<int> jYear;
  final Value<int> jMonth;
  final Value<String?> note;
  final Value<TxnStatus> status;
  final Value<TxnSource> source;
  final Value<int?> rawSmsId;
  final Value<int?> balanceAfterRial;
  final Value<DateTime?> confirmedAt;
  final Value<DateTime> createdAt;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.type = const Value.absent(),
    this.amountRial = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.jYear = const Value.absent(),
    this.jMonth = const Value.absent(),
    this.note = const Value.absent(),
    this.status = const Value.absent(),
    this.source = const Value.absent(),
    this.rawSmsId = const Value.absent(),
    this.balanceAfterRial = const Value.absent(),
    this.confirmedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.categoryId = const Value.absent(),
    required TxnType type,
    required int amountRial,
    required DateTime occurredAt,
    required int jYear,
    required int jMonth,
    this.note = const Value.absent(),
    required TxnStatus status,
    required TxnSource source,
    this.rawSmsId = const Value.absent(),
    this.balanceAfterRial = const Value.absent(),
    this.confirmedAt = const Value.absent(),
    required DateTime createdAt,
  }) : type = Value(type),
       amountRial = Value(amountRial),
       occurredAt = Value(occurredAt),
       jYear = Value(jYear),
       jMonth = Value(jMonth),
       status = Value(status),
       source = Value(source),
       createdAt = Value(createdAt);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<int>? accountId,
    Expression<int>? categoryId,
    Expression<int>? type,
    Expression<int>? amountRial,
    Expression<DateTime>? occurredAt,
    Expression<int>? jYear,
    Expression<int>? jMonth,
    Expression<String>? note,
    Expression<int>? status,
    Expression<int>? source,
    Expression<int>? rawSmsId,
    Expression<int>? balanceAfterRial,
    Expression<DateTime>? confirmedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (categoryId != null) 'category_id': categoryId,
      if (type != null) 'type': type,
      if (amountRial != null) 'amount_rial': amountRial,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (jYear != null) 'j_year': jYear,
      if (jMonth != null) 'j_month': jMonth,
      if (note != null) 'note': note,
      if (status != null) 'status': status,
      if (source != null) 'source': source,
      if (rawSmsId != null) 'raw_sms_id': rawSmsId,
      if (balanceAfterRial != null) 'balance_after_rial': balanceAfterRial,
      if (confirmedAt != null) 'confirmed_at': confirmedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TransactionsCompanion copyWith({
    Value<int>? id,
    Value<int?>? accountId,
    Value<int?>? categoryId,
    Value<TxnType>? type,
    Value<int>? amountRial,
    Value<DateTime>? occurredAt,
    Value<int>? jYear,
    Value<int>? jMonth,
    Value<String?>? note,
    Value<TxnStatus>? status,
    Value<TxnSource>? source,
    Value<int?>? rawSmsId,
    Value<int?>? balanceAfterRial,
    Value<DateTime?>? confirmedAt,
    Value<DateTime>? createdAt,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      type: type ?? this.type,
      amountRial: amountRial ?? this.amountRial,
      occurredAt: occurredAt ?? this.occurredAt,
      jYear: jYear ?? this.jYear,
      jMonth: jMonth ?? this.jMonth,
      note: note ?? this.note,
      status: status ?? this.status,
      source: source ?? this.source,
      rawSmsId: rawSmsId ?? this.rawSmsId,
      balanceAfterRial: balanceAfterRial ?? this.balanceAfterRial,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $TransactionsTable.$convertertype.toSql(type.value),
      );
    }
    if (amountRial.present) {
      map['amount_rial'] = Variable<int>(amountRial.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (jYear.present) {
      map['j_year'] = Variable<int>(jYear.value);
    }
    if (jMonth.present) {
      map['j_month'] = Variable<int>(jMonth.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $TransactionsTable.$converterstatus.toSql(status.value),
      );
    }
    if (source.present) {
      map['source'] = Variable<int>(
        $TransactionsTable.$convertersource.toSql(source.value),
      );
    }
    if (rawSmsId.present) {
      map['raw_sms_id'] = Variable<int>(rawSmsId.value);
    }
    if (balanceAfterRial.present) {
      map['balance_after_rial'] = Variable<int>(balanceAfterRial.value);
    }
    if (confirmedAt.present) {
      map['confirmed_at'] = Variable<DateTime>(confirmedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('type: $type, ')
          ..write('amountRial: $amountRial, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('jYear: $jYear, ')
          ..write('jMonth: $jMonth, ')
          ..write('note: $note, ')
          ..write('status: $status, ')
          ..write('source: $source, ')
          ..write('rawSmsId: $rawSmsId, ')
          ..write('balanceAfterRial: $balanceAfterRial, ')
          ..write('confirmedAt: $confirmedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SmsPatternsTable extends SmsPatterns
    with TableInfo<$SmsPatternsTable, SmsPattern> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmsPatternsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bankNameMeta = const VerificationMeta(
    'bankName',
  );
  @override
  late final GeneratedColumn<String> bankName = GeneratedColumn<String>(
    'bank_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderNumbersMeta = const VerificationMeta(
    'senderNumbers',
  );
  @override
  late final GeneratedColumn<String> senderNumbers = GeneratedColumn<String>(
    'sender_numbers',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _depositKeywordsMeta = const VerificationMeta(
    'depositKeywords',
  );
  @override
  late final GeneratedColumn<String> depositKeywords = GeneratedColumn<String>(
    'deposit_keywords',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _withdrawalKeywordsMeta =
      const VerificationMeta('withdrawalKeywords');
  @override
  late final GeneratedColumn<String> withdrawalKeywords =
      GeneratedColumn<String>(
        'withdrawal_keywords',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _amountRegexMeta = const VerificationMeta(
    'amountRegex',
  );
  @override
  late final GeneratedColumn<String> amountRegex = GeneratedColumn<String>(
    'amount_regex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _balanceRegexMeta = const VerificationMeta(
    'balanceRegex',
  );
  @override
  late final GeneratedColumn<String> balanceRegex = GeneratedColumn<String>(
    'balance_regex',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accountRefRegexMeta = const VerificationMeta(
    'accountRefRegex',
  );
  @override
  late final GeneratedColumn<String> accountRefRegex = GeneratedColumn<String>(
    'account_ref_regex',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SmsAmountUnit, int> amountUnit =
      GeneratedColumn<int>(
        'amount_unit',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<SmsAmountUnit>($SmsPatternsTable.$converteramountUnit);
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(100),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bankName,
    senderNumbers,
    depositKeywords,
    withdrawalKeywords,
    amountRegex,
    balanceRegex,
    accountRefRegex,
    amountUnit,
    priority,
    isEnabled,
    isBuiltIn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sms_patterns';
  @override
  VerificationContext validateIntegrity(
    Insertable<SmsPattern> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bank_name')) {
      context.handle(
        _bankNameMeta,
        bankName.isAcceptableOrUnknown(data['bank_name']!, _bankNameMeta),
      );
    } else if (isInserting) {
      context.missing(_bankNameMeta);
    }
    if (data.containsKey('sender_numbers')) {
      context.handle(
        _senderNumbersMeta,
        senderNumbers.isAcceptableOrUnknown(
          data['sender_numbers']!,
          _senderNumbersMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_senderNumbersMeta);
    }
    if (data.containsKey('deposit_keywords')) {
      context.handle(
        _depositKeywordsMeta,
        depositKeywords.isAcceptableOrUnknown(
          data['deposit_keywords']!,
          _depositKeywordsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_depositKeywordsMeta);
    }
    if (data.containsKey('withdrawal_keywords')) {
      context.handle(
        _withdrawalKeywordsMeta,
        withdrawalKeywords.isAcceptableOrUnknown(
          data['withdrawal_keywords']!,
          _withdrawalKeywordsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_withdrawalKeywordsMeta);
    }
    if (data.containsKey('amount_regex')) {
      context.handle(
        _amountRegexMeta,
        amountRegex.isAcceptableOrUnknown(
          data['amount_regex']!,
          _amountRegexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountRegexMeta);
    }
    if (data.containsKey('balance_regex')) {
      context.handle(
        _balanceRegexMeta,
        balanceRegex.isAcceptableOrUnknown(
          data['balance_regex']!,
          _balanceRegexMeta,
        ),
      );
    }
    if (data.containsKey('account_ref_regex')) {
      context.handle(
        _accountRefRegexMeta,
        accountRefRegex.isAcceptableOrUnknown(
          data['account_ref_regex']!,
          _accountRefRegexMeta,
        ),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SmsPattern map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmsPattern(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bankName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_name'],
      )!,
      senderNumbers: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_numbers'],
      )!,
      depositKeywords: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deposit_keywords'],
      )!,
      withdrawalKeywords: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}withdrawal_keywords'],
      )!,
      amountRegex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}amount_regex'],
      )!,
      balanceRegex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}balance_regex'],
      ),
      accountRefRegex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_ref_regex'],
      ),
      amountUnit: $SmsPatternsTable.$converteramountUnit.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}amount_unit'],
        )!,
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
    );
  }

  @override
  $SmsPatternsTable createAlias(String alias) {
    return $SmsPatternsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SmsAmountUnit, int, int> $converteramountUnit =
      const EnumIndexConverter<SmsAmountUnit>(SmsAmountUnit.values);
}

class SmsPattern extends DataClass implements Insertable<SmsPattern> {
  final int id;
  final String bankName;

  /// JSON array of sender ids/numbers this bank sends from.
  final String senderNumbers;

  /// JSON arrays of keywords that mark the transaction direction.
  final String depositKeywords;
  final String withdrawalKeywords;
  final String amountRegex;
  final String? balanceRegex;
  final String? accountRefRegex;
  final SmsAmountUnit amountUnit;
  final int priority;
  final bool isEnabled;
  final bool isBuiltIn;
  const SmsPattern({
    required this.id,
    required this.bankName,
    required this.senderNumbers,
    required this.depositKeywords,
    required this.withdrawalKeywords,
    required this.amountRegex,
    this.balanceRegex,
    this.accountRefRegex,
    required this.amountUnit,
    required this.priority,
    required this.isEnabled,
    required this.isBuiltIn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bank_name'] = Variable<String>(bankName);
    map['sender_numbers'] = Variable<String>(senderNumbers);
    map['deposit_keywords'] = Variable<String>(depositKeywords);
    map['withdrawal_keywords'] = Variable<String>(withdrawalKeywords);
    map['amount_regex'] = Variable<String>(amountRegex);
    if (!nullToAbsent || balanceRegex != null) {
      map['balance_regex'] = Variable<String>(balanceRegex);
    }
    if (!nullToAbsent || accountRefRegex != null) {
      map['account_ref_regex'] = Variable<String>(accountRefRegex);
    }
    {
      map['amount_unit'] = Variable<int>(
        $SmsPatternsTable.$converteramountUnit.toSql(amountUnit),
      );
    }
    map['priority'] = Variable<int>(priority);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    return map;
  }

  SmsPatternsCompanion toCompanion(bool nullToAbsent) {
    return SmsPatternsCompanion(
      id: Value(id),
      bankName: Value(bankName),
      senderNumbers: Value(senderNumbers),
      depositKeywords: Value(depositKeywords),
      withdrawalKeywords: Value(withdrawalKeywords),
      amountRegex: Value(amountRegex),
      balanceRegex: balanceRegex == null && nullToAbsent
          ? const Value.absent()
          : Value(balanceRegex),
      accountRefRegex: accountRefRegex == null && nullToAbsent
          ? const Value.absent()
          : Value(accountRefRegex),
      amountUnit: Value(amountUnit),
      priority: Value(priority),
      isEnabled: Value(isEnabled),
      isBuiltIn: Value(isBuiltIn),
    );
  }

  factory SmsPattern.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SmsPattern(
      id: serializer.fromJson<int>(json['id']),
      bankName: serializer.fromJson<String>(json['bankName']),
      senderNumbers: serializer.fromJson<String>(json['senderNumbers']),
      depositKeywords: serializer.fromJson<String>(json['depositKeywords']),
      withdrawalKeywords: serializer.fromJson<String>(
        json['withdrawalKeywords'],
      ),
      amountRegex: serializer.fromJson<String>(json['amountRegex']),
      balanceRegex: serializer.fromJson<String?>(json['balanceRegex']),
      accountRefRegex: serializer.fromJson<String?>(json['accountRefRegex']),
      amountUnit: $SmsPatternsTable.$converteramountUnit.fromJson(
        serializer.fromJson<int>(json['amountUnit']),
      ),
      priority: serializer.fromJson<int>(json['priority']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bankName': serializer.toJson<String>(bankName),
      'senderNumbers': serializer.toJson<String>(senderNumbers),
      'depositKeywords': serializer.toJson<String>(depositKeywords),
      'withdrawalKeywords': serializer.toJson<String>(withdrawalKeywords),
      'amountRegex': serializer.toJson<String>(amountRegex),
      'balanceRegex': serializer.toJson<String?>(balanceRegex),
      'accountRefRegex': serializer.toJson<String?>(accountRefRegex),
      'amountUnit': serializer.toJson<int>(
        $SmsPatternsTable.$converteramountUnit.toJson(amountUnit),
      ),
      'priority': serializer.toJson<int>(priority),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
    };
  }

  SmsPattern copyWith({
    int? id,
    String? bankName,
    String? senderNumbers,
    String? depositKeywords,
    String? withdrawalKeywords,
    String? amountRegex,
    Value<String?> balanceRegex = const Value.absent(),
    Value<String?> accountRefRegex = const Value.absent(),
    SmsAmountUnit? amountUnit,
    int? priority,
    bool? isEnabled,
    bool? isBuiltIn,
  }) => SmsPattern(
    id: id ?? this.id,
    bankName: bankName ?? this.bankName,
    senderNumbers: senderNumbers ?? this.senderNumbers,
    depositKeywords: depositKeywords ?? this.depositKeywords,
    withdrawalKeywords: withdrawalKeywords ?? this.withdrawalKeywords,
    amountRegex: amountRegex ?? this.amountRegex,
    balanceRegex: balanceRegex.present ? balanceRegex.value : this.balanceRegex,
    accountRefRegex: accountRefRegex.present
        ? accountRefRegex.value
        : this.accountRefRegex,
    amountUnit: amountUnit ?? this.amountUnit,
    priority: priority ?? this.priority,
    isEnabled: isEnabled ?? this.isEnabled,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
  );
  SmsPattern copyWithCompanion(SmsPatternsCompanion data) {
    return SmsPattern(
      id: data.id.present ? data.id.value : this.id,
      bankName: data.bankName.present ? data.bankName.value : this.bankName,
      senderNumbers: data.senderNumbers.present
          ? data.senderNumbers.value
          : this.senderNumbers,
      depositKeywords: data.depositKeywords.present
          ? data.depositKeywords.value
          : this.depositKeywords,
      withdrawalKeywords: data.withdrawalKeywords.present
          ? data.withdrawalKeywords.value
          : this.withdrawalKeywords,
      amountRegex: data.amountRegex.present
          ? data.amountRegex.value
          : this.amountRegex,
      balanceRegex: data.balanceRegex.present
          ? data.balanceRegex.value
          : this.balanceRegex,
      accountRefRegex: data.accountRefRegex.present
          ? data.accountRefRegex.value
          : this.accountRefRegex,
      amountUnit: data.amountUnit.present
          ? data.amountUnit.value
          : this.amountUnit,
      priority: data.priority.present ? data.priority.value : this.priority,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SmsPattern(')
          ..write('id: $id, ')
          ..write('bankName: $bankName, ')
          ..write('senderNumbers: $senderNumbers, ')
          ..write('depositKeywords: $depositKeywords, ')
          ..write('withdrawalKeywords: $withdrawalKeywords, ')
          ..write('amountRegex: $amountRegex, ')
          ..write('balanceRegex: $balanceRegex, ')
          ..write('accountRefRegex: $accountRefRegex, ')
          ..write('amountUnit: $amountUnit, ')
          ..write('priority: $priority, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('isBuiltIn: $isBuiltIn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bankName,
    senderNumbers,
    depositKeywords,
    withdrawalKeywords,
    amountRegex,
    balanceRegex,
    accountRefRegex,
    amountUnit,
    priority,
    isEnabled,
    isBuiltIn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SmsPattern &&
          other.id == this.id &&
          other.bankName == this.bankName &&
          other.senderNumbers == this.senderNumbers &&
          other.depositKeywords == this.depositKeywords &&
          other.withdrawalKeywords == this.withdrawalKeywords &&
          other.amountRegex == this.amountRegex &&
          other.balanceRegex == this.balanceRegex &&
          other.accountRefRegex == this.accountRefRegex &&
          other.amountUnit == this.amountUnit &&
          other.priority == this.priority &&
          other.isEnabled == this.isEnabled &&
          other.isBuiltIn == this.isBuiltIn);
}

class SmsPatternsCompanion extends UpdateCompanion<SmsPattern> {
  final Value<int> id;
  final Value<String> bankName;
  final Value<String> senderNumbers;
  final Value<String> depositKeywords;
  final Value<String> withdrawalKeywords;
  final Value<String> amountRegex;
  final Value<String?> balanceRegex;
  final Value<String?> accountRefRegex;
  final Value<SmsAmountUnit> amountUnit;
  final Value<int> priority;
  final Value<bool> isEnabled;
  final Value<bool> isBuiltIn;
  const SmsPatternsCompanion({
    this.id = const Value.absent(),
    this.bankName = const Value.absent(),
    this.senderNumbers = const Value.absent(),
    this.depositKeywords = const Value.absent(),
    this.withdrawalKeywords = const Value.absent(),
    this.amountRegex = const Value.absent(),
    this.balanceRegex = const Value.absent(),
    this.accountRefRegex = const Value.absent(),
    this.amountUnit = const Value.absent(),
    this.priority = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
  });
  SmsPatternsCompanion.insert({
    this.id = const Value.absent(),
    required String bankName,
    required String senderNumbers,
    required String depositKeywords,
    required String withdrawalKeywords,
    required String amountRegex,
    this.balanceRegex = const Value.absent(),
    this.accountRefRegex = const Value.absent(),
    required SmsAmountUnit amountUnit,
    this.priority = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
  }) : bankName = Value(bankName),
       senderNumbers = Value(senderNumbers),
       depositKeywords = Value(depositKeywords),
       withdrawalKeywords = Value(withdrawalKeywords),
       amountRegex = Value(amountRegex),
       amountUnit = Value(amountUnit);
  static Insertable<SmsPattern> custom({
    Expression<int>? id,
    Expression<String>? bankName,
    Expression<String>? senderNumbers,
    Expression<String>? depositKeywords,
    Expression<String>? withdrawalKeywords,
    Expression<String>? amountRegex,
    Expression<String>? balanceRegex,
    Expression<String>? accountRefRegex,
    Expression<int>? amountUnit,
    Expression<int>? priority,
    Expression<bool>? isEnabled,
    Expression<bool>? isBuiltIn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bankName != null) 'bank_name': bankName,
      if (senderNumbers != null) 'sender_numbers': senderNumbers,
      if (depositKeywords != null) 'deposit_keywords': depositKeywords,
      if (withdrawalKeywords != null) 'withdrawal_keywords': withdrawalKeywords,
      if (amountRegex != null) 'amount_regex': amountRegex,
      if (balanceRegex != null) 'balance_regex': balanceRegex,
      if (accountRefRegex != null) 'account_ref_regex': accountRefRegex,
      if (amountUnit != null) 'amount_unit': amountUnit,
      if (priority != null) 'priority': priority,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
    });
  }

  SmsPatternsCompanion copyWith({
    Value<int>? id,
    Value<String>? bankName,
    Value<String>? senderNumbers,
    Value<String>? depositKeywords,
    Value<String>? withdrawalKeywords,
    Value<String>? amountRegex,
    Value<String?>? balanceRegex,
    Value<String?>? accountRefRegex,
    Value<SmsAmountUnit>? amountUnit,
    Value<int>? priority,
    Value<bool>? isEnabled,
    Value<bool>? isBuiltIn,
  }) {
    return SmsPatternsCompanion(
      id: id ?? this.id,
      bankName: bankName ?? this.bankName,
      senderNumbers: senderNumbers ?? this.senderNumbers,
      depositKeywords: depositKeywords ?? this.depositKeywords,
      withdrawalKeywords: withdrawalKeywords ?? this.withdrawalKeywords,
      amountRegex: amountRegex ?? this.amountRegex,
      balanceRegex: balanceRegex ?? this.balanceRegex,
      accountRefRegex: accountRefRegex ?? this.accountRefRegex,
      amountUnit: amountUnit ?? this.amountUnit,
      priority: priority ?? this.priority,
      isEnabled: isEnabled ?? this.isEnabled,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bankName.present) {
      map['bank_name'] = Variable<String>(bankName.value);
    }
    if (senderNumbers.present) {
      map['sender_numbers'] = Variable<String>(senderNumbers.value);
    }
    if (depositKeywords.present) {
      map['deposit_keywords'] = Variable<String>(depositKeywords.value);
    }
    if (withdrawalKeywords.present) {
      map['withdrawal_keywords'] = Variable<String>(withdrawalKeywords.value);
    }
    if (amountRegex.present) {
      map['amount_regex'] = Variable<String>(amountRegex.value);
    }
    if (balanceRegex.present) {
      map['balance_regex'] = Variable<String>(balanceRegex.value);
    }
    if (accountRefRegex.present) {
      map['account_ref_regex'] = Variable<String>(accountRefRegex.value);
    }
    if (amountUnit.present) {
      map['amount_unit'] = Variable<int>(
        $SmsPatternsTable.$converteramountUnit.toSql(amountUnit.value),
      );
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SmsPatternsCompanion(')
          ..write('id: $id, ')
          ..write('bankName: $bankName, ')
          ..write('senderNumbers: $senderNumbers, ')
          ..write('depositKeywords: $depositKeywords, ')
          ..write('withdrawalKeywords: $withdrawalKeywords, ')
          ..write('amountRegex: $amountRegex, ')
          ..write('balanceRegex: $balanceRegex, ')
          ..write('accountRefRegex: $accountRefRegex, ')
          ..write('amountUnit: $amountUnit, ')
          ..write('priority: $priority, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('isBuiltIn: $isBuiltIn')
          ..write(')'))
        .toString();
  }
}

class $RecurringIncomesTable extends RecurringIncomes
    with TableInfo<$RecurringIncomesTable, RecurringIncome> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurringIncomesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountRialMeta = const VerificationMeta(
    'amountRial',
  );
  @override
  late final GeneratedColumn<int> amountRial = GeneratedColumn<int>(
    'amount_rial',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _jDayMeta = const VerificationMeta('jDay');
  @override
  late final GeneratedColumn<int> jDay = GeneratedColumn<int>(
    'j_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startJYearMeta = const VerificationMeta(
    'startJYear',
  );
  @override
  late final GeneratedColumn<int> startJYear = GeneratedColumn<int>(
    'start_j_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startJMonthMeta = const VerificationMeta(
    'startJMonth',
  );
  @override
  late final GeneratedColumn<int> startJMonth = GeneratedColumn<int>(
    'start_j_month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endJYearMeta = const VerificationMeta(
    'endJYear',
  );
  @override
  late final GeneratedColumn<int> endJYear = GeneratedColumn<int>(
    'end_j_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endJMonthMeta = const VerificationMeta(
    'endJMonth',
  );
  @override
  late final GeneratedColumn<int> endJMonth = GeneratedColumn<int>(
    'end_j_month',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    amountRial,
    categoryId,
    accountId,
    jDay,
    startJYear,
    startJMonth,
    endJYear,
    endJMonth,
    note,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurring_incomes';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecurringIncome> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('amount_rial')) {
      context.handle(
        _amountRialMeta,
        amountRial.isAcceptableOrUnknown(data['amount_rial']!, _amountRialMeta),
      );
    } else if (isInserting) {
      context.missing(_amountRialMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    if (data.containsKey('j_day')) {
      context.handle(
        _jDayMeta,
        jDay.isAcceptableOrUnknown(data['j_day']!, _jDayMeta),
      );
    } else if (isInserting) {
      context.missing(_jDayMeta);
    }
    if (data.containsKey('start_j_year')) {
      context.handle(
        _startJYearMeta,
        startJYear.isAcceptableOrUnknown(
          data['start_j_year']!,
          _startJYearMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startJYearMeta);
    }
    if (data.containsKey('start_j_month')) {
      context.handle(
        _startJMonthMeta,
        startJMonth.isAcceptableOrUnknown(
          data['start_j_month']!,
          _startJMonthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startJMonthMeta);
    }
    if (data.containsKey('end_j_year')) {
      context.handle(
        _endJYearMeta,
        endJYear.isAcceptableOrUnknown(data['end_j_year']!, _endJYearMeta),
      );
    }
    if (data.containsKey('end_j_month')) {
      context.handle(
        _endJMonthMeta,
        endJMonth.isAcceptableOrUnknown(data['end_j_month']!, _endJMonthMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurringIncome map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurringIncome(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      amountRial: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_rial'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      ),
      jDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}j_day'],
      )!,
      startJYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_j_year'],
      )!,
      startJMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_j_month'],
      )!,
      endJYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_j_year'],
      ),
      endJMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_j_month'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RecurringIncomesTable createAlias(String alias) {
    return $RecurringIncomesTable(attachedDatabase, alias);
  }
}

class RecurringIncome extends DataClass implements Insertable<RecurringIncome> {
  final int id;
  final String title;
  final int amountRial;
  final int? categoryId;
  final int? accountId;

  /// Day of the Jalali month; clamped per month when generating.
  final int jDay;
  final int startJYear;
  final int startJMonth;
  final int? endJYear;
  final int? endJMonth;
  final String? note;
  final bool isActive;
  final DateTime createdAt;
  const RecurringIncome({
    required this.id,
    required this.title,
    required this.amountRial,
    this.categoryId,
    this.accountId,
    required this.jDay,
    required this.startJYear,
    required this.startJMonth,
    this.endJYear,
    this.endJMonth,
    this.note,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['amount_rial'] = Variable<int>(amountRial);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<int>(accountId);
    }
    map['j_day'] = Variable<int>(jDay);
    map['start_j_year'] = Variable<int>(startJYear);
    map['start_j_month'] = Variable<int>(startJMonth);
    if (!nullToAbsent || endJYear != null) {
      map['end_j_year'] = Variable<int>(endJYear);
    }
    if (!nullToAbsent || endJMonth != null) {
      map['end_j_month'] = Variable<int>(endJMonth);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RecurringIncomesCompanion toCompanion(bool nullToAbsent) {
    return RecurringIncomesCompanion(
      id: Value(id),
      title: Value(title),
      amountRial: Value(amountRial),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      jDay: Value(jDay),
      startJYear: Value(startJYear),
      startJMonth: Value(startJMonth),
      endJYear: endJYear == null && nullToAbsent
          ? const Value.absent()
          : Value(endJYear),
      endJMonth: endJMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(endJMonth),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory RecurringIncome.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurringIncome(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      amountRial: serializer.fromJson<int>(json['amountRial']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      accountId: serializer.fromJson<int?>(json['accountId']),
      jDay: serializer.fromJson<int>(json['jDay']),
      startJYear: serializer.fromJson<int>(json['startJYear']),
      startJMonth: serializer.fromJson<int>(json['startJMonth']),
      endJYear: serializer.fromJson<int?>(json['endJYear']),
      endJMonth: serializer.fromJson<int?>(json['endJMonth']),
      note: serializer.fromJson<String?>(json['note']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'amountRial': serializer.toJson<int>(amountRial),
      'categoryId': serializer.toJson<int?>(categoryId),
      'accountId': serializer.toJson<int?>(accountId),
      'jDay': serializer.toJson<int>(jDay),
      'startJYear': serializer.toJson<int>(startJYear),
      'startJMonth': serializer.toJson<int>(startJMonth),
      'endJYear': serializer.toJson<int?>(endJYear),
      'endJMonth': serializer.toJson<int?>(endJMonth),
      'note': serializer.toJson<String?>(note),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RecurringIncome copyWith({
    int? id,
    String? title,
    int? amountRial,
    Value<int?> categoryId = const Value.absent(),
    Value<int?> accountId = const Value.absent(),
    int? jDay,
    int? startJYear,
    int? startJMonth,
    Value<int?> endJYear = const Value.absent(),
    Value<int?> endJMonth = const Value.absent(),
    Value<String?> note = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
  }) => RecurringIncome(
    id: id ?? this.id,
    title: title ?? this.title,
    amountRial: amountRial ?? this.amountRial,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    accountId: accountId.present ? accountId.value : this.accountId,
    jDay: jDay ?? this.jDay,
    startJYear: startJYear ?? this.startJYear,
    startJMonth: startJMonth ?? this.startJMonth,
    endJYear: endJYear.present ? endJYear.value : this.endJYear,
    endJMonth: endJMonth.present ? endJMonth.value : this.endJMonth,
    note: note.present ? note.value : this.note,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  RecurringIncome copyWithCompanion(RecurringIncomesCompanion data) {
    return RecurringIncome(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      amountRial: data.amountRial.present
          ? data.amountRial.value
          : this.amountRial,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      jDay: data.jDay.present ? data.jDay.value : this.jDay,
      startJYear: data.startJYear.present
          ? data.startJYear.value
          : this.startJYear,
      startJMonth: data.startJMonth.present
          ? data.startJMonth.value
          : this.startJMonth,
      endJYear: data.endJYear.present ? data.endJYear.value : this.endJYear,
      endJMonth: data.endJMonth.present ? data.endJMonth.value : this.endJMonth,
      note: data.note.present ? data.note.value : this.note,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurringIncome(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amountRial: $amountRial, ')
          ..write('categoryId: $categoryId, ')
          ..write('accountId: $accountId, ')
          ..write('jDay: $jDay, ')
          ..write('startJYear: $startJYear, ')
          ..write('startJMonth: $startJMonth, ')
          ..write('endJYear: $endJYear, ')
          ..write('endJMonth: $endJMonth, ')
          ..write('note: $note, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    amountRial,
    categoryId,
    accountId,
    jDay,
    startJYear,
    startJMonth,
    endJYear,
    endJMonth,
    note,
    isActive,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurringIncome &&
          other.id == this.id &&
          other.title == this.title &&
          other.amountRial == this.amountRial &&
          other.categoryId == this.categoryId &&
          other.accountId == this.accountId &&
          other.jDay == this.jDay &&
          other.startJYear == this.startJYear &&
          other.startJMonth == this.startJMonth &&
          other.endJYear == this.endJYear &&
          other.endJMonth == this.endJMonth &&
          other.note == this.note &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class RecurringIncomesCompanion extends UpdateCompanion<RecurringIncome> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> amountRial;
  final Value<int?> categoryId;
  final Value<int?> accountId;
  final Value<int> jDay;
  final Value<int> startJYear;
  final Value<int> startJMonth;
  final Value<int?> endJYear;
  final Value<int?> endJMonth;
  final Value<String?> note;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const RecurringIncomesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.amountRial = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.jDay = const Value.absent(),
    this.startJYear = const Value.absent(),
    this.startJMonth = const Value.absent(),
    this.endJYear = const Value.absent(),
    this.endJMonth = const Value.absent(),
    this.note = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RecurringIncomesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int amountRial,
    this.categoryId = const Value.absent(),
    this.accountId = const Value.absent(),
    required int jDay,
    required int startJYear,
    required int startJMonth,
    this.endJYear = const Value.absent(),
    this.endJMonth = const Value.absent(),
    this.note = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
  }) : title = Value(title),
       amountRial = Value(amountRial),
       jDay = Value(jDay),
       startJYear = Value(startJYear),
       startJMonth = Value(startJMonth),
       createdAt = Value(createdAt);
  static Insertable<RecurringIncome> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? amountRial,
    Expression<int>? categoryId,
    Expression<int>? accountId,
    Expression<int>? jDay,
    Expression<int>? startJYear,
    Expression<int>? startJMonth,
    Expression<int>? endJYear,
    Expression<int>? endJMonth,
    Expression<String>? note,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (amountRial != null) 'amount_rial': amountRial,
      if (categoryId != null) 'category_id': categoryId,
      if (accountId != null) 'account_id': accountId,
      if (jDay != null) 'j_day': jDay,
      if (startJYear != null) 'start_j_year': startJYear,
      if (startJMonth != null) 'start_j_month': startJMonth,
      if (endJYear != null) 'end_j_year': endJYear,
      if (endJMonth != null) 'end_j_month': endJMonth,
      if (note != null) 'note': note,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RecurringIncomesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<int>? amountRial,
    Value<int?>? categoryId,
    Value<int?>? accountId,
    Value<int>? jDay,
    Value<int>? startJYear,
    Value<int>? startJMonth,
    Value<int?>? endJYear,
    Value<int?>? endJMonth,
    Value<String?>? note,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return RecurringIncomesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      amountRial: amountRial ?? this.amountRial,
      categoryId: categoryId ?? this.categoryId,
      accountId: accountId ?? this.accountId,
      jDay: jDay ?? this.jDay,
      startJYear: startJYear ?? this.startJYear,
      startJMonth: startJMonth ?? this.startJMonth,
      endJYear: endJYear ?? this.endJYear,
      endJMonth: endJMonth ?? this.endJMonth,
      note: note ?? this.note,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (amountRial.present) {
      map['amount_rial'] = Variable<int>(amountRial.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (jDay.present) {
      map['j_day'] = Variable<int>(jDay.value);
    }
    if (startJYear.present) {
      map['start_j_year'] = Variable<int>(startJYear.value);
    }
    if (startJMonth.present) {
      map['start_j_month'] = Variable<int>(startJMonth.value);
    }
    if (endJYear.present) {
      map['end_j_year'] = Variable<int>(endJYear.value);
    }
    if (endJMonth.present) {
      map['end_j_month'] = Variable<int>(endJMonth.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurringIncomesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amountRial: $amountRial, ')
          ..write('categoryId: $categoryId, ')
          ..write('accountId: $accountId, ')
          ..write('jDay: $jDay, ')
          ..write('startJYear: $startJYear, ')
          ..write('startJMonth: $startJMonth, ')
          ..write('endJYear: $endJYear, ')
          ..write('endJMonth: $endJMonth, ')
          ..write('note: $note, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $RecurringExpensesTable extends RecurringExpenses
    with TableInfo<$RecurringExpensesTable, RecurringExpense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurringExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountRialMeta = const VerificationMeta(
    'amountRial',
  );
  @override
  late final GeneratedColumn<int> amountRial = GeneratedColumn<int>(
    'amount_rial',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _jDayMeta = const VerificationMeta('jDay');
  @override
  late final GeneratedColumn<int> jDay = GeneratedColumn<int>(
    'j_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startJYearMeta = const VerificationMeta(
    'startJYear',
  );
  @override
  late final GeneratedColumn<int> startJYear = GeneratedColumn<int>(
    'start_j_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startJMonthMeta = const VerificationMeta(
    'startJMonth',
  );
  @override
  late final GeneratedColumn<int> startJMonth = GeneratedColumn<int>(
    'start_j_month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endJYearMeta = const VerificationMeta(
    'endJYear',
  );
  @override
  late final GeneratedColumn<int> endJYear = GeneratedColumn<int>(
    'end_j_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endJMonthMeta = const VerificationMeta(
    'endJMonth',
  );
  @override
  late final GeneratedColumn<int> endJMonth = GeneratedColumn<int>(
    'end_j_month',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    amountRial,
    categoryId,
    accountId,
    jDay,
    startJYear,
    startJMonth,
    endJYear,
    endJMonth,
    note,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurring_expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecurringExpense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('amount_rial')) {
      context.handle(
        _amountRialMeta,
        amountRial.isAcceptableOrUnknown(data['amount_rial']!, _amountRialMeta),
      );
    } else if (isInserting) {
      context.missing(_amountRialMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    if (data.containsKey('j_day')) {
      context.handle(
        _jDayMeta,
        jDay.isAcceptableOrUnknown(data['j_day']!, _jDayMeta),
      );
    } else if (isInserting) {
      context.missing(_jDayMeta);
    }
    if (data.containsKey('start_j_year')) {
      context.handle(
        _startJYearMeta,
        startJYear.isAcceptableOrUnknown(
          data['start_j_year']!,
          _startJYearMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startJYearMeta);
    }
    if (data.containsKey('start_j_month')) {
      context.handle(
        _startJMonthMeta,
        startJMonth.isAcceptableOrUnknown(
          data['start_j_month']!,
          _startJMonthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startJMonthMeta);
    }
    if (data.containsKey('end_j_year')) {
      context.handle(
        _endJYearMeta,
        endJYear.isAcceptableOrUnknown(data['end_j_year']!, _endJYearMeta),
      );
    }
    if (data.containsKey('end_j_month')) {
      context.handle(
        _endJMonthMeta,
        endJMonth.isAcceptableOrUnknown(data['end_j_month']!, _endJMonthMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurringExpense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurringExpense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      amountRial: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_rial'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      ),
      jDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}j_day'],
      )!,
      startJYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_j_year'],
      )!,
      startJMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_j_month'],
      )!,
      endJYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_j_year'],
      ),
      endJMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_j_month'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RecurringExpensesTable createAlias(String alias) {
    return $RecurringExpensesTable(attachedDatabase, alias);
  }
}

class RecurringExpense extends DataClass
    implements Insertable<RecurringExpense> {
  final int id;
  final String title;
  final int amountRial;
  final int? categoryId;
  final int? accountId;

  /// Day of the Jalali month; clamped per month when generating.
  final int jDay;
  final int startJYear;
  final int startJMonth;
  final int? endJYear;
  final int? endJMonth;
  final String? note;
  final bool isActive;
  final DateTime createdAt;
  const RecurringExpense({
    required this.id,
    required this.title,
    required this.amountRial,
    this.categoryId,
    this.accountId,
    required this.jDay,
    required this.startJYear,
    required this.startJMonth,
    this.endJYear,
    this.endJMonth,
    this.note,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['amount_rial'] = Variable<int>(amountRial);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<int>(accountId);
    }
    map['j_day'] = Variable<int>(jDay);
    map['start_j_year'] = Variable<int>(startJYear);
    map['start_j_month'] = Variable<int>(startJMonth);
    if (!nullToAbsent || endJYear != null) {
      map['end_j_year'] = Variable<int>(endJYear);
    }
    if (!nullToAbsent || endJMonth != null) {
      map['end_j_month'] = Variable<int>(endJMonth);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RecurringExpensesCompanion toCompanion(bool nullToAbsent) {
    return RecurringExpensesCompanion(
      id: Value(id),
      title: Value(title),
      amountRial: Value(amountRial),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      jDay: Value(jDay),
      startJYear: Value(startJYear),
      startJMonth: Value(startJMonth),
      endJYear: endJYear == null && nullToAbsent
          ? const Value.absent()
          : Value(endJYear),
      endJMonth: endJMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(endJMonth),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory RecurringExpense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurringExpense(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      amountRial: serializer.fromJson<int>(json['amountRial']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      accountId: serializer.fromJson<int?>(json['accountId']),
      jDay: serializer.fromJson<int>(json['jDay']),
      startJYear: serializer.fromJson<int>(json['startJYear']),
      startJMonth: serializer.fromJson<int>(json['startJMonth']),
      endJYear: serializer.fromJson<int?>(json['endJYear']),
      endJMonth: serializer.fromJson<int?>(json['endJMonth']),
      note: serializer.fromJson<String?>(json['note']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'amountRial': serializer.toJson<int>(amountRial),
      'categoryId': serializer.toJson<int?>(categoryId),
      'accountId': serializer.toJson<int?>(accountId),
      'jDay': serializer.toJson<int>(jDay),
      'startJYear': serializer.toJson<int>(startJYear),
      'startJMonth': serializer.toJson<int>(startJMonth),
      'endJYear': serializer.toJson<int?>(endJYear),
      'endJMonth': serializer.toJson<int?>(endJMonth),
      'note': serializer.toJson<String?>(note),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RecurringExpense copyWith({
    int? id,
    String? title,
    int? amountRial,
    Value<int?> categoryId = const Value.absent(),
    Value<int?> accountId = const Value.absent(),
    int? jDay,
    int? startJYear,
    int? startJMonth,
    Value<int?> endJYear = const Value.absent(),
    Value<int?> endJMonth = const Value.absent(),
    Value<String?> note = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
  }) => RecurringExpense(
    id: id ?? this.id,
    title: title ?? this.title,
    amountRial: amountRial ?? this.amountRial,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    accountId: accountId.present ? accountId.value : this.accountId,
    jDay: jDay ?? this.jDay,
    startJYear: startJYear ?? this.startJYear,
    startJMonth: startJMonth ?? this.startJMonth,
    endJYear: endJYear.present ? endJYear.value : this.endJYear,
    endJMonth: endJMonth.present ? endJMonth.value : this.endJMonth,
    note: note.present ? note.value : this.note,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  RecurringExpense copyWithCompanion(RecurringExpensesCompanion data) {
    return RecurringExpense(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      amountRial: data.amountRial.present
          ? data.amountRial.value
          : this.amountRial,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      jDay: data.jDay.present ? data.jDay.value : this.jDay,
      startJYear: data.startJYear.present
          ? data.startJYear.value
          : this.startJYear,
      startJMonth: data.startJMonth.present
          ? data.startJMonth.value
          : this.startJMonth,
      endJYear: data.endJYear.present ? data.endJYear.value : this.endJYear,
      endJMonth: data.endJMonth.present ? data.endJMonth.value : this.endJMonth,
      note: data.note.present ? data.note.value : this.note,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurringExpense(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amountRial: $amountRial, ')
          ..write('categoryId: $categoryId, ')
          ..write('accountId: $accountId, ')
          ..write('jDay: $jDay, ')
          ..write('startJYear: $startJYear, ')
          ..write('startJMonth: $startJMonth, ')
          ..write('endJYear: $endJYear, ')
          ..write('endJMonth: $endJMonth, ')
          ..write('note: $note, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    amountRial,
    categoryId,
    accountId,
    jDay,
    startJYear,
    startJMonth,
    endJYear,
    endJMonth,
    note,
    isActive,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurringExpense &&
          other.id == this.id &&
          other.title == this.title &&
          other.amountRial == this.amountRial &&
          other.categoryId == this.categoryId &&
          other.accountId == this.accountId &&
          other.jDay == this.jDay &&
          other.startJYear == this.startJYear &&
          other.startJMonth == this.startJMonth &&
          other.endJYear == this.endJYear &&
          other.endJMonth == this.endJMonth &&
          other.note == this.note &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class RecurringExpensesCompanion extends UpdateCompanion<RecurringExpense> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> amountRial;
  final Value<int?> categoryId;
  final Value<int?> accountId;
  final Value<int> jDay;
  final Value<int> startJYear;
  final Value<int> startJMonth;
  final Value<int?> endJYear;
  final Value<int?> endJMonth;
  final Value<String?> note;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const RecurringExpensesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.amountRial = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.jDay = const Value.absent(),
    this.startJYear = const Value.absent(),
    this.startJMonth = const Value.absent(),
    this.endJYear = const Value.absent(),
    this.endJMonth = const Value.absent(),
    this.note = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RecurringExpensesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int amountRial,
    this.categoryId = const Value.absent(),
    this.accountId = const Value.absent(),
    required int jDay,
    required int startJYear,
    required int startJMonth,
    this.endJYear = const Value.absent(),
    this.endJMonth = const Value.absent(),
    this.note = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
  }) : title = Value(title),
       amountRial = Value(amountRial),
       jDay = Value(jDay),
       startJYear = Value(startJYear),
       startJMonth = Value(startJMonth),
       createdAt = Value(createdAt);
  static Insertable<RecurringExpense> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? amountRial,
    Expression<int>? categoryId,
    Expression<int>? accountId,
    Expression<int>? jDay,
    Expression<int>? startJYear,
    Expression<int>? startJMonth,
    Expression<int>? endJYear,
    Expression<int>? endJMonth,
    Expression<String>? note,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (amountRial != null) 'amount_rial': amountRial,
      if (categoryId != null) 'category_id': categoryId,
      if (accountId != null) 'account_id': accountId,
      if (jDay != null) 'j_day': jDay,
      if (startJYear != null) 'start_j_year': startJYear,
      if (startJMonth != null) 'start_j_month': startJMonth,
      if (endJYear != null) 'end_j_year': endJYear,
      if (endJMonth != null) 'end_j_month': endJMonth,
      if (note != null) 'note': note,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RecurringExpensesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<int>? amountRial,
    Value<int?>? categoryId,
    Value<int?>? accountId,
    Value<int>? jDay,
    Value<int>? startJYear,
    Value<int>? startJMonth,
    Value<int?>? endJYear,
    Value<int?>? endJMonth,
    Value<String?>? note,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return RecurringExpensesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      amountRial: amountRial ?? this.amountRial,
      categoryId: categoryId ?? this.categoryId,
      accountId: accountId ?? this.accountId,
      jDay: jDay ?? this.jDay,
      startJYear: startJYear ?? this.startJYear,
      startJMonth: startJMonth ?? this.startJMonth,
      endJYear: endJYear ?? this.endJYear,
      endJMonth: endJMonth ?? this.endJMonth,
      note: note ?? this.note,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (amountRial.present) {
      map['amount_rial'] = Variable<int>(amountRial.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (jDay.present) {
      map['j_day'] = Variable<int>(jDay.value);
    }
    if (startJYear.present) {
      map['start_j_year'] = Variable<int>(startJYear.value);
    }
    if (startJMonth.present) {
      map['start_j_month'] = Variable<int>(startJMonth.value);
    }
    if (endJYear.present) {
      map['end_j_year'] = Variable<int>(endJYear.value);
    }
    if (endJMonth.present) {
      map['end_j_month'] = Variable<int>(endJMonth.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurringExpensesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amountRial: $amountRial, ')
          ..write('categoryId: $categoryId, ')
          ..write('accountId: $accountId, ')
          ..write('jDay: $jDay, ')
          ..write('startJYear: $startJYear, ')
          ..write('startJMonth: $startJMonth, ')
          ..write('endJYear: $endJYear, ')
          ..write('endJMonth: $endJMonth, ')
          ..write('note: $note, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $RecurringOccurrencesTable extends RecurringOccurrences
    with TableInfo<$RecurringOccurrencesTable, RecurringOccurrence> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurringOccurrencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<OwnerKind, int> ownerKind =
      GeneratedColumn<int>(
        'owner_kind',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<OwnerKind>(
        $RecurringOccurrencesTable.$converterownerKind,
      );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<int> ownerId = GeneratedColumn<int>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jYearMeta = const VerificationMeta('jYear');
  @override
  late final GeneratedColumn<int> jYear = GeneratedColumn<int>(
    'j_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jMonthMeta = const VerificationMeta('jMonth');
  @override
  late final GeneratedColumn<int> jMonth = GeneratedColumn<int>(
    'j_month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt = GeneratedColumn<DateTime>(
    'due_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<OccurrenceStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<OccurrenceStatus>(
        $RecurringOccurrencesTable.$converterstatus,
      );
  static const VerificationMeta _amountOverrideRialMeta =
      const VerificationMeta('amountOverrideRial');
  @override
  late final GeneratedColumn<int> amountOverrideRial = GeneratedColumn<int>(
    'amount_override_rial',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<int> transactionId = GeneratedColumn<int>(
    'transaction_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES transactions (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _resolvedAtMeta = const VerificationMeta(
    'resolvedAt',
  );
  @override
  late final GeneratedColumn<DateTime> resolvedAt = GeneratedColumn<DateTime>(
    'resolved_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerKind,
    ownerId,
    jYear,
    jMonth,
    dueAt,
    status,
    amountOverrideRial,
    transactionId,
    resolvedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurring_occurrences';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecurringOccurrence> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('j_year')) {
      context.handle(
        _jYearMeta,
        jYear.isAcceptableOrUnknown(data['j_year']!, _jYearMeta),
      );
    } else if (isInserting) {
      context.missing(_jYearMeta);
    }
    if (data.containsKey('j_month')) {
      context.handle(
        _jMonthMeta,
        jMonth.isAcceptableOrUnknown(data['j_month']!, _jMonthMeta),
      );
    } else if (isInserting) {
      context.missing(_jMonthMeta);
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    } else if (isInserting) {
      context.missing(_dueAtMeta);
    }
    if (data.containsKey('amount_override_rial')) {
      context.handle(
        _amountOverrideRialMeta,
        amountOverrideRial.isAcceptableOrUnknown(
          data['amount_override_rial']!,
          _amountOverrideRialMeta,
        ),
      );
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    }
    if (data.containsKey('resolved_at')) {
      context.handle(
        _resolvedAtMeta,
        resolvedAt.isAcceptableOrUnknown(data['resolved_at']!, _resolvedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {ownerKind, ownerId, jYear, jMonth},
  ];
  @override
  RecurringOccurrence map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurringOccurrence(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ownerKind: $RecurringOccurrencesTable.$converterownerKind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}owner_kind'],
        )!,
      ),
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}owner_id'],
      )!,
      jYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}j_year'],
      )!,
      jMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}j_month'],
      )!,
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_at'],
      )!,
      status: $RecurringOccurrencesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      amountOverrideRial: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_override_rial'],
      ),
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transaction_id'],
      ),
      resolvedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}resolved_at'],
      ),
    );
  }

  @override
  $RecurringOccurrencesTable createAlias(String alias) {
    return $RecurringOccurrencesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<OwnerKind, int, int> $converterownerKind =
      const EnumIndexConverter<OwnerKind>(OwnerKind.values);
  static JsonTypeConverter2<OccurrenceStatus, int, int> $converterstatus =
      const EnumIndexConverter<OccurrenceStatus>(OccurrenceStatus.values);
}

class RecurringOccurrence extends DataClass
    implements Insertable<RecurringOccurrence> {
  final int id;
  final OwnerKind ownerKind;
  final int ownerId;
  final int jYear;
  final int jMonth;
  final DateTime dueAt;
  final OccurrenceStatus status;

  /// Set when this month's amount differed from the recurring default.
  final int? amountOverrideRial;

  /// A resolved occurrence always points at the transaction that settled it.
  final int? transactionId;
  final DateTime? resolvedAt;
  const RecurringOccurrence({
    required this.id,
    required this.ownerKind,
    required this.ownerId,
    required this.jYear,
    required this.jMonth,
    required this.dueAt,
    required this.status,
    this.amountOverrideRial,
    this.transactionId,
    this.resolvedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['owner_kind'] = Variable<int>(
        $RecurringOccurrencesTable.$converterownerKind.toSql(ownerKind),
      );
    }
    map['owner_id'] = Variable<int>(ownerId);
    map['j_year'] = Variable<int>(jYear);
    map['j_month'] = Variable<int>(jMonth);
    map['due_at'] = Variable<DateTime>(dueAt);
    {
      map['status'] = Variable<int>(
        $RecurringOccurrencesTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || amountOverrideRial != null) {
      map['amount_override_rial'] = Variable<int>(amountOverrideRial);
    }
    if (!nullToAbsent || transactionId != null) {
      map['transaction_id'] = Variable<int>(transactionId);
    }
    if (!nullToAbsent || resolvedAt != null) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt);
    }
    return map;
  }

  RecurringOccurrencesCompanion toCompanion(bool nullToAbsent) {
    return RecurringOccurrencesCompanion(
      id: Value(id),
      ownerKind: Value(ownerKind),
      ownerId: Value(ownerId),
      jYear: Value(jYear),
      jMonth: Value(jMonth),
      dueAt: Value(dueAt),
      status: Value(status),
      amountOverrideRial: amountOverrideRial == null && nullToAbsent
          ? const Value.absent()
          : Value(amountOverrideRial),
      transactionId: transactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionId),
      resolvedAt: resolvedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(resolvedAt),
    );
  }

  factory RecurringOccurrence.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurringOccurrence(
      id: serializer.fromJson<int>(json['id']),
      ownerKind: $RecurringOccurrencesTable.$converterownerKind.fromJson(
        serializer.fromJson<int>(json['ownerKind']),
      ),
      ownerId: serializer.fromJson<int>(json['ownerId']),
      jYear: serializer.fromJson<int>(json['jYear']),
      jMonth: serializer.fromJson<int>(json['jMonth']),
      dueAt: serializer.fromJson<DateTime>(json['dueAt']),
      status: $RecurringOccurrencesTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      amountOverrideRial: serializer.fromJson<int?>(json['amountOverrideRial']),
      transactionId: serializer.fromJson<int?>(json['transactionId']),
      resolvedAt: serializer.fromJson<DateTime?>(json['resolvedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ownerKind': serializer.toJson<int>(
        $RecurringOccurrencesTable.$converterownerKind.toJson(ownerKind),
      ),
      'ownerId': serializer.toJson<int>(ownerId),
      'jYear': serializer.toJson<int>(jYear),
      'jMonth': serializer.toJson<int>(jMonth),
      'dueAt': serializer.toJson<DateTime>(dueAt),
      'status': serializer.toJson<int>(
        $RecurringOccurrencesTable.$converterstatus.toJson(status),
      ),
      'amountOverrideRial': serializer.toJson<int?>(amountOverrideRial),
      'transactionId': serializer.toJson<int?>(transactionId),
      'resolvedAt': serializer.toJson<DateTime?>(resolvedAt),
    };
  }

  RecurringOccurrence copyWith({
    int? id,
    OwnerKind? ownerKind,
    int? ownerId,
    int? jYear,
    int? jMonth,
    DateTime? dueAt,
    OccurrenceStatus? status,
    Value<int?> amountOverrideRial = const Value.absent(),
    Value<int?> transactionId = const Value.absent(),
    Value<DateTime?> resolvedAt = const Value.absent(),
  }) => RecurringOccurrence(
    id: id ?? this.id,
    ownerKind: ownerKind ?? this.ownerKind,
    ownerId: ownerId ?? this.ownerId,
    jYear: jYear ?? this.jYear,
    jMonth: jMonth ?? this.jMonth,
    dueAt: dueAt ?? this.dueAt,
    status: status ?? this.status,
    amountOverrideRial: amountOverrideRial.present
        ? amountOverrideRial.value
        : this.amountOverrideRial,
    transactionId: transactionId.present
        ? transactionId.value
        : this.transactionId,
    resolvedAt: resolvedAt.present ? resolvedAt.value : this.resolvedAt,
  );
  RecurringOccurrence copyWithCompanion(RecurringOccurrencesCompanion data) {
    return RecurringOccurrence(
      id: data.id.present ? data.id.value : this.id,
      ownerKind: data.ownerKind.present ? data.ownerKind.value : this.ownerKind,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      jYear: data.jYear.present ? data.jYear.value : this.jYear,
      jMonth: data.jMonth.present ? data.jMonth.value : this.jMonth,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      status: data.status.present ? data.status.value : this.status,
      amountOverrideRial: data.amountOverrideRial.present
          ? data.amountOverrideRial.value
          : this.amountOverrideRial,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      resolvedAt: data.resolvedAt.present
          ? data.resolvedAt.value
          : this.resolvedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurringOccurrence(')
          ..write('id: $id, ')
          ..write('ownerKind: $ownerKind, ')
          ..write('ownerId: $ownerId, ')
          ..write('jYear: $jYear, ')
          ..write('jMonth: $jMonth, ')
          ..write('dueAt: $dueAt, ')
          ..write('status: $status, ')
          ..write('amountOverrideRial: $amountOverrideRial, ')
          ..write('transactionId: $transactionId, ')
          ..write('resolvedAt: $resolvedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ownerKind,
    ownerId,
    jYear,
    jMonth,
    dueAt,
    status,
    amountOverrideRial,
    transactionId,
    resolvedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurringOccurrence &&
          other.id == this.id &&
          other.ownerKind == this.ownerKind &&
          other.ownerId == this.ownerId &&
          other.jYear == this.jYear &&
          other.jMonth == this.jMonth &&
          other.dueAt == this.dueAt &&
          other.status == this.status &&
          other.amountOverrideRial == this.amountOverrideRial &&
          other.transactionId == this.transactionId &&
          other.resolvedAt == this.resolvedAt);
}

class RecurringOccurrencesCompanion
    extends UpdateCompanion<RecurringOccurrence> {
  final Value<int> id;
  final Value<OwnerKind> ownerKind;
  final Value<int> ownerId;
  final Value<int> jYear;
  final Value<int> jMonth;
  final Value<DateTime> dueAt;
  final Value<OccurrenceStatus> status;
  final Value<int?> amountOverrideRial;
  final Value<int?> transactionId;
  final Value<DateTime?> resolvedAt;
  const RecurringOccurrencesCompanion({
    this.id = const Value.absent(),
    this.ownerKind = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.jYear = const Value.absent(),
    this.jMonth = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.status = const Value.absent(),
    this.amountOverrideRial = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.resolvedAt = const Value.absent(),
  });
  RecurringOccurrencesCompanion.insert({
    this.id = const Value.absent(),
    required OwnerKind ownerKind,
    required int ownerId,
    required int jYear,
    required int jMonth,
    required DateTime dueAt,
    required OccurrenceStatus status,
    this.amountOverrideRial = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.resolvedAt = const Value.absent(),
  }) : ownerKind = Value(ownerKind),
       ownerId = Value(ownerId),
       jYear = Value(jYear),
       jMonth = Value(jMonth),
       dueAt = Value(dueAt),
       status = Value(status);
  static Insertable<RecurringOccurrence> custom({
    Expression<int>? id,
    Expression<int>? ownerKind,
    Expression<int>? ownerId,
    Expression<int>? jYear,
    Expression<int>? jMonth,
    Expression<DateTime>? dueAt,
    Expression<int>? status,
    Expression<int>? amountOverrideRial,
    Expression<int>? transactionId,
    Expression<DateTime>? resolvedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerKind != null) 'owner_kind': ownerKind,
      if (ownerId != null) 'owner_id': ownerId,
      if (jYear != null) 'j_year': jYear,
      if (jMonth != null) 'j_month': jMonth,
      if (dueAt != null) 'due_at': dueAt,
      if (status != null) 'status': status,
      if (amountOverrideRial != null)
        'amount_override_rial': amountOverrideRial,
      if (transactionId != null) 'transaction_id': transactionId,
      if (resolvedAt != null) 'resolved_at': resolvedAt,
    });
  }

  RecurringOccurrencesCompanion copyWith({
    Value<int>? id,
    Value<OwnerKind>? ownerKind,
    Value<int>? ownerId,
    Value<int>? jYear,
    Value<int>? jMonth,
    Value<DateTime>? dueAt,
    Value<OccurrenceStatus>? status,
    Value<int?>? amountOverrideRial,
    Value<int?>? transactionId,
    Value<DateTime?>? resolvedAt,
  }) {
    return RecurringOccurrencesCompanion(
      id: id ?? this.id,
      ownerKind: ownerKind ?? this.ownerKind,
      ownerId: ownerId ?? this.ownerId,
      jYear: jYear ?? this.jYear,
      jMonth: jMonth ?? this.jMonth,
      dueAt: dueAt ?? this.dueAt,
      status: status ?? this.status,
      amountOverrideRial: amountOverrideRial ?? this.amountOverrideRial,
      transactionId: transactionId ?? this.transactionId,
      resolvedAt: resolvedAt ?? this.resolvedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ownerKind.present) {
      map['owner_kind'] = Variable<int>(
        $RecurringOccurrencesTable.$converterownerKind.toSql(ownerKind.value),
      );
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<int>(ownerId.value);
    }
    if (jYear.present) {
      map['j_year'] = Variable<int>(jYear.value);
    }
    if (jMonth.present) {
      map['j_month'] = Variable<int>(jMonth.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $RecurringOccurrencesTable.$converterstatus.toSql(status.value),
      );
    }
    if (amountOverrideRial.present) {
      map['amount_override_rial'] = Variable<int>(amountOverrideRial.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<int>(transactionId.value);
    }
    if (resolvedAt.present) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurringOccurrencesCompanion(')
          ..write('id: $id, ')
          ..write('ownerKind: $ownerKind, ')
          ..write('ownerId: $ownerId, ')
          ..write('jYear: $jYear, ')
          ..write('jMonth: $jMonth, ')
          ..write('dueAt: $dueAt, ')
          ..write('status: $status, ')
          ..write('amountOverrideRial: $amountOverrideRial, ')
          ..write('transactionId: $transactionId, ')
          ..write('resolvedAt: $resolvedAt')
          ..write(')'))
        .toString();
  }
}

class $ReminderRulesTable extends ReminderRules
    with TableInfo<$ReminderRulesTable, ReminderRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReminderRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<OwnerKind, int> ownerKind =
      GeneratedColumn<int>(
        'owner_kind',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<OwnerKind>($ReminderRulesTable.$converterownerKind);
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<int> ownerId = GeneratedColumn<int>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _daysBeforeMeta = const VerificationMeta(
    'daysBefore',
  );
  @override
  late final GeneratedColumn<int> daysBefore = GeneratedColumn<int>(
    'days_before',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minutesOfDayMeta = const VerificationMeta(
    'minutesOfDay',
  );
  @override
  late final GeneratedColumn<int> minutesOfDay = GeneratedColumn<int>(
    'minutes_of_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(9 * 60),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerKind,
    ownerId,
    daysBefore,
    minutesOfDay,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminder_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('days_before')) {
      context.handle(
        _daysBeforeMeta,
        daysBefore.isAcceptableOrUnknown(data['days_before']!, _daysBeforeMeta),
      );
    } else if (isInserting) {
      context.missing(_daysBeforeMeta);
    }
    if (data.containsKey('minutes_of_day')) {
      context.handle(
        _minutesOfDayMeta,
        minutesOfDay.isAcceptableOrUnknown(
          data['minutes_of_day']!,
          _minutesOfDayMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReminderRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ownerKind: $ReminderRulesTable.$converterownerKind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}owner_kind'],
        )!,
      ),
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}owner_id'],
      )!,
      daysBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}days_before'],
      )!,
      minutesOfDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minutes_of_day'],
      )!,
    );
  }

  @override
  $ReminderRulesTable createAlias(String alias) {
    return $ReminderRulesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<OwnerKind, int, int> $converterownerKind =
      const EnumIndexConverter<OwnerKind>(OwnerKind.values);
}

class ReminderRule extends DataClass implements Insertable<ReminderRule> {
  final int id;
  final OwnerKind ownerKind;
  final int ownerId;
  final int daysBefore;
  final int minutesOfDay;
  const ReminderRule({
    required this.id,
    required this.ownerKind,
    required this.ownerId,
    required this.daysBefore,
    required this.minutesOfDay,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['owner_kind'] = Variable<int>(
        $ReminderRulesTable.$converterownerKind.toSql(ownerKind),
      );
    }
    map['owner_id'] = Variable<int>(ownerId);
    map['days_before'] = Variable<int>(daysBefore);
    map['minutes_of_day'] = Variable<int>(minutesOfDay);
    return map;
  }

  ReminderRulesCompanion toCompanion(bool nullToAbsent) {
    return ReminderRulesCompanion(
      id: Value(id),
      ownerKind: Value(ownerKind),
      ownerId: Value(ownerId),
      daysBefore: Value(daysBefore),
      minutesOfDay: Value(minutesOfDay),
    );
  }

  factory ReminderRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderRule(
      id: serializer.fromJson<int>(json['id']),
      ownerKind: $ReminderRulesTable.$converterownerKind.fromJson(
        serializer.fromJson<int>(json['ownerKind']),
      ),
      ownerId: serializer.fromJson<int>(json['ownerId']),
      daysBefore: serializer.fromJson<int>(json['daysBefore']),
      minutesOfDay: serializer.fromJson<int>(json['minutesOfDay']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ownerKind': serializer.toJson<int>(
        $ReminderRulesTable.$converterownerKind.toJson(ownerKind),
      ),
      'ownerId': serializer.toJson<int>(ownerId),
      'daysBefore': serializer.toJson<int>(daysBefore),
      'minutesOfDay': serializer.toJson<int>(minutesOfDay),
    };
  }

  ReminderRule copyWith({
    int? id,
    OwnerKind? ownerKind,
    int? ownerId,
    int? daysBefore,
    int? minutesOfDay,
  }) => ReminderRule(
    id: id ?? this.id,
    ownerKind: ownerKind ?? this.ownerKind,
    ownerId: ownerId ?? this.ownerId,
    daysBefore: daysBefore ?? this.daysBefore,
    minutesOfDay: minutesOfDay ?? this.minutesOfDay,
  );
  ReminderRule copyWithCompanion(ReminderRulesCompanion data) {
    return ReminderRule(
      id: data.id.present ? data.id.value : this.id,
      ownerKind: data.ownerKind.present ? data.ownerKind.value : this.ownerKind,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      daysBefore: data.daysBefore.present
          ? data.daysBefore.value
          : this.daysBefore,
      minutesOfDay: data.minutesOfDay.present
          ? data.minutesOfDay.value
          : this.minutesOfDay,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderRule(')
          ..write('id: $id, ')
          ..write('ownerKind: $ownerKind, ')
          ..write('ownerId: $ownerId, ')
          ..write('daysBefore: $daysBefore, ')
          ..write('minutesOfDay: $minutesOfDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ownerKind, ownerId, daysBefore, minutesOfDay);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderRule &&
          other.id == this.id &&
          other.ownerKind == this.ownerKind &&
          other.ownerId == this.ownerId &&
          other.daysBefore == this.daysBefore &&
          other.minutesOfDay == this.minutesOfDay);
}

class ReminderRulesCompanion extends UpdateCompanion<ReminderRule> {
  final Value<int> id;
  final Value<OwnerKind> ownerKind;
  final Value<int> ownerId;
  final Value<int> daysBefore;
  final Value<int> minutesOfDay;
  const ReminderRulesCompanion({
    this.id = const Value.absent(),
    this.ownerKind = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.daysBefore = const Value.absent(),
    this.minutesOfDay = const Value.absent(),
  });
  ReminderRulesCompanion.insert({
    this.id = const Value.absent(),
    required OwnerKind ownerKind,
    required int ownerId,
    required int daysBefore,
    this.minutesOfDay = const Value.absent(),
  }) : ownerKind = Value(ownerKind),
       ownerId = Value(ownerId),
       daysBefore = Value(daysBefore);
  static Insertable<ReminderRule> custom({
    Expression<int>? id,
    Expression<int>? ownerKind,
    Expression<int>? ownerId,
    Expression<int>? daysBefore,
    Expression<int>? minutesOfDay,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerKind != null) 'owner_kind': ownerKind,
      if (ownerId != null) 'owner_id': ownerId,
      if (daysBefore != null) 'days_before': daysBefore,
      if (minutesOfDay != null) 'minutes_of_day': minutesOfDay,
    });
  }

  ReminderRulesCompanion copyWith({
    Value<int>? id,
    Value<OwnerKind>? ownerKind,
    Value<int>? ownerId,
    Value<int>? daysBefore,
    Value<int>? minutesOfDay,
  }) {
    return ReminderRulesCompanion(
      id: id ?? this.id,
      ownerKind: ownerKind ?? this.ownerKind,
      ownerId: ownerId ?? this.ownerId,
      daysBefore: daysBefore ?? this.daysBefore,
      minutesOfDay: minutesOfDay ?? this.minutesOfDay,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ownerKind.present) {
      map['owner_kind'] = Variable<int>(
        $ReminderRulesTable.$converterownerKind.toSql(ownerKind.value),
      );
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<int>(ownerId.value);
    }
    if (daysBefore.present) {
      map['days_before'] = Variable<int>(daysBefore.value);
    }
    if (minutesOfDay.present) {
      map['minutes_of_day'] = Variable<int>(minutesOfDay.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReminderRulesCompanion(')
          ..write('id: $id, ')
          ..write('ownerKind: $ownerKind, ')
          ..write('ownerId: $ownerId, ')
          ..write('daysBefore: $daysBefore, ')
          ..write('minutesOfDay: $minutesOfDay')
          ..write(')'))
        .toString();
  }
}

class $ScheduledNotificationsTable extends ScheduledNotifications
    with TableInfo<$ScheduledNotificationsTable, ScheduledNotification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduledNotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<OwnerKind, int> ownerKind =
      GeneratedColumn<int>(
        'owner_kind',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<OwnerKind>(
        $ScheduledNotificationsTable.$converterownerKind,
      );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<int> ownerId = GeneratedColumn<int>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occurrenceIdMeta = const VerificationMeta(
    'occurrenceId',
  );
  @override
  late final GeneratedColumn<int> occurrenceId = GeneratedColumn<int>(
    'occurrence_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleIdMeta = const VerificationMeta('ruleId');
  @override
  late final GeneratedColumn<int> ruleId = GeneratedColumn<int>(
    'rule_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fireAtMeta = const VerificationMeta('fireAt');
  @override
  late final GeneratedColumn<DateTime> fireAt = GeneratedColumn<DateTime>(
    'fire_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerKind,
    ownerId,
    occurrenceId,
    ruleId,
    fireAt,
    payload,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scheduled_notifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScheduledNotification> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('occurrence_id')) {
      context.handle(
        _occurrenceIdMeta,
        occurrenceId.isAcceptableOrUnknown(
          data['occurrence_id']!,
          _occurrenceIdMeta,
        ),
      );
    }
    if (data.containsKey('rule_id')) {
      context.handle(
        _ruleIdMeta,
        ruleId.isAcceptableOrUnknown(data['rule_id']!, _ruleIdMeta),
      );
    }
    if (data.containsKey('fire_at')) {
      context.handle(
        _fireAtMeta,
        fireAt.isAcceptableOrUnknown(data['fire_at']!, _fireAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fireAtMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduledNotification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduledNotification(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ownerKind: $ScheduledNotificationsTable.$converterownerKind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}owner_kind'],
        )!,
      ),
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}owner_id'],
      )!,
      occurrenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}occurrence_id'],
      ),
      ruleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rule_id'],
      ),
      fireAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fire_at'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
    );
  }

  @override
  $ScheduledNotificationsTable createAlias(String alias) {
    return $ScheduledNotificationsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<OwnerKind, int, int> $converterownerKind =
      const EnumIndexConverter<OwnerKind>(OwnerKind.values);
}

class ScheduledNotification extends DataClass
    implements Insertable<ScheduledNotification> {
  /// Also the notification id handed to flutter_local_notifications.
  final int id;
  final OwnerKind ownerKind;
  final int ownerId;
  final int? occurrenceId;
  final int? ruleId;
  final DateTime fireAt;
  final String payload;
  const ScheduledNotification({
    required this.id,
    required this.ownerKind,
    required this.ownerId,
    this.occurrenceId,
    this.ruleId,
    required this.fireAt,
    required this.payload,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['owner_kind'] = Variable<int>(
        $ScheduledNotificationsTable.$converterownerKind.toSql(ownerKind),
      );
    }
    map['owner_id'] = Variable<int>(ownerId);
    if (!nullToAbsent || occurrenceId != null) {
      map['occurrence_id'] = Variable<int>(occurrenceId);
    }
    if (!nullToAbsent || ruleId != null) {
      map['rule_id'] = Variable<int>(ruleId);
    }
    map['fire_at'] = Variable<DateTime>(fireAt);
    map['payload'] = Variable<String>(payload);
    return map;
  }

  ScheduledNotificationsCompanion toCompanion(bool nullToAbsent) {
    return ScheduledNotificationsCompanion(
      id: Value(id),
      ownerKind: Value(ownerKind),
      ownerId: Value(ownerId),
      occurrenceId: occurrenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(occurrenceId),
      ruleId: ruleId == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleId),
      fireAt: Value(fireAt),
      payload: Value(payload),
    );
  }

  factory ScheduledNotification.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduledNotification(
      id: serializer.fromJson<int>(json['id']),
      ownerKind: $ScheduledNotificationsTable.$converterownerKind.fromJson(
        serializer.fromJson<int>(json['ownerKind']),
      ),
      ownerId: serializer.fromJson<int>(json['ownerId']),
      occurrenceId: serializer.fromJson<int?>(json['occurrenceId']),
      ruleId: serializer.fromJson<int?>(json['ruleId']),
      fireAt: serializer.fromJson<DateTime>(json['fireAt']),
      payload: serializer.fromJson<String>(json['payload']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ownerKind': serializer.toJson<int>(
        $ScheduledNotificationsTable.$converterownerKind.toJson(ownerKind),
      ),
      'ownerId': serializer.toJson<int>(ownerId),
      'occurrenceId': serializer.toJson<int?>(occurrenceId),
      'ruleId': serializer.toJson<int?>(ruleId),
      'fireAt': serializer.toJson<DateTime>(fireAt),
      'payload': serializer.toJson<String>(payload),
    };
  }

  ScheduledNotification copyWith({
    int? id,
    OwnerKind? ownerKind,
    int? ownerId,
    Value<int?> occurrenceId = const Value.absent(),
    Value<int?> ruleId = const Value.absent(),
    DateTime? fireAt,
    String? payload,
  }) => ScheduledNotification(
    id: id ?? this.id,
    ownerKind: ownerKind ?? this.ownerKind,
    ownerId: ownerId ?? this.ownerId,
    occurrenceId: occurrenceId.present ? occurrenceId.value : this.occurrenceId,
    ruleId: ruleId.present ? ruleId.value : this.ruleId,
    fireAt: fireAt ?? this.fireAt,
    payload: payload ?? this.payload,
  );
  ScheduledNotification copyWithCompanion(
    ScheduledNotificationsCompanion data,
  ) {
    return ScheduledNotification(
      id: data.id.present ? data.id.value : this.id,
      ownerKind: data.ownerKind.present ? data.ownerKind.value : this.ownerKind,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      occurrenceId: data.occurrenceId.present
          ? data.occurrenceId.value
          : this.occurrenceId,
      ruleId: data.ruleId.present ? data.ruleId.value : this.ruleId,
      fireAt: data.fireAt.present ? data.fireAt.value : this.fireAt,
      payload: data.payload.present ? data.payload.value : this.payload,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduledNotification(')
          ..write('id: $id, ')
          ..write('ownerKind: $ownerKind, ')
          ..write('ownerId: $ownerId, ')
          ..write('occurrenceId: $occurrenceId, ')
          ..write('ruleId: $ruleId, ')
          ..write('fireAt: $fireAt, ')
          ..write('payload: $payload')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ownerKind,
    ownerId,
    occurrenceId,
    ruleId,
    fireAt,
    payload,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduledNotification &&
          other.id == this.id &&
          other.ownerKind == this.ownerKind &&
          other.ownerId == this.ownerId &&
          other.occurrenceId == this.occurrenceId &&
          other.ruleId == this.ruleId &&
          other.fireAt == this.fireAt &&
          other.payload == this.payload);
}

class ScheduledNotificationsCompanion
    extends UpdateCompanion<ScheduledNotification> {
  final Value<int> id;
  final Value<OwnerKind> ownerKind;
  final Value<int> ownerId;
  final Value<int?> occurrenceId;
  final Value<int?> ruleId;
  final Value<DateTime> fireAt;
  final Value<String> payload;
  const ScheduledNotificationsCompanion({
    this.id = const Value.absent(),
    this.ownerKind = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.occurrenceId = const Value.absent(),
    this.ruleId = const Value.absent(),
    this.fireAt = const Value.absent(),
    this.payload = const Value.absent(),
  });
  ScheduledNotificationsCompanion.insert({
    this.id = const Value.absent(),
    required OwnerKind ownerKind,
    required int ownerId,
    this.occurrenceId = const Value.absent(),
    this.ruleId = const Value.absent(),
    required DateTime fireAt,
    required String payload,
  }) : ownerKind = Value(ownerKind),
       ownerId = Value(ownerId),
       fireAt = Value(fireAt),
       payload = Value(payload);
  static Insertable<ScheduledNotification> custom({
    Expression<int>? id,
    Expression<int>? ownerKind,
    Expression<int>? ownerId,
    Expression<int>? occurrenceId,
    Expression<int>? ruleId,
    Expression<DateTime>? fireAt,
    Expression<String>? payload,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerKind != null) 'owner_kind': ownerKind,
      if (ownerId != null) 'owner_id': ownerId,
      if (occurrenceId != null) 'occurrence_id': occurrenceId,
      if (ruleId != null) 'rule_id': ruleId,
      if (fireAt != null) 'fire_at': fireAt,
      if (payload != null) 'payload': payload,
    });
  }

  ScheduledNotificationsCompanion copyWith({
    Value<int>? id,
    Value<OwnerKind>? ownerKind,
    Value<int>? ownerId,
    Value<int?>? occurrenceId,
    Value<int?>? ruleId,
    Value<DateTime>? fireAt,
    Value<String>? payload,
  }) {
    return ScheduledNotificationsCompanion(
      id: id ?? this.id,
      ownerKind: ownerKind ?? this.ownerKind,
      ownerId: ownerId ?? this.ownerId,
      occurrenceId: occurrenceId ?? this.occurrenceId,
      ruleId: ruleId ?? this.ruleId,
      fireAt: fireAt ?? this.fireAt,
      payload: payload ?? this.payload,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ownerKind.present) {
      map['owner_kind'] = Variable<int>(
        $ScheduledNotificationsTable.$converterownerKind.toSql(ownerKind.value),
      );
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<int>(ownerId.value);
    }
    if (occurrenceId.present) {
      map['occurrence_id'] = Variable<int>(occurrenceId.value);
    }
    if (ruleId.present) {
      map['rule_id'] = Variable<int>(ruleId.value);
    }
    if (fireAt.present) {
      map['fire_at'] = Variable<DateTime>(fireAt.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduledNotificationsCompanion(')
          ..write('id: $id, ')
          ..write('ownerKind: $ownerKind, ')
          ..write('ownerId: $ownerId, ')
          ..write('occurrenceId: $occurrenceId, ')
          ..write('ruleId: $ruleId, ')
          ..write('fireAt: $fireAt, ')
          ..write('payload: $payload')
          ..write(')'))
        .toString();
  }
}

class $DebtsTable extends Debts with TableInfo<$DebtsTable, Debt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebtsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<DebtDirection, int> direction =
      GeneratedColumn<int>(
        'direction',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<DebtDirection>($DebtsTable.$converterdirection);
  static const VerificationMeta _personNameMeta = const VerificationMeta(
    'personName',
  );
  @override
  late final GeneratedColumn<String> personName = GeneratedColumn<String>(
    'person_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalAmountRialMeta = const VerificationMeta(
    'totalAmountRial',
  );
  @override
  late final GeneratedColumn<int> totalAmountRial = GeneratedColumn<int>(
    'total_amount_rial',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt = GeneratedColumn<DateTime>(
    'due_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DebtStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<DebtStatus>($DebtsTable.$converterstatus);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _settledAtMeta = const VerificationMeta(
    'settledAt',
  );
  @override
  late final GeneratedColumn<DateTime> settledAt = GeneratedColumn<DateTime>(
    'settled_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    direction,
    personName,
    title,
    totalAmountRial,
    dueAt,
    note,
    status,
    createdAt,
    settledAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'debts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Debt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('person_name')) {
      context.handle(
        _personNameMeta,
        personName.isAcceptableOrUnknown(data['person_name']!, _personNameMeta),
      );
    } else if (isInserting) {
      context.missing(_personNameMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('total_amount_rial')) {
      context.handle(
        _totalAmountRialMeta,
        totalAmountRial.isAcceptableOrUnknown(
          data['total_amount_rial']!,
          _totalAmountRialMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountRialMeta);
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
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
    if (data.containsKey('settled_at')) {
      context.handle(
        _settledAtMeta,
        settledAt.isAcceptableOrUnknown(data['settled_at']!, _settledAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Debt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Debt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      direction: $DebtsTable.$converterdirection.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}direction'],
        )!,
      ),
      personName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}person_name'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      totalAmountRial: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_amount_rial'],
      )!,
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_at'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      status: $DebtsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      settledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}settled_at'],
      ),
    );
  }

  @override
  $DebtsTable createAlias(String alias) {
    return $DebtsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DebtDirection, int, int> $converterdirection =
      const EnumIndexConverter<DebtDirection>(DebtDirection.values);
  static JsonTypeConverter2<DebtStatus, int, int> $converterstatus =
      const EnumIndexConverter<DebtStatus>(DebtStatus.values);
}

class Debt extends DataClass implements Insertable<Debt> {
  final int id;
  final DebtDirection direction;
  final String personName;
  final String? title;
  final int totalAmountRial;
  final DateTime? dueAt;
  final String? note;
  final DebtStatus status;
  final DateTime createdAt;
  final DateTime? settledAt;
  const Debt({
    required this.id,
    required this.direction,
    required this.personName,
    this.title,
    required this.totalAmountRial,
    this.dueAt,
    this.note,
    required this.status,
    required this.createdAt,
    this.settledAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['direction'] = Variable<int>(
        $DebtsTable.$converterdirection.toSql(direction),
      );
    }
    map['person_name'] = Variable<String>(personName);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['total_amount_rial'] = Variable<int>(totalAmountRial);
    if (!nullToAbsent || dueAt != null) {
      map['due_at'] = Variable<DateTime>(dueAt);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    {
      map['status'] = Variable<int>($DebtsTable.$converterstatus.toSql(status));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || settledAt != null) {
      map['settled_at'] = Variable<DateTime>(settledAt);
    }
    return map;
  }

  DebtsCompanion toCompanion(bool nullToAbsent) {
    return DebtsCompanion(
      id: Value(id),
      direction: Value(direction),
      personName: Value(personName),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      totalAmountRial: Value(totalAmountRial),
      dueAt: dueAt == null && nullToAbsent
          ? const Value.absent()
          : Value(dueAt),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      status: Value(status),
      createdAt: Value(createdAt),
      settledAt: settledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(settledAt),
    );
  }

  factory Debt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Debt(
      id: serializer.fromJson<int>(json['id']),
      direction: $DebtsTable.$converterdirection.fromJson(
        serializer.fromJson<int>(json['direction']),
      ),
      personName: serializer.fromJson<String>(json['personName']),
      title: serializer.fromJson<String?>(json['title']),
      totalAmountRial: serializer.fromJson<int>(json['totalAmountRial']),
      dueAt: serializer.fromJson<DateTime?>(json['dueAt']),
      note: serializer.fromJson<String?>(json['note']),
      status: $DebtsTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      settledAt: serializer.fromJson<DateTime?>(json['settledAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'direction': serializer.toJson<int>(
        $DebtsTable.$converterdirection.toJson(direction),
      ),
      'personName': serializer.toJson<String>(personName),
      'title': serializer.toJson<String?>(title),
      'totalAmountRial': serializer.toJson<int>(totalAmountRial),
      'dueAt': serializer.toJson<DateTime?>(dueAt),
      'note': serializer.toJson<String?>(note),
      'status': serializer.toJson<int>(
        $DebtsTable.$converterstatus.toJson(status),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'settledAt': serializer.toJson<DateTime?>(settledAt),
    };
  }

  Debt copyWith({
    int? id,
    DebtDirection? direction,
    String? personName,
    Value<String?> title = const Value.absent(),
    int? totalAmountRial,
    Value<DateTime?> dueAt = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DebtStatus? status,
    DateTime? createdAt,
    Value<DateTime?> settledAt = const Value.absent(),
  }) => Debt(
    id: id ?? this.id,
    direction: direction ?? this.direction,
    personName: personName ?? this.personName,
    title: title.present ? title.value : this.title,
    totalAmountRial: totalAmountRial ?? this.totalAmountRial,
    dueAt: dueAt.present ? dueAt.value : this.dueAt,
    note: note.present ? note.value : this.note,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    settledAt: settledAt.present ? settledAt.value : this.settledAt,
  );
  Debt copyWithCompanion(DebtsCompanion data) {
    return Debt(
      id: data.id.present ? data.id.value : this.id,
      direction: data.direction.present ? data.direction.value : this.direction,
      personName: data.personName.present
          ? data.personName.value
          : this.personName,
      title: data.title.present ? data.title.value : this.title,
      totalAmountRial: data.totalAmountRial.present
          ? data.totalAmountRial.value
          : this.totalAmountRial,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      note: data.note.present ? data.note.value : this.note,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      settledAt: data.settledAt.present ? data.settledAt.value : this.settledAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Debt(')
          ..write('id: $id, ')
          ..write('direction: $direction, ')
          ..write('personName: $personName, ')
          ..write('title: $title, ')
          ..write('totalAmountRial: $totalAmountRial, ')
          ..write('dueAt: $dueAt, ')
          ..write('note: $note, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('settledAt: $settledAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    direction,
    personName,
    title,
    totalAmountRial,
    dueAt,
    note,
    status,
    createdAt,
    settledAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Debt &&
          other.id == this.id &&
          other.direction == this.direction &&
          other.personName == this.personName &&
          other.title == this.title &&
          other.totalAmountRial == this.totalAmountRial &&
          other.dueAt == this.dueAt &&
          other.note == this.note &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.settledAt == this.settledAt);
}

class DebtsCompanion extends UpdateCompanion<Debt> {
  final Value<int> id;
  final Value<DebtDirection> direction;
  final Value<String> personName;
  final Value<String?> title;
  final Value<int> totalAmountRial;
  final Value<DateTime?> dueAt;
  final Value<String?> note;
  final Value<DebtStatus> status;
  final Value<DateTime> createdAt;
  final Value<DateTime?> settledAt;
  const DebtsCompanion({
    this.id = const Value.absent(),
    this.direction = const Value.absent(),
    this.personName = const Value.absent(),
    this.title = const Value.absent(),
    this.totalAmountRial = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.note = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.settledAt = const Value.absent(),
  });
  DebtsCompanion.insert({
    this.id = const Value.absent(),
    required DebtDirection direction,
    required String personName,
    this.title = const Value.absent(),
    required int totalAmountRial,
    this.dueAt = const Value.absent(),
    this.note = const Value.absent(),
    required DebtStatus status,
    required DateTime createdAt,
    this.settledAt = const Value.absent(),
  }) : direction = Value(direction),
       personName = Value(personName),
       totalAmountRial = Value(totalAmountRial),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<Debt> custom({
    Expression<int>? id,
    Expression<int>? direction,
    Expression<String>? personName,
    Expression<String>? title,
    Expression<int>? totalAmountRial,
    Expression<DateTime>? dueAt,
    Expression<String>? note,
    Expression<int>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? settledAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (direction != null) 'direction': direction,
      if (personName != null) 'person_name': personName,
      if (title != null) 'title': title,
      if (totalAmountRial != null) 'total_amount_rial': totalAmountRial,
      if (dueAt != null) 'due_at': dueAt,
      if (note != null) 'note': note,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (settledAt != null) 'settled_at': settledAt,
    });
  }

  DebtsCompanion copyWith({
    Value<int>? id,
    Value<DebtDirection>? direction,
    Value<String>? personName,
    Value<String?>? title,
    Value<int>? totalAmountRial,
    Value<DateTime?>? dueAt,
    Value<String?>? note,
    Value<DebtStatus>? status,
    Value<DateTime>? createdAt,
    Value<DateTime?>? settledAt,
  }) {
    return DebtsCompanion(
      id: id ?? this.id,
      direction: direction ?? this.direction,
      personName: personName ?? this.personName,
      title: title ?? this.title,
      totalAmountRial: totalAmountRial ?? this.totalAmountRial,
      dueAt: dueAt ?? this.dueAt,
      note: note ?? this.note,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      settledAt: settledAt ?? this.settledAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (direction.present) {
      map['direction'] = Variable<int>(
        $DebtsTable.$converterdirection.toSql(direction.value),
      );
    }
    if (personName.present) {
      map['person_name'] = Variable<String>(personName.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (totalAmountRial.present) {
      map['total_amount_rial'] = Variable<int>(totalAmountRial.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $DebtsTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (settledAt.present) {
      map['settled_at'] = Variable<DateTime>(settledAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DebtsCompanion(')
          ..write('id: $id, ')
          ..write('direction: $direction, ')
          ..write('personName: $personName, ')
          ..write('title: $title, ')
          ..write('totalAmountRial: $totalAmountRial, ')
          ..write('dueAt: $dueAt, ')
          ..write('note: $note, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('settledAt: $settledAt')
          ..write(')'))
        .toString();
  }
}

class $DebtPaymentsTable extends DebtPayments
    with TableInfo<$DebtPaymentsTable, DebtPayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebtPaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _debtIdMeta = const VerificationMeta('debtId');
  @override
  late final GeneratedColumn<int> debtId = GeneratedColumn<int>(
    'debt_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES debts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _amountRialMeta = const VerificationMeta(
    'amountRial',
  );
  @override
  late final GeneratedColumn<int> amountRial = GeneratedColumn<int>(
    'amount_rial',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
    'paid_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<int> transactionId = GeneratedColumn<int>(
    'transaction_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES transactions (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    debtId,
    amountRial,
    paidAt,
    transactionId,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'debt_payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<DebtPayment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('debt_id')) {
      context.handle(
        _debtIdMeta,
        debtId.isAcceptableOrUnknown(data['debt_id']!, _debtIdMeta),
      );
    } else if (isInserting) {
      context.missing(_debtIdMeta);
    }
    if (data.containsKey('amount_rial')) {
      context.handle(
        _amountRialMeta,
        amountRial.isAcceptableOrUnknown(data['amount_rial']!, _amountRialMeta),
      );
    } else if (isInserting) {
      context.missing(_amountRialMeta);
    }
    if (data.containsKey('paid_at')) {
      context.handle(
        _paidAtMeta,
        paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta),
      );
    } else if (isInserting) {
      context.missing(_paidAtMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DebtPayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DebtPayment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      debtId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}debt_id'],
      )!,
      amountRial: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_rial'],
      )!,
      paidAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_at'],
      )!,
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transaction_id'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $DebtPaymentsTable createAlias(String alias) {
    return $DebtPaymentsTable(attachedDatabase, alias);
  }
}

class DebtPayment extends DataClass implements Insertable<DebtPayment> {
  final int id;
  final int debtId;
  final int amountRial;
  final DateTime paidAt;

  /// Set when the payment was recorded from a real transaction.
  final int? transactionId;
  final String? note;
  const DebtPayment({
    required this.id,
    required this.debtId,
    required this.amountRial,
    required this.paidAt,
    this.transactionId,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['debt_id'] = Variable<int>(debtId);
    map['amount_rial'] = Variable<int>(amountRial);
    map['paid_at'] = Variable<DateTime>(paidAt);
    if (!nullToAbsent || transactionId != null) {
      map['transaction_id'] = Variable<int>(transactionId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  DebtPaymentsCompanion toCompanion(bool nullToAbsent) {
    return DebtPaymentsCompanion(
      id: Value(id),
      debtId: Value(debtId),
      amountRial: Value(amountRial),
      paidAt: Value(paidAt),
      transactionId: transactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory DebtPayment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DebtPayment(
      id: serializer.fromJson<int>(json['id']),
      debtId: serializer.fromJson<int>(json['debtId']),
      amountRial: serializer.fromJson<int>(json['amountRial']),
      paidAt: serializer.fromJson<DateTime>(json['paidAt']),
      transactionId: serializer.fromJson<int?>(json['transactionId']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'debtId': serializer.toJson<int>(debtId),
      'amountRial': serializer.toJson<int>(amountRial),
      'paidAt': serializer.toJson<DateTime>(paidAt),
      'transactionId': serializer.toJson<int?>(transactionId),
      'note': serializer.toJson<String?>(note),
    };
  }

  DebtPayment copyWith({
    int? id,
    int? debtId,
    int? amountRial,
    DateTime? paidAt,
    Value<int?> transactionId = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => DebtPayment(
    id: id ?? this.id,
    debtId: debtId ?? this.debtId,
    amountRial: amountRial ?? this.amountRial,
    paidAt: paidAt ?? this.paidAt,
    transactionId: transactionId.present
        ? transactionId.value
        : this.transactionId,
    note: note.present ? note.value : this.note,
  );
  DebtPayment copyWithCompanion(DebtPaymentsCompanion data) {
    return DebtPayment(
      id: data.id.present ? data.id.value : this.id,
      debtId: data.debtId.present ? data.debtId.value : this.debtId,
      amountRial: data.amountRial.present
          ? data.amountRial.value
          : this.amountRial,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DebtPayment(')
          ..write('id: $id, ')
          ..write('debtId: $debtId, ')
          ..write('amountRial: $amountRial, ')
          ..write('paidAt: $paidAt, ')
          ..write('transactionId: $transactionId, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, debtId, amountRial, paidAt, transactionId, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DebtPayment &&
          other.id == this.id &&
          other.debtId == this.debtId &&
          other.amountRial == this.amountRial &&
          other.paidAt == this.paidAt &&
          other.transactionId == this.transactionId &&
          other.note == this.note);
}

class DebtPaymentsCompanion extends UpdateCompanion<DebtPayment> {
  final Value<int> id;
  final Value<int> debtId;
  final Value<int> amountRial;
  final Value<DateTime> paidAt;
  final Value<int?> transactionId;
  final Value<String?> note;
  const DebtPaymentsCompanion({
    this.id = const Value.absent(),
    this.debtId = const Value.absent(),
    this.amountRial = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.note = const Value.absent(),
  });
  DebtPaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int debtId,
    required int amountRial,
    required DateTime paidAt,
    this.transactionId = const Value.absent(),
    this.note = const Value.absent(),
  }) : debtId = Value(debtId),
       amountRial = Value(amountRial),
       paidAt = Value(paidAt);
  static Insertable<DebtPayment> custom({
    Expression<int>? id,
    Expression<int>? debtId,
    Expression<int>? amountRial,
    Expression<DateTime>? paidAt,
    Expression<int>? transactionId,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (debtId != null) 'debt_id': debtId,
      if (amountRial != null) 'amount_rial': amountRial,
      if (paidAt != null) 'paid_at': paidAt,
      if (transactionId != null) 'transaction_id': transactionId,
      if (note != null) 'note': note,
    });
  }

  DebtPaymentsCompanion copyWith({
    Value<int>? id,
    Value<int>? debtId,
    Value<int>? amountRial,
    Value<DateTime>? paidAt,
    Value<int?>? transactionId,
    Value<String?>? note,
  }) {
    return DebtPaymentsCompanion(
      id: id ?? this.id,
      debtId: debtId ?? this.debtId,
      amountRial: amountRial ?? this.amountRial,
      paidAt: paidAt ?? this.paidAt,
      transactionId: transactionId ?? this.transactionId,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (debtId.present) {
      map['debt_id'] = Variable<int>(debtId.value);
    }
    if (amountRial.present) {
      map['amount_rial'] = Variable<int>(amountRial.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<int>(transactionId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DebtPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('debtId: $debtId, ')
          ..write('amountRial: $amountRial, ')
          ..write('paidAt: $paidAt, ')
          ..write('transactionId: $transactionId, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $BudgetsTable extends Budgets with TableInfo<$BudgetsTable, Budget> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _jYearMeta = const VerificationMeta('jYear');
  @override
  late final GeneratedColumn<int> jYear = GeneratedColumn<int>(
    'j_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jMonthMeta = const VerificationMeta('jMonth');
  @override
  late final GeneratedColumn<int> jMonth = GeneratedColumn<int>(
    'j_month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _capAmountRialMeta = const VerificationMeta(
    'capAmountRial',
  );
  @override
  late final GeneratedColumn<int> capAmountRial = GeneratedColumn<int>(
    'cap_amount_rial',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    jYear,
    jMonth,
    categoryId,
    capAmountRial,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budgets';
  @override
  VerificationContext validateIntegrity(
    Insertable<Budget> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('j_year')) {
      context.handle(
        _jYearMeta,
        jYear.isAcceptableOrUnknown(data['j_year']!, _jYearMeta),
      );
    } else if (isInserting) {
      context.missing(_jYearMeta);
    }
    if (data.containsKey('j_month')) {
      context.handle(
        _jMonthMeta,
        jMonth.isAcceptableOrUnknown(data['j_month']!, _jMonthMeta),
      );
    } else if (isInserting) {
      context.missing(_jMonthMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('cap_amount_rial')) {
      context.handle(
        _capAmountRialMeta,
        capAmountRial.isAcceptableOrUnknown(
          data['cap_amount_rial']!,
          _capAmountRialMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_capAmountRialMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {jYear, jMonth, categoryId},
  ];
  @override
  Budget map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Budget(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      jYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}j_year'],
      )!,
      jMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}j_month'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      capAmountRial: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cap_amount_rial'],
      )!,
    );
  }

  @override
  $BudgetsTable createAlias(String alias) {
    return $BudgetsTable(attachedDatabase, alias);
  }
}

class Budget extends DataClass implements Insertable<Budget> {
  final int id;
  final int jYear;
  final int jMonth;

  /// Null means an overall cap for the month rather than a per-category one.
  final int? categoryId;
  final int capAmountRial;
  const Budget({
    required this.id,
    required this.jYear,
    required this.jMonth,
    this.categoryId,
    required this.capAmountRial,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['j_year'] = Variable<int>(jYear);
    map['j_month'] = Variable<int>(jMonth);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    map['cap_amount_rial'] = Variable<int>(capAmountRial);
    return map;
  }

  BudgetsCompanion toCompanion(bool nullToAbsent) {
    return BudgetsCompanion(
      id: Value(id),
      jYear: Value(jYear),
      jMonth: Value(jMonth),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      capAmountRial: Value(capAmountRial),
    );
  }

  factory Budget.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Budget(
      id: serializer.fromJson<int>(json['id']),
      jYear: serializer.fromJson<int>(json['jYear']),
      jMonth: serializer.fromJson<int>(json['jMonth']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      capAmountRial: serializer.fromJson<int>(json['capAmountRial']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jYear': serializer.toJson<int>(jYear),
      'jMonth': serializer.toJson<int>(jMonth),
      'categoryId': serializer.toJson<int?>(categoryId),
      'capAmountRial': serializer.toJson<int>(capAmountRial),
    };
  }

  Budget copyWith({
    int? id,
    int? jYear,
    int? jMonth,
    Value<int?> categoryId = const Value.absent(),
    int? capAmountRial,
  }) => Budget(
    id: id ?? this.id,
    jYear: jYear ?? this.jYear,
    jMonth: jMonth ?? this.jMonth,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    capAmountRial: capAmountRial ?? this.capAmountRial,
  );
  Budget copyWithCompanion(BudgetsCompanion data) {
    return Budget(
      id: data.id.present ? data.id.value : this.id,
      jYear: data.jYear.present ? data.jYear.value : this.jYear,
      jMonth: data.jMonth.present ? data.jMonth.value : this.jMonth,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      capAmountRial: data.capAmountRial.present
          ? data.capAmountRial.value
          : this.capAmountRial,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Budget(')
          ..write('id: $id, ')
          ..write('jYear: $jYear, ')
          ..write('jMonth: $jMonth, ')
          ..write('categoryId: $categoryId, ')
          ..write('capAmountRial: $capAmountRial')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, jYear, jMonth, categoryId, capAmountRial);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Budget &&
          other.id == this.id &&
          other.jYear == this.jYear &&
          other.jMonth == this.jMonth &&
          other.categoryId == this.categoryId &&
          other.capAmountRial == this.capAmountRial);
}

class BudgetsCompanion extends UpdateCompanion<Budget> {
  final Value<int> id;
  final Value<int> jYear;
  final Value<int> jMonth;
  final Value<int?> categoryId;
  final Value<int> capAmountRial;
  const BudgetsCompanion({
    this.id = const Value.absent(),
    this.jYear = const Value.absent(),
    this.jMonth = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.capAmountRial = const Value.absent(),
  });
  BudgetsCompanion.insert({
    this.id = const Value.absent(),
    required int jYear,
    required int jMonth,
    this.categoryId = const Value.absent(),
    required int capAmountRial,
  }) : jYear = Value(jYear),
       jMonth = Value(jMonth),
       capAmountRial = Value(capAmountRial);
  static Insertable<Budget> custom({
    Expression<int>? id,
    Expression<int>? jYear,
    Expression<int>? jMonth,
    Expression<int>? categoryId,
    Expression<int>? capAmountRial,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jYear != null) 'j_year': jYear,
      if (jMonth != null) 'j_month': jMonth,
      if (categoryId != null) 'category_id': categoryId,
      if (capAmountRial != null) 'cap_amount_rial': capAmountRial,
    });
  }

  BudgetsCompanion copyWith({
    Value<int>? id,
    Value<int>? jYear,
    Value<int>? jMonth,
    Value<int?>? categoryId,
    Value<int>? capAmountRial,
  }) {
    return BudgetsCompanion(
      id: id ?? this.id,
      jYear: jYear ?? this.jYear,
      jMonth: jMonth ?? this.jMonth,
      categoryId: categoryId ?? this.categoryId,
      capAmountRial: capAmountRial ?? this.capAmountRial,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jYear.present) {
      map['j_year'] = Variable<int>(jYear.value);
    }
    if (jMonth.present) {
      map['j_month'] = Variable<int>(jMonth.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (capAmountRial.present) {
      map['cap_amount_rial'] = Variable<int>(capAmountRial.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetsCompanion(')
          ..write('id: $id, ')
          ..write('jYear: $jYear, ')
          ..write('jMonth: $jMonth, ')
          ..write('categoryId: $categoryId, ')
          ..write('capAmountRial: $capAmountRial')
          ..write(')'))
        .toString();
  }
}

class $WishesTable extends Wishes with TableInfo<$WishesTable, Wishe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WishesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetAtMeta = const VerificationMeta(
    'targetAt',
  );
  @override
  late final GeneratedColumn<DateTime> targetAt = GeneratedColumn<DateTime>(
    'target_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedCostRialMeta = const VerificationMeta(
    'estimatedCostRial',
  );
  @override
  late final GeneratedColumn<int> estimatedCostRial = GeneratedColumn<int>(
    'estimated_cost_rial',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool> isDone = GeneratedColumn<bool>(
    'is_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    targetAt,
    estimatedCostRial,
    sortOrder,
    isDone,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wishes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Wishe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('target_at')) {
      context.handle(
        _targetAtMeta,
        targetAt.isAcceptableOrUnknown(data['target_at']!, _targetAtMeta),
      );
    }
    if (data.containsKey('estimated_cost_rial')) {
      context.handle(
        _estimatedCostRialMeta,
        estimatedCostRial.isAcceptableOrUnknown(
          data['estimated_cost_rial']!,
          _estimatedCostRialMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('is_done')) {
      context.handle(
        _isDoneMeta,
        isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Wishe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Wishe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      targetAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}target_at'],
      ),
      estimatedCostRial: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_cost_rial'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_done'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WishesTable createAlias(String alias) {
    return $WishesTable(attachedDatabase, alias);
  }
}

class Wishe extends DataClass implements Insertable<Wishe> {
  final int id;
  final String title;
  final String? description;

  /// Optional target date, stored as an instant like every other date.
  final DateTime? targetAt;
  final int? estimatedCostRial;
  final int sortOrder;
  final bool isDone;
  final DateTime createdAt;
  const Wishe({
    required this.id,
    required this.title,
    this.description,
    this.targetAt,
    this.estimatedCostRial,
    required this.sortOrder,
    required this.isDone,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || targetAt != null) {
      map['target_at'] = Variable<DateTime>(targetAt);
    }
    if (!nullToAbsent || estimatedCostRial != null) {
      map['estimated_cost_rial'] = Variable<int>(estimatedCostRial);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_done'] = Variable<bool>(isDone);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WishesCompanion toCompanion(bool nullToAbsent) {
    return WishesCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      targetAt: targetAt == null && nullToAbsent
          ? const Value.absent()
          : Value(targetAt),
      estimatedCostRial: estimatedCostRial == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedCostRial),
      sortOrder: Value(sortOrder),
      isDone: Value(isDone),
      createdAt: Value(createdAt),
    );
  }

  factory Wishe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Wishe(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      targetAt: serializer.fromJson<DateTime?>(json['targetAt']),
      estimatedCostRial: serializer.fromJson<int?>(json['estimatedCostRial']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'targetAt': serializer.toJson<DateTime?>(targetAt),
      'estimatedCostRial': serializer.toJson<int?>(estimatedCostRial),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isDone': serializer.toJson<bool>(isDone),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Wishe copyWith({
    int? id,
    String? title,
    Value<String?> description = const Value.absent(),
    Value<DateTime?> targetAt = const Value.absent(),
    Value<int?> estimatedCostRial = const Value.absent(),
    int? sortOrder,
    bool? isDone,
    DateTime? createdAt,
  }) => Wishe(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    targetAt: targetAt.present ? targetAt.value : this.targetAt,
    estimatedCostRial: estimatedCostRial.present
        ? estimatedCostRial.value
        : this.estimatedCostRial,
    sortOrder: sortOrder ?? this.sortOrder,
    isDone: isDone ?? this.isDone,
    createdAt: createdAt ?? this.createdAt,
  );
  Wishe copyWithCompanion(WishesCompanion data) {
    return Wishe(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      targetAt: data.targetAt.present ? data.targetAt.value : this.targetAt,
      estimatedCostRial: data.estimatedCostRial.present
          ? data.estimatedCostRial.value
          : this.estimatedCostRial,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isDone: data.isDone.present ? data.isDone.value : this.isDone,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Wishe(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('targetAt: $targetAt, ')
          ..write('estimatedCostRial: $estimatedCostRial, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isDone: $isDone, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    targetAt,
    estimatedCostRial,
    sortOrder,
    isDone,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Wishe &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.targetAt == this.targetAt &&
          other.estimatedCostRial == this.estimatedCostRial &&
          other.sortOrder == this.sortOrder &&
          other.isDone == this.isDone &&
          other.createdAt == this.createdAt);
}

class WishesCompanion extends UpdateCompanion<Wishe> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime?> targetAt;
  final Value<int?> estimatedCostRial;
  final Value<int> sortOrder;
  final Value<bool> isDone;
  final Value<DateTime> createdAt;
  const WishesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.targetAt = const Value.absent(),
    this.estimatedCostRial = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isDone = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  WishesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.targetAt = const Value.absent(),
    this.estimatedCostRial = const Value.absent(),
    required int sortOrder,
    this.isDone = const Value.absent(),
    required DateTime createdAt,
  }) : title = Value(title),
       sortOrder = Value(sortOrder),
       createdAt = Value(createdAt);
  static Insertable<Wishe> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? targetAt,
    Expression<int>? estimatedCostRial,
    Expression<int>? sortOrder,
    Expression<bool>? isDone,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (targetAt != null) 'target_at': targetAt,
      if (estimatedCostRial != null) 'estimated_cost_rial': estimatedCostRial,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isDone != null) 'is_done': isDone,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  WishesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<DateTime?>? targetAt,
    Value<int?>? estimatedCostRial,
    Value<int>? sortOrder,
    Value<bool>? isDone,
    Value<DateTime>? createdAt,
  }) {
    return WishesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      targetAt: targetAt ?? this.targetAt,
      estimatedCostRial: estimatedCostRial ?? this.estimatedCostRial,
      sortOrder: sortOrder ?? this.sortOrder,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (targetAt.present) {
      map['target_at'] = Variable<DateTime>(targetAt.value);
    }
    if (estimatedCostRial.present) {
      map['estimated_cost_rial'] = Variable<int>(estimatedCostRial.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WishesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('targetAt: $targetAt, ')
          ..write('estimatedCostRial: $estimatedCostRial, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isDone: $isDone, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WishLinksTable extends WishLinks
    with TableInfo<$WishLinksTable, WishLink> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WishLinksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _wishIdMeta = const VerificationMeta('wishId');
  @override
  late final GeneratedColumn<int> wishId = GeneratedColumn<int>(
    'wish_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES wishes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 80),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, wishId, url, label];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wish_links';
  @override
  VerificationContext validateIntegrity(
    Insertable<WishLink> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('wish_id')) {
      context.handle(
        _wishIdMeta,
        wishId.isAcceptableOrUnknown(data['wish_id']!, _wishIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wishIdMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WishLink map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WishLink(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      wishId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wish_id'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
    );
  }

  @override
  $WishLinksTable createAlias(String alias) {
    return $WishLinksTable(attachedDatabase, alias);
  }
}

class WishLink extends DataClass implements Insertable<WishLink> {
  final int id;
  final int wishId;
  final String url;
  final String? label;
  const WishLink({
    required this.id,
    required this.wishId,
    required this.url,
    this.label,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['wish_id'] = Variable<int>(wishId);
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    return map;
  }

  WishLinksCompanion toCompanion(bool nullToAbsent) {
    return WishLinksCompanion(
      id: Value(id),
      wishId: Value(wishId),
      url: Value(url),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
    );
  }

  factory WishLink.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WishLink(
      id: serializer.fromJson<int>(json['id']),
      wishId: serializer.fromJson<int>(json['wishId']),
      url: serializer.fromJson<String>(json['url']),
      label: serializer.fromJson<String?>(json['label']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wishId': serializer.toJson<int>(wishId),
      'url': serializer.toJson<String>(url),
      'label': serializer.toJson<String?>(label),
    };
  }

  WishLink copyWith({
    int? id,
    int? wishId,
    String? url,
    Value<String?> label = const Value.absent(),
  }) => WishLink(
    id: id ?? this.id,
    wishId: wishId ?? this.wishId,
    url: url ?? this.url,
    label: label.present ? label.value : this.label,
  );
  WishLink copyWithCompanion(WishLinksCompanion data) {
    return WishLink(
      id: data.id.present ? data.id.value : this.id,
      wishId: data.wishId.present ? data.wishId.value : this.wishId,
      url: data.url.present ? data.url.value : this.url,
      label: data.label.present ? data.label.value : this.label,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WishLink(')
          ..write('id: $id, ')
          ..write('wishId: $wishId, ')
          ..write('url: $url, ')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wishId, url, label);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WishLink &&
          other.id == this.id &&
          other.wishId == this.wishId &&
          other.url == this.url &&
          other.label == this.label);
}

class WishLinksCompanion extends UpdateCompanion<WishLink> {
  final Value<int> id;
  final Value<int> wishId;
  final Value<String> url;
  final Value<String?> label;
  const WishLinksCompanion({
    this.id = const Value.absent(),
    this.wishId = const Value.absent(),
    this.url = const Value.absent(),
    this.label = const Value.absent(),
  });
  WishLinksCompanion.insert({
    this.id = const Value.absent(),
    required int wishId,
    required String url,
    this.label = const Value.absent(),
  }) : wishId = Value(wishId),
       url = Value(url);
  static Insertable<WishLink> custom({
    Expression<int>? id,
    Expression<int>? wishId,
    Expression<String>? url,
    Expression<String>? label,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wishId != null) 'wish_id': wishId,
      if (url != null) 'url': url,
      if (label != null) 'label': label,
    });
  }

  WishLinksCompanion copyWith({
    Value<int>? id,
    Value<int>? wishId,
    Value<String>? url,
    Value<String?>? label,
  }) {
    return WishLinksCompanion(
      id: id ?? this.id,
      wishId: wishId ?? this.wishId,
      url: url ?? this.url,
      label: label ?? this.label,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wishId.present) {
      map['wish_id'] = Variable<int>(wishId.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WishLinksCompanion(')
          ..write('id: $id, ')
          ..write('wishId: $wishId, ')
          ..write('url: $url, ')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }
}

class $WishImagesTable extends WishImages
    with TableInfo<$WishImagesTable, WishImage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WishImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _wishIdMeta = const VerificationMeta('wishId');
  @override
  late final GeneratedColumn<int> wishId = GeneratedColumn<int>(
    'wish_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES wishes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _relativePathMeta = const VerificationMeta(
    'relativePath',
  );
  @override
  late final GeneratedColumn<String> relativePath = GeneratedColumn<String>(
    'relative_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, wishId, relativePath, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wish_images';
  @override
  VerificationContext validateIntegrity(
    Insertable<WishImage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('wish_id')) {
      context.handle(
        _wishIdMeta,
        wishId.isAcceptableOrUnknown(data['wish_id']!, _wishIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wishIdMeta);
    }
    if (data.containsKey('relative_path')) {
      context.handle(
        _relativePathMeta,
        relativePath.isAcceptableOrUnknown(
          data['relative_path']!,
          _relativePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relativePathMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WishImage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WishImage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      wishId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wish_id'],
      )!,
      relativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_path'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $WishImagesTable createAlias(String alias) {
    return $WishImagesTable(attachedDatabase, alias);
  }
}

class WishImage extends DataClass implements Insertable<WishImage> {
  final int id;
  final int wishId;

  /// Path relative to the app documents directory.
  final String relativePath;
  final int sortOrder;
  const WishImage({
    required this.id,
    required this.wishId,
    required this.relativePath,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['wish_id'] = Variable<int>(wishId);
    map['relative_path'] = Variable<String>(relativePath);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  WishImagesCompanion toCompanion(bool nullToAbsent) {
    return WishImagesCompanion(
      id: Value(id),
      wishId: Value(wishId),
      relativePath: Value(relativePath),
      sortOrder: Value(sortOrder),
    );
  }

  factory WishImage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WishImage(
      id: serializer.fromJson<int>(json['id']),
      wishId: serializer.fromJson<int>(json['wishId']),
      relativePath: serializer.fromJson<String>(json['relativePath']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wishId': serializer.toJson<int>(wishId),
      'relativePath': serializer.toJson<String>(relativePath),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  WishImage copyWith({
    int? id,
    int? wishId,
    String? relativePath,
    int? sortOrder,
  }) => WishImage(
    id: id ?? this.id,
    wishId: wishId ?? this.wishId,
    relativePath: relativePath ?? this.relativePath,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  WishImage copyWithCompanion(WishImagesCompanion data) {
    return WishImage(
      id: data.id.present ? data.id.value : this.id,
      wishId: data.wishId.present ? data.wishId.value : this.wishId,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WishImage(')
          ..write('id: $id, ')
          ..write('wishId: $wishId, ')
          ..write('relativePath: $relativePath, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wishId, relativePath, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WishImage &&
          other.id == this.id &&
          other.wishId == this.wishId &&
          other.relativePath == this.relativePath &&
          other.sortOrder == this.sortOrder);
}

class WishImagesCompanion extends UpdateCompanion<WishImage> {
  final Value<int> id;
  final Value<int> wishId;
  final Value<String> relativePath;
  final Value<int> sortOrder;
  const WishImagesCompanion({
    this.id = const Value.absent(),
    this.wishId = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  WishImagesCompanion.insert({
    this.id = const Value.absent(),
    required int wishId,
    required String relativePath,
    this.sortOrder = const Value.absent(),
  }) : wishId = Value(wishId),
       relativePath = Value(relativePath);
  static Insertable<WishImage> custom({
    Expression<int>? id,
    Expression<int>? wishId,
    Expression<String>? relativePath,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wishId != null) 'wish_id': wishId,
      if (relativePath != null) 'relative_path': relativePath,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  WishImagesCompanion copyWith({
    Value<int>? id,
    Value<int>? wishId,
    Value<String>? relativePath,
    Value<int>? sortOrder,
  }) {
    return WishImagesCompanion(
      id: id ?? this.id,
      wishId: wishId ?? this.wishId,
      relativePath: relativePath ?? this.relativePath,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wishId.present) {
      map['wish_id'] = Variable<int>(wishId.value);
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WishImagesCompanion(')
          ..write('id: $id, ')
          ..write('wishId: $wishId, ')
          ..write('relativePath: $relativePath, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $RawSmsTable rawSms = $RawSmsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $SmsPatternsTable smsPatterns = $SmsPatternsTable(this);
  late final $RecurringIncomesTable recurringIncomes = $RecurringIncomesTable(
    this,
  );
  late final $RecurringExpensesTable recurringExpenses =
      $RecurringExpensesTable(this);
  late final $RecurringOccurrencesTable recurringOccurrences =
      $RecurringOccurrencesTable(this);
  late final $ReminderRulesTable reminderRules = $ReminderRulesTable(this);
  late final $ScheduledNotificationsTable scheduledNotifications =
      $ScheduledNotificationsTable(this);
  late final $DebtsTable debts = $DebtsTable(this);
  late final $DebtPaymentsTable debtPayments = $DebtPaymentsTable(this);
  late final $BudgetsTable budgets = $BudgetsTable(this);
  late final $WishesTable wishes = $WishesTable(this);
  late final $WishLinksTable wishLinks = $WishLinksTable(this);
  late final $WishImagesTable wishImages = $WishImagesTable(this);
  late final TransactionsDao transactionsDao = TransactionsDao(
    this as AppDatabase,
  );
  late final AccountsDao accountsDao = AccountsDao(this as AppDatabase);
  late final CategoriesDao categoriesDao = CategoriesDao(this as AppDatabase);
  late final SmsPatternsDao smsPatternsDao = SmsPatternsDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    accounts,
    categories,
    rawSms,
    transactions,
    smsPatterns,
    recurringIncomes,
    recurringExpenses,
    recurringOccurrences,
    reminderRules,
    scheduledNotifications,
    debts,
    debtPayments,
    budgets,
    wishes,
    wishLinks,
    wishImages,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transactions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transactions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'raw_sms',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transactions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recurring_incomes', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recurring_incomes', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recurring_expenses', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recurring_expenses', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'transactions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recurring_occurrences', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'debts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('debt_payments', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'transactions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('debt_payments', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('budgets', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'wishes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('wish_links', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'wishes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('wish_images', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$AccountsTableCreateCompanionBuilder =
    AccountsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> bankName,
      Value<String?> accountNoSuffix,
      Value<int> initialBalanceRial,
      Value<int?> lastSmsBalanceRial,
      Value<DateTime?> lastSmsBalanceAt,
      Value<int?> colorValue,
      Value<int> sortOrder,
      Value<bool> isArchived,
      required DateTime createdAt,
    });
typedef $$AccountsTableUpdateCompanionBuilder =
    AccountsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> bankName,
      Value<String?> accountNoSuffix,
      Value<int> initialBalanceRial,
      Value<int?> lastSmsBalanceRial,
      Value<DateTime?> lastSmsBalanceAt,
      Value<int?> colorValue,
      Value<int> sortOrder,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
    });

final class $$AccountsTableReferences
    extends BaseReferences<_$AppDatabase, $AccountsTable, Account> {
  $$AccountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: 'accounts__id__transactions__account_id',
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecurringIncomesTable, List<RecurringIncome>>
  _recurringIncomesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recurringIncomes,
    aliasName: 'accounts__id__recurring_incomes__account_id',
  );

  $$RecurringIncomesTableProcessedTableManager get recurringIncomesRefs {
    final manager = $$RecurringIncomesTableTableManager(
      $_db,
      $_db.recurringIncomes,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recurringIncomesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecurringExpensesTable, List<RecurringExpense>>
  _recurringExpensesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recurringExpenses,
        aliasName: 'accounts__id__recurring_expenses__account_id',
      );

  $$RecurringExpensesTableProcessedTableManager get recurringExpensesRefs {
    final manager = $$RecurringExpensesTableTableManager(
      $_db,
      $_db.recurringExpenses,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recurringExpensesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AccountsTableFilterComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountNoSuffix => $composableBuilder(
    column: $table.accountNoSuffix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get initialBalanceRial => $composableBuilder(
    column: $table.initialBalanceRial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSmsBalanceRial => $composableBuilder(
    column: $table.lastSmsBalanceRial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSmsBalanceAt => $composableBuilder(
    column: $table.lastSmsBalanceAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recurringIncomesRefs(
    Expression<bool> Function($$RecurringIncomesTableFilterComposer f) f,
  ) {
    final $$RecurringIncomesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringIncomes,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringIncomesTableFilterComposer(
            $db: $db,
            $table: $db.recurringIncomes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recurringExpensesRefs(
    Expression<bool> Function($$RecurringExpensesTableFilterComposer f) f,
  ) {
    final $$RecurringExpensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringExpenses,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringExpensesTableFilterComposer(
            $db: $db,
            $table: $db.recurringExpenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountNoSuffix => $composableBuilder(
    column: $table.accountNoSuffix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get initialBalanceRial => $composableBuilder(
    column: $table.initialBalanceRial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSmsBalanceRial => $composableBuilder(
    column: $table.lastSmsBalanceRial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSmsBalanceAt => $composableBuilder(
    column: $table.lastSmsBalanceAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get bankName =>
      $composableBuilder(column: $table.bankName, builder: (column) => column);

  GeneratedColumn<String> get accountNoSuffix => $composableBuilder(
    column: $table.accountNoSuffix,
    builder: (column) => column,
  );

  GeneratedColumn<int> get initialBalanceRial => $composableBuilder(
    column: $table.initialBalanceRial,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastSmsBalanceRial => $composableBuilder(
    column: $table.lastSmsBalanceRial,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSmsBalanceAt => $composableBuilder(
    column: $table.lastSmsBalanceAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recurringIncomesRefs<T extends Object>(
    Expression<T> Function($$RecurringIncomesTableAnnotationComposer a) f,
  ) {
    final $$RecurringIncomesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringIncomes,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringIncomesTableAnnotationComposer(
            $db: $db,
            $table: $db.recurringIncomes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recurringExpensesRefs<T extends Object>(
    Expression<T> Function($$RecurringExpensesTableAnnotationComposer a) f,
  ) {
    final $$RecurringExpensesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recurringExpenses,
          getReferencedColumn: (t) => t.accountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecurringExpensesTableAnnotationComposer(
                $db: $db,
                $table: $db.recurringExpenses,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccountsTable,
          Account,
          $$AccountsTableFilterComposer,
          $$AccountsTableOrderingComposer,
          $$AccountsTableAnnotationComposer,
          $$AccountsTableCreateCompanionBuilder,
          $$AccountsTableUpdateCompanionBuilder,
          (Account, $$AccountsTableReferences),
          Account,
          PrefetchHooks Function({
            bool transactionsRefs,
            bool recurringIncomesRefs,
            bool recurringExpensesRefs,
          })
        > {
  $$AccountsTableTableManager(_$AppDatabase db, $AccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> bankName = const Value.absent(),
                Value<String?> accountNoSuffix = const Value.absent(),
                Value<int> initialBalanceRial = const Value.absent(),
                Value<int?> lastSmsBalanceRial = const Value.absent(),
                Value<DateTime?> lastSmsBalanceAt = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AccountsCompanion(
                id: id,
                name: name,
                bankName: bankName,
                accountNoSuffix: accountNoSuffix,
                initialBalanceRial: initialBalanceRial,
                lastSmsBalanceRial: lastSmsBalanceRial,
                lastSmsBalanceAt: lastSmsBalanceAt,
                colorValue: colorValue,
                sortOrder: sortOrder,
                isArchived: isArchived,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> bankName = const Value.absent(),
                Value<String?> accountNoSuffix = const Value.absent(),
                Value<int> initialBalanceRial = const Value.absent(),
                Value<int?> lastSmsBalanceRial = const Value.absent(),
                Value<DateTime?> lastSmsBalanceAt = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                required DateTime createdAt,
              }) => AccountsCompanion.insert(
                id: id,
                name: name,
                bankName: bankName,
                accountNoSuffix: accountNoSuffix,
                initialBalanceRial: initialBalanceRial,
                lastSmsBalanceRial: lastSmsBalanceRial,
                lastSmsBalanceAt: lastSmsBalanceAt,
                colorValue: colorValue,
                sortOrder: sortOrder,
                isArchived: isArchived,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                transactionsRefs = false,
                recurringIncomesRefs = false,
                recurringExpensesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transactionsRefs) db.transactions,
                    if (recurringIncomesRefs) db.recurringIncomes,
                    if (recurringExpensesRefs) db.recurringExpenses,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (transactionsRefs)
                        await $_getPrefetchedData<
                          Account,
                          $AccountsTable,
                          Transaction
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._transactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recurringIncomesRefs)
                        await $_getPrefetchedData<
                          Account,
                          $AccountsTable,
                          RecurringIncome
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._recurringIncomesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).recurringIncomesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recurringExpensesRefs)
                        await $_getPrefetchedData<
                          Account,
                          $AccountsTable,
                          RecurringExpense
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._recurringExpensesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).recurringExpensesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccountsTable,
      Account,
      $$AccountsTableFilterComposer,
      $$AccountsTableOrderingComposer,
      $$AccountsTableAnnotationComposer,
      $$AccountsTableCreateCompanionBuilder,
      $$AccountsTableUpdateCompanionBuilder,
      (Account, $$AccountsTableReferences),
      Account,
      PrefetchHooks Function({
        bool transactionsRefs,
        bool recurringIncomesRefs,
        bool recurringExpensesRefs,
      })
    >;
typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      required String name,
      required CategoryKind kind,
      Value<int?> iconCode,
      Value<int?> colorValue,
      Value<int> sortOrder,
      Value<bool> isSystem,
      Value<String?> systemKey,
      required DateTime createdAt,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<CategoryKind> kind,
      Value<int?> iconCode,
      Value<int?> colorValue,
      Value<int> sortOrder,
      Value<bool> isSystem,
      Value<String?> systemKey,
      Value<DateTime> createdAt,
    });

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: 'categories__id__transactions__category_id',
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecurringIncomesTable, List<RecurringIncome>>
  _recurringIncomesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recurringIncomes,
    aliasName: 'categories__id__recurring_incomes__category_id',
  );

  $$RecurringIncomesTableProcessedTableManager get recurringIncomesRefs {
    final manager = $$RecurringIncomesTableTableManager(
      $_db,
      $_db.recurringIncomes,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recurringIncomesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecurringExpensesTable, List<RecurringExpense>>
  _recurringExpensesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recurringExpenses,
        aliasName: 'categories__id__recurring_expenses__category_id',
      );

  $$RecurringExpensesTableProcessedTableManager get recurringExpensesRefs {
    final manager = $$RecurringExpensesTableTableManager(
      $_db,
      $_db.recurringExpenses,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recurringExpensesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BudgetsTable, List<Budget>> _budgetsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.budgets,
    aliasName: 'categories__id__budgets__category_id',
  );

  $$BudgetsTableProcessedTableManager get budgetsRefs {
    final manager = $$BudgetsTableTableManager(
      $_db,
      $_db.budgets,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_budgetsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CategoryKind, CategoryKind, int> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get iconCode => $composableBuilder(
    column: $table.iconCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get systemKey => $composableBuilder(
    column: $table.systemKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recurringIncomesRefs(
    Expression<bool> Function($$RecurringIncomesTableFilterComposer f) f,
  ) {
    final $$RecurringIncomesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringIncomes,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringIncomesTableFilterComposer(
            $db: $db,
            $table: $db.recurringIncomes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recurringExpensesRefs(
    Expression<bool> Function($$RecurringExpensesTableFilterComposer f) f,
  ) {
    final $$RecurringExpensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringExpenses,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringExpensesTableFilterComposer(
            $db: $db,
            $table: $db.recurringExpenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> budgetsRefs(
    Expression<bool> Function($$BudgetsTableFilterComposer f) f,
  ) {
    final $$BudgetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgets,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetsTableFilterComposer(
            $db: $db,
            $table: $db.budgets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get iconCode => $composableBuilder(
    column: $table.iconCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get systemKey => $composableBuilder(
    column: $table.systemKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CategoryKind, int> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get iconCode =>
      $composableBuilder(column: $table.iconCode, builder: (column) => column);

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  GeneratedColumn<String> get systemKey =>
      $composableBuilder(column: $table.systemKey, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recurringIncomesRefs<T extends Object>(
    Expression<T> Function($$RecurringIncomesTableAnnotationComposer a) f,
  ) {
    final $$RecurringIncomesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringIncomes,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringIncomesTableAnnotationComposer(
            $db: $db,
            $table: $db.recurringIncomes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recurringExpensesRefs<T extends Object>(
    Expression<T> Function($$RecurringExpensesTableAnnotationComposer a) f,
  ) {
    final $$RecurringExpensesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recurringExpenses,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecurringExpensesTableAnnotationComposer(
                $db: $db,
                $table: $db.recurringExpenses,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> budgetsRefs<T extends Object>(
    Expression<T> Function($$BudgetsTableAnnotationComposer a) f,
  ) {
    final $$BudgetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgets,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetsTableAnnotationComposer(
            $db: $db,
            $table: $db.budgets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, $$CategoriesTableReferences),
          Category,
          PrefetchHooks Function({
            bool transactionsRefs,
            bool recurringIncomesRefs,
            bool recurringExpensesRefs,
            bool budgetsRefs,
          })
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<CategoryKind> kind = const Value.absent(),
                Value<int?> iconCode = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<String?> systemKey = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                kind: kind,
                iconCode: iconCode,
                colorValue: colorValue,
                sortOrder: sortOrder,
                isSystem: isSystem,
                systemKey: systemKey,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required CategoryKind kind,
                Value<int?> iconCode = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<String?> systemKey = const Value.absent(),
                required DateTime createdAt,
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                kind: kind,
                iconCode: iconCode,
                colorValue: colorValue,
                sortOrder: sortOrder,
                isSystem: isSystem,
                systemKey: systemKey,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                transactionsRefs = false,
                recurringIncomesRefs = false,
                recurringExpensesRefs = false,
                budgetsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transactionsRefs) db.transactions,
                    if (recurringIncomesRefs) db.recurringIncomes,
                    if (recurringExpensesRefs) db.recurringExpenses,
                    if (budgetsRefs) db.budgets,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (transactionsRefs)
                        await $_getPrefetchedData<
                          Category,
                          $CategoriesTable,
                          Transaction
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._transactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recurringIncomesRefs)
                        await $_getPrefetchedData<
                          Category,
                          $CategoriesTable,
                          RecurringIncome
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._recurringIncomesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).recurringIncomesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recurringExpensesRefs)
                        await $_getPrefetchedData<
                          Category,
                          $CategoriesTable,
                          RecurringExpense
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._recurringExpensesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).recurringExpensesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (budgetsRefs)
                        await $_getPrefetchedData<
                          Category,
                          $CategoriesTable,
                          Budget
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._budgetsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).budgetsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, $$CategoriesTableReferences),
      Category,
      PrefetchHooks Function({
        bool transactionsRefs,
        bool recurringIncomesRefs,
        bool recurringExpensesRefs,
        bool budgetsRefs,
      })
    >;
typedef $$RawSmsTableCreateCompanionBuilder =
    RawSmsCompanion Function({
      Value<int> id,
      required String sender,
      required String body,
      required DateTime receivedAt,
      required SmsParseStatus parseStatus,
      Value<int?> matchedPatternId,
    });
typedef $$RawSmsTableUpdateCompanionBuilder =
    RawSmsCompanion Function({
      Value<int> id,
      Value<String> sender,
      Value<String> body,
      Value<DateTime> receivedAt,
      Value<SmsParseStatus> parseStatus,
      Value<int?> matchedPatternId,
    });

final class $$RawSmsTableReferences
    extends BaseReferences<_$AppDatabase, $RawSmsTable, RawSm> {
  $$RawSmsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: 'raw_sms__id__transactions__raw_sms_id',
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.rawSmsId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RawSmsTableFilterComposer
    extends Composer<_$AppDatabase, $RawSmsTable> {
  $$RawSmsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sender => $composableBuilder(
    column: $table.sender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SmsParseStatus, SmsParseStatus, int>
  get parseStatus => $composableBuilder(
    column: $table.parseStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get matchedPatternId => $composableBuilder(
    column: $table.matchedPatternId,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.rawSmsId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RawSmsTableOrderingComposer
    extends Composer<_$AppDatabase, $RawSmsTable> {
  $$RawSmsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sender => $composableBuilder(
    column: $table.sender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get parseStatus => $composableBuilder(
    column: $table.parseStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get matchedPatternId => $composableBuilder(
    column: $table.matchedPatternId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RawSmsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RawSmsTable> {
  $$RawSmsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sender =>
      $composableBuilder(column: $table.sender, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SmsParseStatus, int> get parseStatus =>
      $composableBuilder(
        column: $table.parseStatus,
        builder: (column) => column,
      );

  GeneratedColumn<int> get matchedPatternId => $composableBuilder(
    column: $table.matchedPatternId,
    builder: (column) => column,
  );

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.rawSmsId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RawSmsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RawSmsTable,
          RawSm,
          $$RawSmsTableFilterComposer,
          $$RawSmsTableOrderingComposer,
          $$RawSmsTableAnnotationComposer,
          $$RawSmsTableCreateCompanionBuilder,
          $$RawSmsTableUpdateCompanionBuilder,
          (RawSm, $$RawSmsTableReferences),
          RawSm,
          PrefetchHooks Function({bool transactionsRefs})
        > {
  $$RawSmsTableTableManager(_$AppDatabase db, $RawSmsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RawSmsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RawSmsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RawSmsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sender = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<DateTime> receivedAt = const Value.absent(),
                Value<SmsParseStatus> parseStatus = const Value.absent(),
                Value<int?> matchedPatternId = const Value.absent(),
              }) => RawSmsCompanion(
                id: id,
                sender: sender,
                body: body,
                receivedAt: receivedAt,
                parseStatus: parseStatus,
                matchedPatternId: matchedPatternId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sender,
                required String body,
                required DateTime receivedAt,
                required SmsParseStatus parseStatus,
                Value<int?> matchedPatternId = const Value.absent(),
              }) => RawSmsCompanion.insert(
                id: id,
                sender: sender,
                body: body,
                receivedAt: receivedAt,
                parseStatus: parseStatus,
                matchedPatternId: matchedPatternId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$RawSmsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transactionsRefs) db.transactions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsRefs)
                    await $_getPrefetchedData<RawSm, $RawSmsTable, Transaction>(
                      currentTable: table,
                      referencedTable: $$RawSmsTableReferences
                          ._transactionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$RawSmsTableReferences(
                        db,
                        table,
                        p0,
                      ).transactionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.rawSmsId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RawSmsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RawSmsTable,
      RawSm,
      $$RawSmsTableFilterComposer,
      $$RawSmsTableOrderingComposer,
      $$RawSmsTableAnnotationComposer,
      $$RawSmsTableCreateCompanionBuilder,
      $$RawSmsTableUpdateCompanionBuilder,
      (RawSm, $$RawSmsTableReferences),
      RawSm,
      PrefetchHooks Function({bool transactionsRefs})
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      Value<int?> accountId,
      Value<int?> categoryId,
      required TxnType type,
      required int amountRial,
      required DateTime occurredAt,
      required int jYear,
      required int jMonth,
      Value<String?> note,
      required TxnStatus status,
      required TxnSource source,
      Value<int?> rawSmsId,
      Value<int?> balanceAfterRial,
      Value<DateTime?> confirmedAt,
      required DateTime createdAt,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      Value<int?> accountId,
      Value<int?> categoryId,
      Value<TxnType> type,
      Value<int> amountRial,
      Value<DateTime> occurredAt,
      Value<int> jYear,
      Value<int> jMonth,
      Value<String?> note,
      Value<TxnStatus> status,
      Value<TxnSource> source,
      Value<int?> rawSmsId,
      Value<int?> balanceAfterRial,
      Value<DateTime?> confirmedAt,
      Value<DateTime> createdAt,
    });

final class $$TransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $TransactionsTable, Transaction> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('transactions__account_id__accounts__id');

  $$AccountsTableProcessedTableManager? get accountId {
    final $_column = $_itemColumn<int>('account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('transactions__category_id__categories__id');

  $$CategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RawSmsTable _rawSmsIdTable(_$AppDatabase db) =>
      db.rawSms.createAlias('transactions__raw_sms_id__raw_sms__id');

  $$RawSmsTableProcessedTableManager? get rawSmsId {
    final $_column = $_itemColumn<int>('raw_sms_id');
    if ($_column == null) return null;
    final manager = $$RawSmsTableTableManager(
      $_db,
      $_db.rawSms,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_rawSmsIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $RecurringOccurrencesTable,
    List<RecurringOccurrence>
  >
  _recurringOccurrencesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recurringOccurrences,
        aliasName: 'transactions__id__recurring_occurrences__transaction_id',
      );

  $$RecurringOccurrencesTableProcessedTableManager
  get recurringOccurrencesRefs {
    final manager = $$RecurringOccurrencesTableTableManager(
      $_db,
      $_db.recurringOccurrences,
    ).filter((f) => f.transactionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recurringOccurrencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DebtPaymentsTable, List<DebtPayment>>
  _debtPaymentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.debtPayments,
    aliasName: 'transactions__id__debt_payments__transaction_id',
  );

  $$DebtPaymentsTableProcessedTableManager get debtPaymentsRefs {
    final manager = $$DebtPaymentsTableTableManager(
      $_db,
      $_db.debtPayments,
    ).filter((f) => f.transactionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_debtPaymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TxnType, TxnType, int> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get amountRial => $composableBuilder(
    column: $table.amountRial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jYear => $composableBuilder(
    column: $table.jYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jMonth => $composableBuilder(
    column: $table.jMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TxnStatus, TxnStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<TxnSource, TxnSource, int> get source =>
      $composableBuilder(
        column: $table.source,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get balanceAfterRial => $composableBuilder(
    column: $table.balanceAfterRial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get confirmedAt => $composableBuilder(
    column: $table.confirmedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RawSmsTableFilterComposer get rawSmsId {
    final $$RawSmsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rawSmsId,
      referencedTable: $db.rawSms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RawSmsTableFilterComposer(
            $db: $db,
            $table: $db.rawSms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> recurringOccurrencesRefs(
    Expression<bool> Function($$RecurringOccurrencesTableFilterComposer f) f,
  ) {
    final $$RecurringOccurrencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringOccurrences,
      getReferencedColumn: (t) => t.transactionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringOccurrencesTableFilterComposer(
            $db: $db,
            $table: $db.recurringOccurrences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> debtPaymentsRefs(
    Expression<bool> Function($$DebtPaymentsTableFilterComposer f) f,
  ) {
    final $$DebtPaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.debtPayments,
      getReferencedColumn: (t) => t.transactionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtPaymentsTableFilterComposer(
            $db: $db,
            $table: $db.debtPayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountRial => $composableBuilder(
    column: $table.amountRial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jYear => $composableBuilder(
    column: $table.jYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jMonth => $composableBuilder(
    column: $table.jMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get balanceAfterRial => $composableBuilder(
    column: $table.balanceAfterRial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get confirmedAt => $composableBuilder(
    column: $table.confirmedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RawSmsTableOrderingComposer get rawSmsId {
    final $$RawSmsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rawSmsId,
      referencedTable: $db.rawSms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RawSmsTableOrderingComposer(
            $db: $db,
            $table: $db.rawSms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TxnType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get amountRial => $composableBuilder(
    column: $table.amountRial,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get jYear =>
      $composableBuilder(column: $table.jYear, builder: (column) => column);

  GeneratedColumn<int> get jMonth =>
      $composableBuilder(column: $table.jMonth, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TxnStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TxnSource, int> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get balanceAfterRial => $composableBuilder(
    column: $table.balanceAfterRial,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get confirmedAt => $composableBuilder(
    column: $table.confirmedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RawSmsTableAnnotationComposer get rawSmsId {
    final $$RawSmsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rawSmsId,
      referencedTable: $db.rawSms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RawSmsTableAnnotationComposer(
            $db: $db,
            $table: $db.rawSms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> recurringOccurrencesRefs<T extends Object>(
    Expression<T> Function($$RecurringOccurrencesTableAnnotationComposer a) f,
  ) {
    final $$RecurringOccurrencesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recurringOccurrences,
          getReferencedColumn: (t) => t.transactionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecurringOccurrencesTableAnnotationComposer(
                $db: $db,
                $table: $db.recurringOccurrences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> debtPaymentsRefs<T extends Object>(
    Expression<T> Function($$DebtPaymentsTableAnnotationComposer a) f,
  ) {
    final $$DebtPaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.debtPayments,
      getReferencedColumn: (t) => t.transactionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtPaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.debtPayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          Transaction,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (Transaction, $$TransactionsTableReferences),
          Transaction,
          PrefetchHooks Function({
            bool accountId,
            bool categoryId,
            bool rawSmsId,
            bool recurringOccurrencesRefs,
            bool debtPaymentsRefs,
          })
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> accountId = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<TxnType> type = const Value.absent(),
                Value<int> amountRial = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<int> jYear = const Value.absent(),
                Value<int> jMonth = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<TxnStatus> status = const Value.absent(),
                Value<TxnSource> source = const Value.absent(),
                Value<int?> rawSmsId = const Value.absent(),
                Value<int?> balanceAfterRial = const Value.absent(),
                Value<DateTime?> confirmedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                accountId: accountId,
                categoryId: categoryId,
                type: type,
                amountRial: amountRial,
                occurredAt: occurredAt,
                jYear: jYear,
                jMonth: jMonth,
                note: note,
                status: status,
                source: source,
                rawSmsId: rawSmsId,
                balanceAfterRial: balanceAfterRial,
                confirmedAt: confirmedAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> accountId = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                required TxnType type,
                required int amountRial,
                required DateTime occurredAt,
                required int jYear,
                required int jMonth,
                Value<String?> note = const Value.absent(),
                required TxnStatus status,
                required TxnSource source,
                Value<int?> rawSmsId = const Value.absent(),
                Value<int?> balanceAfterRial = const Value.absent(),
                Value<DateTime?> confirmedAt = const Value.absent(),
                required DateTime createdAt,
              }) => TransactionsCompanion.insert(
                id: id,
                accountId: accountId,
                categoryId: categoryId,
                type: type,
                amountRial: amountRial,
                occurredAt: occurredAt,
                jYear: jYear,
                jMonth: jMonth,
                note: note,
                status: status,
                source: source,
                rawSmsId: rawSmsId,
                balanceAfterRial: balanceAfterRial,
                confirmedAt: confirmedAt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                accountId = false,
                categoryId = false,
                rawSmsId = false,
                recurringOccurrencesRefs = false,
                debtPaymentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recurringOccurrencesRefs) db.recurringOccurrences,
                    if (debtPaymentsRefs) db.debtPayments,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (accountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.accountId,
                                    referencedTable:
                                        $$TransactionsTableReferences
                                            ._accountIdTable(db),
                                    referencedColumn:
                                        $$TransactionsTableReferences
                                            ._accountIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable:
                                        $$TransactionsTableReferences
                                            ._categoryIdTable(db),
                                    referencedColumn:
                                        $$TransactionsTableReferences
                                            ._categoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (rawSmsId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.rawSmsId,
                                    referencedTable:
                                        $$TransactionsTableReferences
                                            ._rawSmsIdTable(db),
                                    referencedColumn:
                                        $$TransactionsTableReferences
                                            ._rawSmsIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recurringOccurrencesRefs)
                        await $_getPrefetchedData<
                          Transaction,
                          $TransactionsTable,
                          RecurringOccurrence
                        >(
                          currentTable: table,
                          referencedTable: $$TransactionsTableReferences
                              ._recurringOccurrencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TransactionsTableReferences(
                                db,
                                table,
                                p0,
                              ).recurringOccurrencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.transactionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (debtPaymentsRefs)
                        await $_getPrefetchedData<
                          Transaction,
                          $TransactionsTable,
                          DebtPayment
                        >(
                          currentTable: table,
                          referencedTable: $$TransactionsTableReferences
                              ._debtPaymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TransactionsTableReferences(
                                db,
                                table,
                                p0,
                              ).debtPaymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.transactionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      Transaction,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (Transaction, $$TransactionsTableReferences),
      Transaction,
      PrefetchHooks Function({
        bool accountId,
        bool categoryId,
        bool rawSmsId,
        bool recurringOccurrencesRefs,
        bool debtPaymentsRefs,
      })
    >;
typedef $$SmsPatternsTableCreateCompanionBuilder =
    SmsPatternsCompanion Function({
      Value<int> id,
      required String bankName,
      required String senderNumbers,
      required String depositKeywords,
      required String withdrawalKeywords,
      required String amountRegex,
      Value<String?> balanceRegex,
      Value<String?> accountRefRegex,
      required SmsAmountUnit amountUnit,
      Value<int> priority,
      Value<bool> isEnabled,
      Value<bool> isBuiltIn,
    });
typedef $$SmsPatternsTableUpdateCompanionBuilder =
    SmsPatternsCompanion Function({
      Value<int> id,
      Value<String> bankName,
      Value<String> senderNumbers,
      Value<String> depositKeywords,
      Value<String> withdrawalKeywords,
      Value<String> amountRegex,
      Value<String?> balanceRegex,
      Value<String?> accountRefRegex,
      Value<SmsAmountUnit> amountUnit,
      Value<int> priority,
      Value<bool> isEnabled,
      Value<bool> isBuiltIn,
    });

class $$SmsPatternsTableFilterComposer
    extends Composer<_$AppDatabase, $SmsPatternsTable> {
  $$SmsPatternsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderNumbers => $composableBuilder(
    column: $table.senderNumbers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get depositKeywords => $composableBuilder(
    column: $table.depositKeywords,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get withdrawalKeywords => $composableBuilder(
    column: $table.withdrawalKeywords,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get amountRegex => $composableBuilder(
    column: $table.amountRegex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get balanceRegex => $composableBuilder(
    column: $table.balanceRegex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountRefRegex => $composableBuilder(
    column: $table.accountRefRegex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SmsAmountUnit, SmsAmountUnit, int>
  get amountUnit => $composableBuilder(
    column: $table.amountUnit,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SmsPatternsTableOrderingComposer
    extends Composer<_$AppDatabase, $SmsPatternsTable> {
  $$SmsPatternsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderNumbers => $composableBuilder(
    column: $table.senderNumbers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get depositKeywords => $composableBuilder(
    column: $table.depositKeywords,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get withdrawalKeywords => $composableBuilder(
    column: $table.withdrawalKeywords,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get amountRegex => $composableBuilder(
    column: $table.amountRegex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get balanceRegex => $composableBuilder(
    column: $table.balanceRegex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountRefRegex => $composableBuilder(
    column: $table.accountRefRegex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountUnit => $composableBuilder(
    column: $table.amountUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SmsPatternsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SmsPatternsTable> {
  $$SmsPatternsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bankName =>
      $composableBuilder(column: $table.bankName, builder: (column) => column);

  GeneratedColumn<String> get senderNumbers => $composableBuilder(
    column: $table.senderNumbers,
    builder: (column) => column,
  );

  GeneratedColumn<String> get depositKeywords => $composableBuilder(
    column: $table.depositKeywords,
    builder: (column) => column,
  );

  GeneratedColumn<String> get withdrawalKeywords => $composableBuilder(
    column: $table.withdrawalKeywords,
    builder: (column) => column,
  );

  GeneratedColumn<String> get amountRegex => $composableBuilder(
    column: $table.amountRegex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get balanceRegex => $composableBuilder(
    column: $table.balanceRegex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accountRefRegex => $composableBuilder(
    column: $table.accountRefRegex,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SmsAmountUnit, int> get amountUnit =>
      $composableBuilder(
        column: $table.amountUnit,
        builder: (column) => column,
      );

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);
}

class $$SmsPatternsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SmsPatternsTable,
          SmsPattern,
          $$SmsPatternsTableFilterComposer,
          $$SmsPatternsTableOrderingComposer,
          $$SmsPatternsTableAnnotationComposer,
          $$SmsPatternsTableCreateCompanionBuilder,
          $$SmsPatternsTableUpdateCompanionBuilder,
          (
            SmsPattern,
            BaseReferences<_$AppDatabase, $SmsPatternsTable, SmsPattern>,
          ),
          SmsPattern,
          PrefetchHooks Function()
        > {
  $$SmsPatternsTableTableManager(_$AppDatabase db, $SmsPatternsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SmsPatternsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SmsPatternsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SmsPatternsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> bankName = const Value.absent(),
                Value<String> senderNumbers = const Value.absent(),
                Value<String> depositKeywords = const Value.absent(),
                Value<String> withdrawalKeywords = const Value.absent(),
                Value<String> amountRegex = const Value.absent(),
                Value<String?> balanceRegex = const Value.absent(),
                Value<String?> accountRefRegex = const Value.absent(),
                Value<SmsAmountUnit> amountUnit = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
              }) => SmsPatternsCompanion(
                id: id,
                bankName: bankName,
                senderNumbers: senderNumbers,
                depositKeywords: depositKeywords,
                withdrawalKeywords: withdrawalKeywords,
                amountRegex: amountRegex,
                balanceRegex: balanceRegex,
                accountRefRegex: accountRefRegex,
                amountUnit: amountUnit,
                priority: priority,
                isEnabled: isEnabled,
                isBuiltIn: isBuiltIn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String bankName,
                required String senderNumbers,
                required String depositKeywords,
                required String withdrawalKeywords,
                required String amountRegex,
                Value<String?> balanceRegex = const Value.absent(),
                Value<String?> accountRefRegex = const Value.absent(),
                required SmsAmountUnit amountUnit,
                Value<int> priority = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
              }) => SmsPatternsCompanion.insert(
                id: id,
                bankName: bankName,
                senderNumbers: senderNumbers,
                depositKeywords: depositKeywords,
                withdrawalKeywords: withdrawalKeywords,
                amountRegex: amountRegex,
                balanceRegex: balanceRegex,
                accountRefRegex: accountRefRegex,
                amountUnit: amountUnit,
                priority: priority,
                isEnabled: isEnabled,
                isBuiltIn: isBuiltIn,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SmsPatternsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SmsPatternsTable,
      SmsPattern,
      $$SmsPatternsTableFilterComposer,
      $$SmsPatternsTableOrderingComposer,
      $$SmsPatternsTableAnnotationComposer,
      $$SmsPatternsTableCreateCompanionBuilder,
      $$SmsPatternsTableUpdateCompanionBuilder,
      (
        SmsPattern,
        BaseReferences<_$AppDatabase, $SmsPatternsTable, SmsPattern>,
      ),
      SmsPattern,
      PrefetchHooks Function()
    >;
typedef $$RecurringIncomesTableCreateCompanionBuilder =
    RecurringIncomesCompanion Function({
      Value<int> id,
      required String title,
      required int amountRial,
      Value<int?> categoryId,
      Value<int?> accountId,
      required int jDay,
      required int startJYear,
      required int startJMonth,
      Value<int?> endJYear,
      Value<int?> endJMonth,
      Value<String?> note,
      Value<bool> isActive,
      required DateTime createdAt,
    });
typedef $$RecurringIncomesTableUpdateCompanionBuilder =
    RecurringIncomesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<int> amountRial,
      Value<int?> categoryId,
      Value<int?> accountId,
      Value<int> jDay,
      Value<int> startJYear,
      Value<int> startJMonth,
      Value<int?> endJYear,
      Value<int?> endJMonth,
      Value<String?> note,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });

final class $$RecurringIncomesTableReferences
    extends
        BaseReferences<_$AppDatabase, $RecurringIncomesTable, RecurringIncome> {
  $$RecurringIncomesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) => db.categories
      .createAlias('recurring_incomes__category_id__categories__id');

  $$CategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('recurring_incomes__account_id__accounts__id');

  $$AccountsTableProcessedTableManager? get accountId {
    final $_column = $_itemColumn<int>('account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecurringIncomesTableFilterComposer
    extends Composer<_$AppDatabase, $RecurringIncomesTable> {
  $$RecurringIncomesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountRial => $composableBuilder(
    column: $table.amountRial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jDay => $composableBuilder(
    column: $table.jDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startJYear => $composableBuilder(
    column: $table.startJYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startJMonth => $composableBuilder(
    column: $table.startJMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endJYear => $composableBuilder(
    column: $table.endJYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endJMonth => $composableBuilder(
    column: $table.endJMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringIncomesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecurringIncomesTable> {
  $$RecurringIncomesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountRial => $composableBuilder(
    column: $table.amountRial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jDay => $composableBuilder(
    column: $table.jDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startJYear => $composableBuilder(
    column: $table.startJYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startJMonth => $composableBuilder(
    column: $table.startJMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endJYear => $composableBuilder(
    column: $table.endJYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endJMonth => $composableBuilder(
    column: $table.endJMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringIncomesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecurringIncomesTable> {
  $$RecurringIncomesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get amountRial => $composableBuilder(
    column: $table.amountRial,
    builder: (column) => column,
  );

  GeneratedColumn<int> get jDay =>
      $composableBuilder(column: $table.jDay, builder: (column) => column);

  GeneratedColumn<int> get startJYear => $composableBuilder(
    column: $table.startJYear,
    builder: (column) => column,
  );

  GeneratedColumn<int> get startJMonth => $composableBuilder(
    column: $table.startJMonth,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endJYear =>
      $composableBuilder(column: $table.endJYear, builder: (column) => column);

  GeneratedColumn<int> get endJMonth =>
      $composableBuilder(column: $table.endJMonth, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringIncomesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecurringIncomesTable,
          RecurringIncome,
          $$RecurringIncomesTableFilterComposer,
          $$RecurringIncomesTableOrderingComposer,
          $$RecurringIncomesTableAnnotationComposer,
          $$RecurringIncomesTableCreateCompanionBuilder,
          $$RecurringIncomesTableUpdateCompanionBuilder,
          (RecurringIncome, $$RecurringIncomesTableReferences),
          RecurringIncome,
          PrefetchHooks Function({bool categoryId, bool accountId})
        > {
  $$RecurringIncomesTableTableManager(
    _$AppDatabase db,
    $RecurringIncomesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecurringIncomesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecurringIncomesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecurringIncomesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> amountRial = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<int?> accountId = const Value.absent(),
                Value<int> jDay = const Value.absent(),
                Value<int> startJYear = const Value.absent(),
                Value<int> startJMonth = const Value.absent(),
                Value<int?> endJYear = const Value.absent(),
                Value<int?> endJMonth = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RecurringIncomesCompanion(
                id: id,
                title: title,
                amountRial: amountRial,
                categoryId: categoryId,
                accountId: accountId,
                jDay: jDay,
                startJYear: startJYear,
                startJMonth: startJMonth,
                endJYear: endJYear,
                endJMonth: endJMonth,
                note: note,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required int amountRial,
                Value<int?> categoryId = const Value.absent(),
                Value<int?> accountId = const Value.absent(),
                required int jDay,
                required int startJYear,
                required int startJMonth,
                Value<int?> endJYear = const Value.absent(),
                Value<int?> endJMonth = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
              }) => RecurringIncomesCompanion.insert(
                id: id,
                title: title,
                amountRial: amountRial,
                categoryId: categoryId,
                accountId: accountId,
                jDay: jDay,
                startJYear: startJYear,
                startJMonth: startJMonth,
                endJYear: endJYear,
                endJMonth: endJMonth,
                note: note,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecurringIncomesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false, accountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable:
                                    $$RecurringIncomesTableReferences
                                        ._categoryIdTable(db),
                                referencedColumn:
                                    $$RecurringIncomesTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (accountId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.accountId,
                                referencedTable:
                                    $$RecurringIncomesTableReferences
                                        ._accountIdTable(db),
                                referencedColumn:
                                    $$RecurringIncomesTableReferences
                                        ._accountIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecurringIncomesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecurringIncomesTable,
      RecurringIncome,
      $$RecurringIncomesTableFilterComposer,
      $$RecurringIncomesTableOrderingComposer,
      $$RecurringIncomesTableAnnotationComposer,
      $$RecurringIncomesTableCreateCompanionBuilder,
      $$RecurringIncomesTableUpdateCompanionBuilder,
      (RecurringIncome, $$RecurringIncomesTableReferences),
      RecurringIncome,
      PrefetchHooks Function({bool categoryId, bool accountId})
    >;
typedef $$RecurringExpensesTableCreateCompanionBuilder =
    RecurringExpensesCompanion Function({
      Value<int> id,
      required String title,
      required int amountRial,
      Value<int?> categoryId,
      Value<int?> accountId,
      required int jDay,
      required int startJYear,
      required int startJMonth,
      Value<int?> endJYear,
      Value<int?> endJMonth,
      Value<String?> note,
      Value<bool> isActive,
      required DateTime createdAt,
    });
typedef $$RecurringExpensesTableUpdateCompanionBuilder =
    RecurringExpensesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<int> amountRial,
      Value<int?> categoryId,
      Value<int?> accountId,
      Value<int> jDay,
      Value<int> startJYear,
      Value<int> startJMonth,
      Value<int?> endJYear,
      Value<int?> endJMonth,
      Value<String?> note,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });

final class $$RecurringExpensesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecurringExpensesTable,
          RecurringExpense
        > {
  $$RecurringExpensesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) => db.categories
      .createAlias('recurring_expenses__category_id__categories__id');

  $$CategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('recurring_expenses__account_id__accounts__id');

  $$AccountsTableProcessedTableManager? get accountId {
    final $_column = $_itemColumn<int>('account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecurringExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $RecurringExpensesTable> {
  $$RecurringExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountRial => $composableBuilder(
    column: $table.amountRial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jDay => $composableBuilder(
    column: $table.jDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startJYear => $composableBuilder(
    column: $table.startJYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startJMonth => $composableBuilder(
    column: $table.startJMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endJYear => $composableBuilder(
    column: $table.endJYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endJMonth => $composableBuilder(
    column: $table.endJMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecurringExpensesTable> {
  $$RecurringExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountRial => $composableBuilder(
    column: $table.amountRial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jDay => $composableBuilder(
    column: $table.jDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startJYear => $composableBuilder(
    column: $table.startJYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startJMonth => $composableBuilder(
    column: $table.startJMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endJYear => $composableBuilder(
    column: $table.endJYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endJMonth => $composableBuilder(
    column: $table.endJMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecurringExpensesTable> {
  $$RecurringExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get amountRial => $composableBuilder(
    column: $table.amountRial,
    builder: (column) => column,
  );

  GeneratedColumn<int> get jDay =>
      $composableBuilder(column: $table.jDay, builder: (column) => column);

  GeneratedColumn<int> get startJYear => $composableBuilder(
    column: $table.startJYear,
    builder: (column) => column,
  );

  GeneratedColumn<int> get startJMonth => $composableBuilder(
    column: $table.startJMonth,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endJYear =>
      $composableBuilder(column: $table.endJYear, builder: (column) => column);

  GeneratedColumn<int> get endJMonth =>
      $composableBuilder(column: $table.endJMonth, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecurringExpensesTable,
          RecurringExpense,
          $$RecurringExpensesTableFilterComposer,
          $$RecurringExpensesTableOrderingComposer,
          $$RecurringExpensesTableAnnotationComposer,
          $$RecurringExpensesTableCreateCompanionBuilder,
          $$RecurringExpensesTableUpdateCompanionBuilder,
          (RecurringExpense, $$RecurringExpensesTableReferences),
          RecurringExpense,
          PrefetchHooks Function({bool categoryId, bool accountId})
        > {
  $$RecurringExpensesTableTableManager(
    _$AppDatabase db,
    $RecurringExpensesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecurringExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecurringExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecurringExpensesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> amountRial = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<int?> accountId = const Value.absent(),
                Value<int> jDay = const Value.absent(),
                Value<int> startJYear = const Value.absent(),
                Value<int> startJMonth = const Value.absent(),
                Value<int?> endJYear = const Value.absent(),
                Value<int?> endJMonth = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RecurringExpensesCompanion(
                id: id,
                title: title,
                amountRial: amountRial,
                categoryId: categoryId,
                accountId: accountId,
                jDay: jDay,
                startJYear: startJYear,
                startJMonth: startJMonth,
                endJYear: endJYear,
                endJMonth: endJMonth,
                note: note,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required int amountRial,
                Value<int?> categoryId = const Value.absent(),
                Value<int?> accountId = const Value.absent(),
                required int jDay,
                required int startJYear,
                required int startJMonth,
                Value<int?> endJYear = const Value.absent(),
                Value<int?> endJMonth = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
              }) => RecurringExpensesCompanion.insert(
                id: id,
                title: title,
                amountRial: amountRial,
                categoryId: categoryId,
                accountId: accountId,
                jDay: jDay,
                startJYear: startJYear,
                startJMonth: startJMonth,
                endJYear: endJYear,
                endJMonth: endJMonth,
                note: note,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecurringExpensesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false, accountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable:
                                    $$RecurringExpensesTableReferences
                                        ._categoryIdTable(db),
                                referencedColumn:
                                    $$RecurringExpensesTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (accountId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.accountId,
                                referencedTable:
                                    $$RecurringExpensesTableReferences
                                        ._accountIdTable(db),
                                referencedColumn:
                                    $$RecurringExpensesTableReferences
                                        ._accountIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecurringExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecurringExpensesTable,
      RecurringExpense,
      $$RecurringExpensesTableFilterComposer,
      $$RecurringExpensesTableOrderingComposer,
      $$RecurringExpensesTableAnnotationComposer,
      $$RecurringExpensesTableCreateCompanionBuilder,
      $$RecurringExpensesTableUpdateCompanionBuilder,
      (RecurringExpense, $$RecurringExpensesTableReferences),
      RecurringExpense,
      PrefetchHooks Function({bool categoryId, bool accountId})
    >;
typedef $$RecurringOccurrencesTableCreateCompanionBuilder =
    RecurringOccurrencesCompanion Function({
      Value<int> id,
      required OwnerKind ownerKind,
      required int ownerId,
      required int jYear,
      required int jMonth,
      required DateTime dueAt,
      required OccurrenceStatus status,
      Value<int?> amountOverrideRial,
      Value<int?> transactionId,
      Value<DateTime?> resolvedAt,
    });
typedef $$RecurringOccurrencesTableUpdateCompanionBuilder =
    RecurringOccurrencesCompanion Function({
      Value<int> id,
      Value<OwnerKind> ownerKind,
      Value<int> ownerId,
      Value<int> jYear,
      Value<int> jMonth,
      Value<DateTime> dueAt,
      Value<OccurrenceStatus> status,
      Value<int?> amountOverrideRial,
      Value<int?> transactionId,
      Value<DateTime?> resolvedAt,
    });

final class $$RecurringOccurrencesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecurringOccurrencesTable,
          RecurringOccurrence
        > {
  $$RecurringOccurrencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TransactionsTable _transactionIdTable(_$AppDatabase db) => db
      .transactions
      .createAlias('recurring_occurrences__transaction_id__transactions__id');

  $$TransactionsTableProcessedTableManager? get transactionId {
    final $_column = $_itemColumn<int>('transaction_id');
    if ($_column == null) return null;
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecurringOccurrencesTableFilterComposer
    extends Composer<_$AppDatabase, $RecurringOccurrencesTable> {
  $$RecurringOccurrencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<OwnerKind, OwnerKind, int> get ownerKind =>
      $composableBuilder(
        column: $table.ownerKind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jYear => $composableBuilder(
    column: $table.jYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jMonth => $composableBuilder(
    column: $table.jMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<OccurrenceStatus, OccurrenceStatus, int>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get amountOverrideRial => $composableBuilder(
    column: $table.amountOverrideRial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TransactionsTableFilterComposer get transactionId {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringOccurrencesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecurringOccurrencesTable> {
  $$RecurringOccurrencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ownerKind => $composableBuilder(
    column: $table.ownerKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jYear => $composableBuilder(
    column: $table.jYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jMonth => $composableBuilder(
    column: $table.jMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountOverrideRial => $composableBuilder(
    column: $table.amountOverrideRial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TransactionsTableOrderingComposer get transactionId {
    final $$TransactionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableOrderingComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringOccurrencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecurringOccurrencesTable> {
  $$RecurringOccurrencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<OwnerKind, int> get ownerKind =>
      $composableBuilder(column: $table.ownerKind, builder: (column) => column);

  GeneratedColumn<int> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<int> get jYear =>
      $composableBuilder(column: $table.jYear, builder: (column) => column);

  GeneratedColumn<int> get jMonth =>
      $composableBuilder(column: $table.jMonth, builder: (column) => column);

  GeneratedColumn<DateTime> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<OccurrenceStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get amountOverrideRial => $composableBuilder(
    column: $table.amountOverrideRial,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => column,
  );

  $$TransactionsTableAnnotationComposer get transactionId {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringOccurrencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecurringOccurrencesTable,
          RecurringOccurrence,
          $$RecurringOccurrencesTableFilterComposer,
          $$RecurringOccurrencesTableOrderingComposer,
          $$RecurringOccurrencesTableAnnotationComposer,
          $$RecurringOccurrencesTableCreateCompanionBuilder,
          $$RecurringOccurrencesTableUpdateCompanionBuilder,
          (RecurringOccurrence, $$RecurringOccurrencesTableReferences),
          RecurringOccurrence,
          PrefetchHooks Function({bool transactionId})
        > {
  $$RecurringOccurrencesTableTableManager(
    _$AppDatabase db,
    $RecurringOccurrencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecurringOccurrencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecurringOccurrencesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RecurringOccurrencesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<OwnerKind> ownerKind = const Value.absent(),
                Value<int> ownerId = const Value.absent(),
                Value<int> jYear = const Value.absent(),
                Value<int> jMonth = const Value.absent(),
                Value<DateTime> dueAt = const Value.absent(),
                Value<OccurrenceStatus> status = const Value.absent(),
                Value<int?> amountOverrideRial = const Value.absent(),
                Value<int?> transactionId = const Value.absent(),
                Value<DateTime?> resolvedAt = const Value.absent(),
              }) => RecurringOccurrencesCompanion(
                id: id,
                ownerKind: ownerKind,
                ownerId: ownerId,
                jYear: jYear,
                jMonth: jMonth,
                dueAt: dueAt,
                status: status,
                amountOverrideRial: amountOverrideRial,
                transactionId: transactionId,
                resolvedAt: resolvedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required OwnerKind ownerKind,
                required int ownerId,
                required int jYear,
                required int jMonth,
                required DateTime dueAt,
                required OccurrenceStatus status,
                Value<int?> amountOverrideRial = const Value.absent(),
                Value<int?> transactionId = const Value.absent(),
                Value<DateTime?> resolvedAt = const Value.absent(),
              }) => RecurringOccurrencesCompanion.insert(
                id: id,
                ownerKind: ownerKind,
                ownerId: ownerId,
                jYear: jYear,
                jMonth: jMonth,
                dueAt: dueAt,
                status: status,
                amountOverrideRial: amountOverrideRial,
                transactionId: transactionId,
                resolvedAt: resolvedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecurringOccurrencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (transactionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.transactionId,
                                referencedTable:
                                    $$RecurringOccurrencesTableReferences
                                        ._transactionIdTable(db),
                                referencedColumn:
                                    $$RecurringOccurrencesTableReferences
                                        ._transactionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecurringOccurrencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecurringOccurrencesTable,
      RecurringOccurrence,
      $$RecurringOccurrencesTableFilterComposer,
      $$RecurringOccurrencesTableOrderingComposer,
      $$RecurringOccurrencesTableAnnotationComposer,
      $$RecurringOccurrencesTableCreateCompanionBuilder,
      $$RecurringOccurrencesTableUpdateCompanionBuilder,
      (RecurringOccurrence, $$RecurringOccurrencesTableReferences),
      RecurringOccurrence,
      PrefetchHooks Function({bool transactionId})
    >;
typedef $$ReminderRulesTableCreateCompanionBuilder =
    ReminderRulesCompanion Function({
      Value<int> id,
      required OwnerKind ownerKind,
      required int ownerId,
      required int daysBefore,
      Value<int> minutesOfDay,
    });
typedef $$ReminderRulesTableUpdateCompanionBuilder =
    ReminderRulesCompanion Function({
      Value<int> id,
      Value<OwnerKind> ownerKind,
      Value<int> ownerId,
      Value<int> daysBefore,
      Value<int> minutesOfDay,
    });

class $$ReminderRulesTableFilterComposer
    extends Composer<_$AppDatabase, $ReminderRulesTable> {
  $$ReminderRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<OwnerKind, OwnerKind, int> get ownerKind =>
      $composableBuilder(
        column: $table.ownerKind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get daysBefore => $composableBuilder(
    column: $table.daysBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minutesOfDay => $composableBuilder(
    column: $table.minutesOfDay,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReminderRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $ReminderRulesTable> {
  $$ReminderRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ownerKind => $composableBuilder(
    column: $table.ownerKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get daysBefore => $composableBuilder(
    column: $table.daysBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minutesOfDay => $composableBuilder(
    column: $table.minutesOfDay,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReminderRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReminderRulesTable> {
  $$ReminderRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<OwnerKind, int> get ownerKind =>
      $composableBuilder(column: $table.ownerKind, builder: (column) => column);

  GeneratedColumn<int> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<int> get daysBefore => $composableBuilder(
    column: $table.daysBefore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minutesOfDay => $composableBuilder(
    column: $table.minutesOfDay,
    builder: (column) => column,
  );
}

class $$ReminderRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReminderRulesTable,
          ReminderRule,
          $$ReminderRulesTableFilterComposer,
          $$ReminderRulesTableOrderingComposer,
          $$ReminderRulesTableAnnotationComposer,
          $$ReminderRulesTableCreateCompanionBuilder,
          $$ReminderRulesTableUpdateCompanionBuilder,
          (
            ReminderRule,
            BaseReferences<_$AppDatabase, $ReminderRulesTable, ReminderRule>,
          ),
          ReminderRule,
          PrefetchHooks Function()
        > {
  $$ReminderRulesTableTableManager(_$AppDatabase db, $ReminderRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReminderRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReminderRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReminderRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<OwnerKind> ownerKind = const Value.absent(),
                Value<int> ownerId = const Value.absent(),
                Value<int> daysBefore = const Value.absent(),
                Value<int> minutesOfDay = const Value.absent(),
              }) => ReminderRulesCompanion(
                id: id,
                ownerKind: ownerKind,
                ownerId: ownerId,
                daysBefore: daysBefore,
                minutesOfDay: minutesOfDay,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required OwnerKind ownerKind,
                required int ownerId,
                required int daysBefore,
                Value<int> minutesOfDay = const Value.absent(),
              }) => ReminderRulesCompanion.insert(
                id: id,
                ownerKind: ownerKind,
                ownerId: ownerId,
                daysBefore: daysBefore,
                minutesOfDay: minutesOfDay,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReminderRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReminderRulesTable,
      ReminderRule,
      $$ReminderRulesTableFilterComposer,
      $$ReminderRulesTableOrderingComposer,
      $$ReminderRulesTableAnnotationComposer,
      $$ReminderRulesTableCreateCompanionBuilder,
      $$ReminderRulesTableUpdateCompanionBuilder,
      (
        ReminderRule,
        BaseReferences<_$AppDatabase, $ReminderRulesTable, ReminderRule>,
      ),
      ReminderRule,
      PrefetchHooks Function()
    >;
typedef $$ScheduledNotificationsTableCreateCompanionBuilder =
    ScheduledNotificationsCompanion Function({
      Value<int> id,
      required OwnerKind ownerKind,
      required int ownerId,
      Value<int?> occurrenceId,
      Value<int?> ruleId,
      required DateTime fireAt,
      required String payload,
    });
typedef $$ScheduledNotificationsTableUpdateCompanionBuilder =
    ScheduledNotificationsCompanion Function({
      Value<int> id,
      Value<OwnerKind> ownerKind,
      Value<int> ownerId,
      Value<int?> occurrenceId,
      Value<int?> ruleId,
      Value<DateTime> fireAt,
      Value<String> payload,
    });

class $$ScheduledNotificationsTableFilterComposer
    extends Composer<_$AppDatabase, $ScheduledNotificationsTable> {
  $$ScheduledNotificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<OwnerKind, OwnerKind, int> get ownerKind =>
      $composableBuilder(
        column: $table.ownerKind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get occurrenceId => $composableBuilder(
    column: $table.occurrenceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ruleId => $composableBuilder(
    column: $table.ruleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fireAt => $composableBuilder(
    column: $table.fireAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ScheduledNotificationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ScheduledNotificationsTable> {
  $$ScheduledNotificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ownerKind => $composableBuilder(
    column: $table.ownerKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get occurrenceId => $composableBuilder(
    column: $table.occurrenceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ruleId => $composableBuilder(
    column: $table.ruleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fireAt => $composableBuilder(
    column: $table.fireAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScheduledNotificationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScheduledNotificationsTable> {
  $$ScheduledNotificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<OwnerKind, int> get ownerKind =>
      $composableBuilder(column: $table.ownerKind, builder: (column) => column);

  GeneratedColumn<int> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<int> get occurrenceId => $composableBuilder(
    column: $table.occurrenceId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ruleId =>
      $composableBuilder(column: $table.ruleId, builder: (column) => column);

  GeneratedColumn<DateTime> get fireAt =>
      $composableBuilder(column: $table.fireAt, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);
}

class $$ScheduledNotificationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScheduledNotificationsTable,
          ScheduledNotification,
          $$ScheduledNotificationsTableFilterComposer,
          $$ScheduledNotificationsTableOrderingComposer,
          $$ScheduledNotificationsTableAnnotationComposer,
          $$ScheduledNotificationsTableCreateCompanionBuilder,
          $$ScheduledNotificationsTableUpdateCompanionBuilder,
          (
            ScheduledNotification,
            BaseReferences<
              _$AppDatabase,
              $ScheduledNotificationsTable,
              ScheduledNotification
            >,
          ),
          ScheduledNotification,
          PrefetchHooks Function()
        > {
  $$ScheduledNotificationsTableTableManager(
    _$AppDatabase db,
    $ScheduledNotificationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScheduledNotificationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ScheduledNotificationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ScheduledNotificationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<OwnerKind> ownerKind = const Value.absent(),
                Value<int> ownerId = const Value.absent(),
                Value<int?> occurrenceId = const Value.absent(),
                Value<int?> ruleId = const Value.absent(),
                Value<DateTime> fireAt = const Value.absent(),
                Value<String> payload = const Value.absent(),
              }) => ScheduledNotificationsCompanion(
                id: id,
                ownerKind: ownerKind,
                ownerId: ownerId,
                occurrenceId: occurrenceId,
                ruleId: ruleId,
                fireAt: fireAt,
                payload: payload,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required OwnerKind ownerKind,
                required int ownerId,
                Value<int?> occurrenceId = const Value.absent(),
                Value<int?> ruleId = const Value.absent(),
                required DateTime fireAt,
                required String payload,
              }) => ScheduledNotificationsCompanion.insert(
                id: id,
                ownerKind: ownerKind,
                ownerId: ownerId,
                occurrenceId: occurrenceId,
                ruleId: ruleId,
                fireAt: fireAt,
                payload: payload,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScheduledNotificationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScheduledNotificationsTable,
      ScheduledNotification,
      $$ScheduledNotificationsTableFilterComposer,
      $$ScheduledNotificationsTableOrderingComposer,
      $$ScheduledNotificationsTableAnnotationComposer,
      $$ScheduledNotificationsTableCreateCompanionBuilder,
      $$ScheduledNotificationsTableUpdateCompanionBuilder,
      (
        ScheduledNotification,
        BaseReferences<
          _$AppDatabase,
          $ScheduledNotificationsTable,
          ScheduledNotification
        >,
      ),
      ScheduledNotification,
      PrefetchHooks Function()
    >;
typedef $$DebtsTableCreateCompanionBuilder =
    DebtsCompanion Function({
      Value<int> id,
      required DebtDirection direction,
      required String personName,
      Value<String?> title,
      required int totalAmountRial,
      Value<DateTime?> dueAt,
      Value<String?> note,
      required DebtStatus status,
      required DateTime createdAt,
      Value<DateTime?> settledAt,
    });
typedef $$DebtsTableUpdateCompanionBuilder =
    DebtsCompanion Function({
      Value<int> id,
      Value<DebtDirection> direction,
      Value<String> personName,
      Value<String?> title,
      Value<int> totalAmountRial,
      Value<DateTime?> dueAt,
      Value<String?> note,
      Value<DebtStatus> status,
      Value<DateTime> createdAt,
      Value<DateTime?> settledAt,
    });

final class $$DebtsTableReferences
    extends BaseReferences<_$AppDatabase, $DebtsTable, Debt> {
  $$DebtsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DebtPaymentsTable, List<DebtPayment>>
  _debtPaymentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.debtPayments,
    aliasName: 'debts__id__debt_payments__debt_id',
  );

  $$DebtPaymentsTableProcessedTableManager get debtPaymentsRefs {
    final manager = $$DebtPaymentsTableTableManager(
      $_db,
      $_db.debtPayments,
    ).filter((f) => f.debtId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_debtPaymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DebtsTableFilterComposer extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DebtDirection, DebtDirection, int>
  get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get personName => $composableBuilder(
    column: $table.personName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalAmountRial => $composableBuilder(
    column: $table.totalAmountRial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DebtStatus, DebtStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get settledAt => $composableBuilder(
    column: $table.settledAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> debtPaymentsRefs(
    Expression<bool> Function($$DebtPaymentsTableFilterComposer f) f,
  ) {
    final $$DebtPaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.debtPayments,
      getReferencedColumn: (t) => t.debtId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtPaymentsTableFilterComposer(
            $db: $db,
            $table: $db.debtPayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DebtsTableOrderingComposer
    extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get personName => $composableBuilder(
    column: $table.personName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalAmountRial => $composableBuilder(
    column: $table.totalAmountRial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get settledAt => $composableBuilder(
    column: $table.settledAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DebtsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DebtDirection, int> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<String> get personName => $composableBuilder(
    column: $table.personName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get totalAmountRial => $composableBuilder(
    column: $table.totalAmountRial,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DebtStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get settledAt =>
      $composableBuilder(column: $table.settledAt, builder: (column) => column);

  Expression<T> debtPaymentsRefs<T extends Object>(
    Expression<T> Function($$DebtPaymentsTableAnnotationComposer a) f,
  ) {
    final $$DebtPaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.debtPayments,
      getReferencedColumn: (t) => t.debtId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtPaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.debtPayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DebtsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DebtsTable,
          Debt,
          $$DebtsTableFilterComposer,
          $$DebtsTableOrderingComposer,
          $$DebtsTableAnnotationComposer,
          $$DebtsTableCreateCompanionBuilder,
          $$DebtsTableUpdateCompanionBuilder,
          (Debt, $$DebtsTableReferences),
          Debt,
          PrefetchHooks Function({bool debtPaymentsRefs})
        > {
  $$DebtsTableTableManager(_$AppDatabase db, $DebtsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DebtsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DebtsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DebtsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DebtDirection> direction = const Value.absent(),
                Value<String> personName = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<int> totalAmountRial = const Value.absent(),
                Value<DateTime?> dueAt = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DebtStatus> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> settledAt = const Value.absent(),
              }) => DebtsCompanion(
                id: id,
                direction: direction,
                personName: personName,
                title: title,
                totalAmountRial: totalAmountRial,
                dueAt: dueAt,
                note: note,
                status: status,
                createdAt: createdAt,
                settledAt: settledAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DebtDirection direction,
                required String personName,
                Value<String?> title = const Value.absent(),
                required int totalAmountRial,
                Value<DateTime?> dueAt = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DebtStatus status,
                required DateTime createdAt,
                Value<DateTime?> settledAt = const Value.absent(),
              }) => DebtsCompanion.insert(
                id: id,
                direction: direction,
                personName: personName,
                title: title,
                totalAmountRial: totalAmountRial,
                dueAt: dueAt,
                note: note,
                status: status,
                createdAt: createdAt,
                settledAt: settledAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$DebtsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({debtPaymentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (debtPaymentsRefs) db.debtPayments],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (debtPaymentsRefs)
                    await $_getPrefetchedData<Debt, $DebtsTable, DebtPayment>(
                      currentTable: table,
                      referencedTable: $$DebtsTableReferences
                          ._debtPaymentsRefsTable(db),
                      managerFromTypedResult: (p0) => $$DebtsTableReferences(
                        db,
                        table,
                        p0,
                      ).debtPaymentsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.debtId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DebtsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DebtsTable,
      Debt,
      $$DebtsTableFilterComposer,
      $$DebtsTableOrderingComposer,
      $$DebtsTableAnnotationComposer,
      $$DebtsTableCreateCompanionBuilder,
      $$DebtsTableUpdateCompanionBuilder,
      (Debt, $$DebtsTableReferences),
      Debt,
      PrefetchHooks Function({bool debtPaymentsRefs})
    >;
typedef $$DebtPaymentsTableCreateCompanionBuilder =
    DebtPaymentsCompanion Function({
      Value<int> id,
      required int debtId,
      required int amountRial,
      required DateTime paidAt,
      Value<int?> transactionId,
      Value<String?> note,
    });
typedef $$DebtPaymentsTableUpdateCompanionBuilder =
    DebtPaymentsCompanion Function({
      Value<int> id,
      Value<int> debtId,
      Value<int> amountRial,
      Value<DateTime> paidAt,
      Value<int?> transactionId,
      Value<String?> note,
    });

final class $$DebtPaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $DebtPaymentsTable, DebtPayment> {
  $$DebtPaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DebtsTable _debtIdTable(_$AppDatabase db) =>
      db.debts.createAlias('debt_payments__debt_id__debts__id');

  $$DebtsTableProcessedTableManager get debtId {
    final $_column = $_itemColumn<int>('debt_id')!;

    final manager = $$DebtsTableTableManager(
      $_db,
      $_db.debts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_debtIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TransactionsTable _transactionIdTable(_$AppDatabase db) => db
      .transactions
      .createAlias('debt_payments__transaction_id__transactions__id');

  $$TransactionsTableProcessedTableManager? get transactionId {
    final $_column = $_itemColumn<int>('transaction_id');
    if ($_column == null) return null;
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DebtPaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $DebtPaymentsTable> {
  $$DebtPaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountRial => $composableBuilder(
    column: $table.amountRial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$DebtsTableFilterComposer get debtId {
    final $$DebtsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.debtId,
      referencedTable: $db.debts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtsTableFilterComposer(
            $db: $db,
            $table: $db.debts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TransactionsTableFilterComposer get transactionId {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DebtPaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DebtPaymentsTable> {
  $$DebtPaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountRial => $composableBuilder(
    column: $table.amountRial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$DebtsTableOrderingComposer get debtId {
    final $$DebtsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.debtId,
      referencedTable: $db.debts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtsTableOrderingComposer(
            $db: $db,
            $table: $db.debts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TransactionsTableOrderingComposer get transactionId {
    final $$TransactionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableOrderingComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DebtPaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DebtPaymentsTable> {
  $$DebtPaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amountRial => $composableBuilder(
    column: $table.amountRial,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$DebtsTableAnnotationComposer get debtId {
    final $$DebtsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.debtId,
      referencedTable: $db.debts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtsTableAnnotationComposer(
            $db: $db,
            $table: $db.debts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TransactionsTableAnnotationComposer get transactionId {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DebtPaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DebtPaymentsTable,
          DebtPayment,
          $$DebtPaymentsTableFilterComposer,
          $$DebtPaymentsTableOrderingComposer,
          $$DebtPaymentsTableAnnotationComposer,
          $$DebtPaymentsTableCreateCompanionBuilder,
          $$DebtPaymentsTableUpdateCompanionBuilder,
          (DebtPayment, $$DebtPaymentsTableReferences),
          DebtPayment,
          PrefetchHooks Function({bool debtId, bool transactionId})
        > {
  $$DebtPaymentsTableTableManager(_$AppDatabase db, $DebtPaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DebtPaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DebtPaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DebtPaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> debtId = const Value.absent(),
                Value<int> amountRial = const Value.absent(),
                Value<DateTime> paidAt = const Value.absent(),
                Value<int?> transactionId = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => DebtPaymentsCompanion(
                id: id,
                debtId: debtId,
                amountRial: amountRial,
                paidAt: paidAt,
                transactionId: transactionId,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int debtId,
                required int amountRial,
                required DateTime paidAt,
                Value<int?> transactionId = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => DebtPaymentsCompanion.insert(
                id: id,
                debtId: debtId,
                amountRial: amountRial,
                paidAt: paidAt,
                transactionId: transactionId,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DebtPaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({debtId = false, transactionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (debtId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.debtId,
                                referencedTable: $$DebtPaymentsTableReferences
                                    ._debtIdTable(db),
                                referencedColumn: $$DebtPaymentsTableReferences
                                    ._debtIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (transactionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.transactionId,
                                referencedTable: $$DebtPaymentsTableReferences
                                    ._transactionIdTable(db),
                                referencedColumn: $$DebtPaymentsTableReferences
                                    ._transactionIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DebtPaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DebtPaymentsTable,
      DebtPayment,
      $$DebtPaymentsTableFilterComposer,
      $$DebtPaymentsTableOrderingComposer,
      $$DebtPaymentsTableAnnotationComposer,
      $$DebtPaymentsTableCreateCompanionBuilder,
      $$DebtPaymentsTableUpdateCompanionBuilder,
      (DebtPayment, $$DebtPaymentsTableReferences),
      DebtPayment,
      PrefetchHooks Function({bool debtId, bool transactionId})
    >;
typedef $$BudgetsTableCreateCompanionBuilder =
    BudgetsCompanion Function({
      Value<int> id,
      required int jYear,
      required int jMonth,
      Value<int?> categoryId,
      required int capAmountRial,
    });
typedef $$BudgetsTableUpdateCompanionBuilder =
    BudgetsCompanion Function({
      Value<int> id,
      Value<int> jYear,
      Value<int> jMonth,
      Value<int?> categoryId,
      Value<int> capAmountRial,
    });

final class $$BudgetsTableReferences
    extends BaseReferences<_$AppDatabase, $BudgetsTable, Budget> {
  $$BudgetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('budgets__category_id__categories__id');

  $$CategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BudgetsTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetsTable> {
  $$BudgetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jYear => $composableBuilder(
    column: $table.jYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jMonth => $composableBuilder(
    column: $table.jMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get capAmountRial => $composableBuilder(
    column: $table.capAmountRial,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetsTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetsTable> {
  $$BudgetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jYear => $composableBuilder(
    column: $table.jYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jMonth => $composableBuilder(
    column: $table.jMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get capAmountRial => $composableBuilder(
    column: $table.capAmountRial,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetsTable> {
  $$BudgetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get jYear =>
      $composableBuilder(column: $table.jYear, builder: (column) => column);

  GeneratedColumn<int> get jMonth =>
      $composableBuilder(column: $table.jMonth, builder: (column) => column);

  GeneratedColumn<int> get capAmountRial => $composableBuilder(
    column: $table.capAmountRial,
    builder: (column) => column,
  );

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BudgetsTable,
          Budget,
          $$BudgetsTableFilterComposer,
          $$BudgetsTableOrderingComposer,
          $$BudgetsTableAnnotationComposer,
          $$BudgetsTableCreateCompanionBuilder,
          $$BudgetsTableUpdateCompanionBuilder,
          (Budget, $$BudgetsTableReferences),
          Budget,
          PrefetchHooks Function({bool categoryId})
        > {
  $$BudgetsTableTableManager(_$AppDatabase db, $BudgetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> jYear = const Value.absent(),
                Value<int> jMonth = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<int> capAmountRial = const Value.absent(),
              }) => BudgetsCompanion(
                id: id,
                jYear: jYear,
                jMonth: jMonth,
                categoryId: categoryId,
                capAmountRial: capAmountRial,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int jYear,
                required int jMonth,
                Value<int?> categoryId = const Value.absent(),
                required int capAmountRial,
              }) => BudgetsCompanion.insert(
                id: id,
                jYear: jYear,
                jMonth: jMonth,
                categoryId: categoryId,
                capAmountRial: capAmountRial,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BudgetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable: $$BudgetsTableReferences
                                    ._categoryIdTable(db),
                                referencedColumn: $$BudgetsTableReferences
                                    ._categoryIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BudgetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BudgetsTable,
      Budget,
      $$BudgetsTableFilterComposer,
      $$BudgetsTableOrderingComposer,
      $$BudgetsTableAnnotationComposer,
      $$BudgetsTableCreateCompanionBuilder,
      $$BudgetsTableUpdateCompanionBuilder,
      (Budget, $$BudgetsTableReferences),
      Budget,
      PrefetchHooks Function({bool categoryId})
    >;
typedef $$WishesTableCreateCompanionBuilder =
    WishesCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> description,
      Value<DateTime?> targetAt,
      Value<int?> estimatedCostRial,
      required int sortOrder,
      Value<bool> isDone,
      required DateTime createdAt,
    });
typedef $$WishesTableUpdateCompanionBuilder =
    WishesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> description,
      Value<DateTime?> targetAt,
      Value<int?> estimatedCostRial,
      Value<int> sortOrder,
      Value<bool> isDone,
      Value<DateTime> createdAt,
    });

final class $$WishesTableReferences
    extends BaseReferences<_$AppDatabase, $WishesTable, Wishe> {
  $$WishesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WishLinksTable, List<WishLink>>
  _wishLinksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.wishLinks,
    aliasName: 'wishes__id__wish_links__wish_id',
  );

  $$WishLinksTableProcessedTableManager get wishLinksRefs {
    final manager = $$WishLinksTableTableManager(
      $_db,
      $_db.wishLinks,
    ).filter((f) => f.wishId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wishLinksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WishImagesTable, List<WishImage>>
  _wishImagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.wishImages,
    aliasName: 'wishes__id__wish_images__wish_id',
  );

  $$WishImagesTableProcessedTableManager get wishImagesRefs {
    final manager = $$WishImagesTableTableManager(
      $_db,
      $_db.wishImages,
    ).filter((f) => f.wishId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wishImagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WishesTableFilterComposer
    extends Composer<_$AppDatabase, $WishesTable> {
  $$WishesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get targetAt => $composableBuilder(
    column: $table.targetAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedCostRial => $composableBuilder(
    column: $table.estimatedCostRial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> wishLinksRefs(
    Expression<bool> Function($$WishLinksTableFilterComposer f) f,
  ) {
    final $$WishLinksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wishLinks,
      getReferencedColumn: (t) => t.wishId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WishLinksTableFilterComposer(
            $db: $db,
            $table: $db.wishLinks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> wishImagesRefs(
    Expression<bool> Function($$WishImagesTableFilterComposer f) f,
  ) {
    final $$WishImagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wishImages,
      getReferencedColumn: (t) => t.wishId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WishImagesTableFilterComposer(
            $db: $db,
            $table: $db.wishImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WishesTableOrderingComposer
    extends Composer<_$AppDatabase, $WishesTable> {
  $$WishesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get targetAt => $composableBuilder(
    column: $table.targetAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedCostRial => $composableBuilder(
    column: $table.estimatedCostRial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WishesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WishesTable> {
  $$WishesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get targetAt =>
      $composableBuilder(column: $table.targetAt, builder: (column) => column);

  GeneratedColumn<int> get estimatedCostRial => $composableBuilder(
    column: $table.estimatedCostRial,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isDone =>
      $composableBuilder(column: $table.isDone, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> wishLinksRefs<T extends Object>(
    Expression<T> Function($$WishLinksTableAnnotationComposer a) f,
  ) {
    final $$WishLinksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wishLinks,
      getReferencedColumn: (t) => t.wishId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WishLinksTableAnnotationComposer(
            $db: $db,
            $table: $db.wishLinks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> wishImagesRefs<T extends Object>(
    Expression<T> Function($$WishImagesTableAnnotationComposer a) f,
  ) {
    final $$WishImagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wishImages,
      getReferencedColumn: (t) => t.wishId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WishImagesTableAnnotationComposer(
            $db: $db,
            $table: $db.wishImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WishesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WishesTable,
          Wishe,
          $$WishesTableFilterComposer,
          $$WishesTableOrderingComposer,
          $$WishesTableAnnotationComposer,
          $$WishesTableCreateCompanionBuilder,
          $$WishesTableUpdateCompanionBuilder,
          (Wishe, $$WishesTableReferences),
          Wishe,
          PrefetchHooks Function({bool wishLinksRefs, bool wishImagesRefs})
        > {
  $$WishesTableTableManager(_$AppDatabase db, $WishesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WishesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WishesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WishesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime?> targetAt = const Value.absent(),
                Value<int?> estimatedCostRial = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isDone = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => WishesCompanion(
                id: id,
                title: title,
                description: description,
                targetAt: targetAt,
                estimatedCostRial: estimatedCostRial,
                sortOrder: sortOrder,
                isDone: isDone,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                Value<DateTime?> targetAt = const Value.absent(),
                Value<int?> estimatedCostRial = const Value.absent(),
                required int sortOrder,
                Value<bool> isDone = const Value.absent(),
                required DateTime createdAt,
              }) => WishesCompanion.insert(
                id: id,
                title: title,
                description: description,
                targetAt: targetAt,
                estimatedCostRial: estimatedCostRial,
                sortOrder: sortOrder,
                isDone: isDone,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$WishesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({wishLinksRefs = false, wishImagesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (wishLinksRefs) db.wishLinks,
                    if (wishImagesRefs) db.wishImages,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (wishLinksRefs)
                        await $_getPrefetchedData<
                          Wishe,
                          $WishesTable,
                          WishLink
                        >(
                          currentTable: table,
                          referencedTable: $$WishesTableReferences
                              ._wishLinksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WishesTableReferences(
                                db,
                                table,
                                p0,
                              ).wishLinksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.wishId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (wishImagesRefs)
                        await $_getPrefetchedData<
                          Wishe,
                          $WishesTable,
                          WishImage
                        >(
                          currentTable: table,
                          referencedTable: $$WishesTableReferences
                              ._wishImagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WishesTableReferences(
                                db,
                                table,
                                p0,
                              ).wishImagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.wishId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WishesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WishesTable,
      Wishe,
      $$WishesTableFilterComposer,
      $$WishesTableOrderingComposer,
      $$WishesTableAnnotationComposer,
      $$WishesTableCreateCompanionBuilder,
      $$WishesTableUpdateCompanionBuilder,
      (Wishe, $$WishesTableReferences),
      Wishe,
      PrefetchHooks Function({bool wishLinksRefs, bool wishImagesRefs})
    >;
typedef $$WishLinksTableCreateCompanionBuilder =
    WishLinksCompanion Function({
      Value<int> id,
      required int wishId,
      required String url,
      Value<String?> label,
    });
typedef $$WishLinksTableUpdateCompanionBuilder =
    WishLinksCompanion Function({
      Value<int> id,
      Value<int> wishId,
      Value<String> url,
      Value<String?> label,
    });

final class $$WishLinksTableReferences
    extends BaseReferences<_$AppDatabase, $WishLinksTable, WishLink> {
  $$WishLinksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WishesTable _wishIdTable(_$AppDatabase db) =>
      db.wishes.createAlias('wish_links__wish_id__wishes__id');

  $$WishesTableProcessedTableManager get wishId {
    final $_column = $_itemColumn<int>('wish_id')!;

    final manager = $$WishesTableTableManager(
      $_db,
      $_db.wishes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wishIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WishLinksTableFilterComposer
    extends Composer<_$AppDatabase, $WishLinksTable> {
  $$WishLinksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  $$WishesTableFilterComposer get wishId {
    final $$WishesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wishId,
      referencedTable: $db.wishes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WishesTableFilterComposer(
            $db: $db,
            $table: $db.wishes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WishLinksTableOrderingComposer
    extends Composer<_$AppDatabase, $WishLinksTable> {
  $$WishLinksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  $$WishesTableOrderingComposer get wishId {
    final $$WishesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wishId,
      referencedTable: $db.wishes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WishesTableOrderingComposer(
            $db: $db,
            $table: $db.wishes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WishLinksTableAnnotationComposer
    extends Composer<_$AppDatabase, $WishLinksTable> {
  $$WishLinksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  $$WishesTableAnnotationComposer get wishId {
    final $$WishesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wishId,
      referencedTable: $db.wishes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WishesTableAnnotationComposer(
            $db: $db,
            $table: $db.wishes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WishLinksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WishLinksTable,
          WishLink,
          $$WishLinksTableFilterComposer,
          $$WishLinksTableOrderingComposer,
          $$WishLinksTableAnnotationComposer,
          $$WishLinksTableCreateCompanionBuilder,
          $$WishLinksTableUpdateCompanionBuilder,
          (WishLink, $$WishLinksTableReferences),
          WishLink,
          PrefetchHooks Function({bool wishId})
        > {
  $$WishLinksTableTableManager(_$AppDatabase db, $WishLinksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WishLinksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WishLinksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WishLinksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> wishId = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String?> label = const Value.absent(),
              }) => WishLinksCompanion(
                id: id,
                wishId: wishId,
                url: url,
                label: label,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int wishId,
                required String url,
                Value<String?> label = const Value.absent(),
              }) => WishLinksCompanion.insert(
                id: id,
                wishId: wishId,
                url: url,
                label: label,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WishLinksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({wishId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (wishId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.wishId,
                                referencedTable: $$WishLinksTableReferences
                                    ._wishIdTable(db),
                                referencedColumn: $$WishLinksTableReferences
                                    ._wishIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WishLinksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WishLinksTable,
      WishLink,
      $$WishLinksTableFilterComposer,
      $$WishLinksTableOrderingComposer,
      $$WishLinksTableAnnotationComposer,
      $$WishLinksTableCreateCompanionBuilder,
      $$WishLinksTableUpdateCompanionBuilder,
      (WishLink, $$WishLinksTableReferences),
      WishLink,
      PrefetchHooks Function({bool wishId})
    >;
typedef $$WishImagesTableCreateCompanionBuilder =
    WishImagesCompanion Function({
      Value<int> id,
      required int wishId,
      required String relativePath,
      Value<int> sortOrder,
    });
typedef $$WishImagesTableUpdateCompanionBuilder =
    WishImagesCompanion Function({
      Value<int> id,
      Value<int> wishId,
      Value<String> relativePath,
      Value<int> sortOrder,
    });

final class $$WishImagesTableReferences
    extends BaseReferences<_$AppDatabase, $WishImagesTable, WishImage> {
  $$WishImagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WishesTable _wishIdTable(_$AppDatabase db) =>
      db.wishes.createAlias('wish_images__wish_id__wishes__id');

  $$WishesTableProcessedTableManager get wishId {
    final $_column = $_itemColumn<int>('wish_id')!;

    final manager = $$WishesTableTableManager(
      $_db,
      $_db.wishes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wishIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WishImagesTableFilterComposer
    extends Composer<_$AppDatabase, $WishImagesTable> {
  $$WishImagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$WishesTableFilterComposer get wishId {
    final $$WishesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wishId,
      referencedTable: $db.wishes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WishesTableFilterComposer(
            $db: $db,
            $table: $db.wishes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WishImagesTableOrderingComposer
    extends Composer<_$AppDatabase, $WishImagesTable> {
  $$WishImagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$WishesTableOrderingComposer get wishId {
    final $$WishesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wishId,
      referencedTable: $db.wishes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WishesTableOrderingComposer(
            $db: $db,
            $table: $db.wishes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WishImagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WishImagesTable> {
  $$WishImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$WishesTableAnnotationComposer get wishId {
    final $$WishesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wishId,
      referencedTable: $db.wishes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WishesTableAnnotationComposer(
            $db: $db,
            $table: $db.wishes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WishImagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WishImagesTable,
          WishImage,
          $$WishImagesTableFilterComposer,
          $$WishImagesTableOrderingComposer,
          $$WishImagesTableAnnotationComposer,
          $$WishImagesTableCreateCompanionBuilder,
          $$WishImagesTableUpdateCompanionBuilder,
          (WishImage, $$WishImagesTableReferences),
          WishImage,
          PrefetchHooks Function({bool wishId})
        > {
  $$WishImagesTableTableManager(_$AppDatabase db, $WishImagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WishImagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WishImagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WishImagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> wishId = const Value.absent(),
                Value<String> relativePath = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => WishImagesCompanion(
                id: id,
                wishId: wishId,
                relativePath: relativePath,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int wishId,
                required String relativePath,
                Value<int> sortOrder = const Value.absent(),
              }) => WishImagesCompanion.insert(
                id: id,
                wishId: wishId,
                relativePath: relativePath,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WishImagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({wishId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (wishId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.wishId,
                                referencedTable: $$WishImagesTableReferences
                                    ._wishIdTable(db),
                                referencedColumn: $$WishImagesTableReferences
                                    ._wishIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WishImagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WishImagesTable,
      WishImage,
      $$WishImagesTableFilterComposer,
      $$WishImagesTableOrderingComposer,
      $$WishImagesTableAnnotationComposer,
      $$WishImagesTableCreateCompanionBuilder,
      $$WishImagesTableUpdateCompanionBuilder,
      (WishImage, $$WishImagesTableReferences),
      WishImage,
      PrefetchHooks Function({bool wishId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$RawSmsTableTableManager get rawSms =>
      $$RawSmsTableTableManager(_db, _db.rawSms);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$SmsPatternsTableTableManager get smsPatterns =>
      $$SmsPatternsTableTableManager(_db, _db.smsPatterns);
  $$RecurringIncomesTableTableManager get recurringIncomes =>
      $$RecurringIncomesTableTableManager(_db, _db.recurringIncomes);
  $$RecurringExpensesTableTableManager get recurringExpenses =>
      $$RecurringExpensesTableTableManager(_db, _db.recurringExpenses);
  $$RecurringOccurrencesTableTableManager get recurringOccurrences =>
      $$RecurringOccurrencesTableTableManager(_db, _db.recurringOccurrences);
  $$ReminderRulesTableTableManager get reminderRules =>
      $$ReminderRulesTableTableManager(_db, _db.reminderRules);
  $$ScheduledNotificationsTableTableManager get scheduledNotifications =>
      $$ScheduledNotificationsTableTableManager(
        _db,
        _db.scheduledNotifications,
      );
  $$DebtsTableTableManager get debts =>
      $$DebtsTableTableManager(_db, _db.debts);
  $$DebtPaymentsTableTableManager get debtPayments =>
      $$DebtPaymentsTableTableManager(_db, _db.debtPayments);
  $$BudgetsTableTableManager get budgets =>
      $$BudgetsTableTableManager(_db, _db.budgets);
  $$WishesTableTableManager get wishes =>
      $$WishesTableTableManager(_db, _db.wishes);
  $$WishLinksTableTableManager get wishLinks =>
      $$WishLinksTableTableManager(_db, _db.wishLinks);
  $$WishImagesTableTableManager get wishImages =>
      $$WishImagesTableTableManager(_db, _db.wishImages);
}
