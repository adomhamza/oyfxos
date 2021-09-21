// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Trader extends DataClass implements Insertable<Trader> {
  final String userId;
  final String firstName;
  final String lastName;
  final String username;
  final String password;
  final DateTime dateCreated;
  final int phone;
  Trader(
      {required this.userId,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.password,
      required this.dateCreated,
      required this.phone});
  factory Trader.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Trader(
      userId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_id'])!,
      firstName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name'])!,
      lastName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name'])!,
      username: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}username'])!,
      password: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}password'])!,
      dateCreated: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date_created'])!,
      phone: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}phone'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    map['date_created'] = Variable<DateTime>(dateCreated);
    map['phone'] = Variable<int>(phone);
    return map;
  }

  TradersCompanion toCompanion(bool nullToAbsent) {
    return TradersCompanion(
      userId: Value(userId),
      firstName: Value(firstName),
      lastName: Value(lastName),
      username: Value(username),
      password: Value(password),
      dateCreated: Value(dateCreated),
      phone: Value(phone),
    );
  }

  factory Trader.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Trader(
      userId: serializer.fromJson<String>(json['userId']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      dateCreated: serializer.fromJson<DateTime>(json['dateCreated']),
      phone: serializer.fromJson<int>(json['phone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'dateCreated': serializer.toJson<DateTime>(dateCreated),
      'phone': serializer.toJson<int>(phone),
    };
  }

  Trader copyWith(
          {String? userId,
          String? firstName,
          String? lastName,
          String? username,
          String? password,
          DateTime? dateCreated,
          int? phone}) =>
      Trader(
        userId: userId ?? this.userId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        username: username ?? this.username,
        password: password ?? this.password,
        dateCreated: dateCreated ?? this.dateCreated,
        phone: phone ?? this.phone,
      );
  @override
  String toString() {
    return (StringBuffer('Trader(')
          ..write('userId: $userId, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('phone: $phone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      userId.hashCode,
      $mrjc(
          firstName.hashCode,
          $mrjc(
              lastName.hashCode,
              $mrjc(
                  username.hashCode,
                  $mrjc(password.hashCode,
                      $mrjc(dateCreated.hashCode, phone.hashCode)))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trader &&
          other.userId == this.userId &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.username == this.username &&
          other.password == this.password &&
          other.dateCreated == this.dateCreated &&
          other.phone == this.phone);
}

class TradersCompanion extends UpdateCompanion<Trader> {
  final Value<String> userId;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> username;
  final Value<String> password;
  final Value<DateTime> dateCreated;
  final Value<int> phone;
  const TradersCompanion({
    this.userId = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.dateCreated = const Value.absent(),
    this.phone = const Value.absent(),
  });
  TradersCompanion.insert({
    required String userId,
    required String firstName,
    required String lastName,
    required String username,
    required String password,
    required DateTime dateCreated,
    required int phone,
  })  : userId = Value(userId),
        firstName = Value(firstName),
        lastName = Value(lastName),
        username = Value(username),
        password = Value(password),
        dateCreated = Value(dateCreated),
        phone = Value(phone);
  static Insertable<Trader> custom({
    Expression<String>? userId,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? username,
    Expression<String>? password,
    Expression<DateTime>? dateCreated,
    Expression<int>? phone,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (dateCreated != null) 'date_created': dateCreated,
      if (phone != null) 'phone': phone,
    });
  }

  TradersCompanion copyWith(
      {Value<String>? userId,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<String>? username,
      Value<String>? password,
      Value<DateTime>? dateCreated,
      Value<int>? phone}) {
    return TradersCompanion(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      password: password ?? this.password,
      dateCreated: dateCreated ?? this.dateCreated,
      phone: phone ?? this.phone,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (dateCreated.present) {
      map['date_created'] = Variable<DateTime>(dateCreated.value);
    }
    if (phone.present) {
      map['phone'] = Variable<int>(phone.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TradersCompanion(')
          ..write('userId: $userId, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('phone: $phone')
          ..write(')'))
        .toString();
  }
}

class $TradersTable extends Traders with TableInfo<$TradersTable, Trader> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TradersTable(this._db, [this._alias]);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedTextColumn userId = _constructUserId();
  GeneratedTextColumn _constructUserId() {
    return GeneratedTextColumn(
      'user_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  @override
  late final GeneratedTextColumn firstName = _constructFirstName();
  GeneratedTextColumn _constructFirstName() {
    return GeneratedTextColumn('first_name', $tableName, false,
        minTextLength: 3, maxTextLength: 50);
  }

  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  @override
  late final GeneratedTextColumn lastName = _constructLastName();
  GeneratedTextColumn _constructLastName() {
    return GeneratedTextColumn('last_name', $tableName, false,
        minTextLength: 3, maxTextLength: 50);
  }

  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedTextColumn username = _constructUsername();
  GeneratedTextColumn _constructUsername() {
    return GeneratedTextColumn('username', $tableName, false,
        minTextLength: 5, maxTextLength: 50);
  }

  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  @override
  late final GeneratedTextColumn password = _constructPassword();
  GeneratedTextColumn _constructPassword() {
    return GeneratedTextColumn('password', $tableName, false,
        minTextLength: 8, maxTextLength: 50);
  }

  final VerificationMeta _dateCreatedMeta =
      const VerificationMeta('dateCreated');
  @override
  late final GeneratedDateTimeColumn dateCreated = _constructDateCreated();
  GeneratedDateTimeColumn _constructDateCreated() {
    return GeneratedDateTimeColumn(
      'date_created',
      $tableName,
      false,
    );
  }

  final VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedIntColumn phone = _constructPhone();
  GeneratedIntColumn _constructPhone() {
    return GeneratedIntColumn(
      'phone',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [userId, firstName, lastName, username, password, dateCreated, phone];
  @override
  $TradersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'traders';
  @override
  final String actualTableName = 'traders';
  @override
  VerificationContext validateIntegrity(Insertable<Trader> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('date_created')) {
      context.handle(
          _dateCreatedMeta,
          dateCreated.isAcceptableOrUnknown(
              data['date_created']!, _dateCreatedMeta));
    } else if (isInserting) {
      context.missing(_dateCreatedMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  Trader map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Trader.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TradersTable createAlias(String alias) {
    return $TradersTable(_db, alias);
  }
}

class Withdrawal extends DataClass implements Insertable<Withdrawal> {
  final String id;
  final int amount;
  final DateTime date;
  Withdrawal({required this.id, required this.amount, required this.date});
  factory Withdrawal.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Withdrawal(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      amount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['amount'] = Variable<int>(amount);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  WithdrawalsCompanion toCompanion(bool nullToAbsent) {
    return WithdrawalsCompanion(
      id: Value(id),
      amount: Value(amount),
      date: Value(date),
    );
  }

  factory Withdrawal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Withdrawal(
      id: serializer.fromJson<String>(json['id']),
      amount: serializer.fromJson<int>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'amount': serializer.toJson<int>(amount),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Withdrawal copyWith({String? id, int? amount, DateTime? date}) => Withdrawal(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('Withdrawal(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(amount.hashCode, date.hashCode)));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Withdrawal &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.date == this.date);
}

class WithdrawalsCompanion extends UpdateCompanion<Withdrawal> {
  final Value<String> id;
  final Value<int> amount;
  final Value<DateTime> date;
  const WithdrawalsCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
  });
  WithdrawalsCompanion.insert({
    required String id,
    required int amount,
    required DateTime date,
  })  : id = Value(id),
        amount = Value(amount),
        date = Value(date);
  static Insertable<Withdrawal> custom({
    Expression<String>? id,
    Expression<int>? amount,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
    });
  }

  WithdrawalsCompanion copyWith(
      {Value<String>? id, Value<int>? amount, Value<DateTime>? date}) {
    return WithdrawalsCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WithdrawalsCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $WithdrawalsTable extends Withdrawals
    with TableInfo<$WithdrawalsTable, Withdrawal> {
  final GeneratedDatabase _db;
  final String? _alias;
  $WithdrawalsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedTextColumn id = _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedIntColumn amount = _constructAmount();
  GeneratedIntColumn _constructAmount() {
    return GeneratedIntColumn(
      'amount',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedDateTimeColumn date = _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, amount, date];
  @override
  $WithdrawalsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'withdrawals';
  @override
  final String actualTableName = 'withdrawals';
  @override
  VerificationContext validateIntegrity(Insertable<Withdrawal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Withdrawal map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Withdrawal.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $WithdrawalsTable createAlias(String alias) {
    return $WithdrawalsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TradersTable traders = $TradersTable(this);
  late final $WithdrawalsTable withdrawals = $WithdrawalsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [traders, withdrawals];
}
