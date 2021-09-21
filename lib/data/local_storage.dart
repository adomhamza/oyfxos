import 'package:moor_flutter/moor_flutter.dart';

part 'local_storage.g.dart';

class Traders extends Table {
  TextColumn get userId => text()();
  TextColumn get firstName => text().withLength(min: 3, max: 50)();
  TextColumn get lastName => text().withLength(min: 3, max: 50)();
  TextColumn get username => text().withLength(min: 5, max: 50)();
  TextColumn get password => text().withLength(min: 8, max: 50)();
  DateTimeColumn get dateCreated => dateTime()();
  IntColumn get phone => integer()();
  @override
  Set<Column> get primaryKey => {userId};
}

class Withdrawals extends Table {
  TextColumn get id => text()();
  IntColumn get amount => integer()();
  DateTimeColumn get date => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [Traders, Withdrawals])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sqlite", logStatements: true));
  @override
  int get schemaVersion => 1;

//User Queries
  Future<List<Trader>> getAllUsers() => select(traders).get();
  Stream<List<Trader>> watchAllUsers() => select(traders).watch();
  Future insertUser(Trader trader) => into(traders).insert(trader);
  Future updateUser(Trader trader) => update(traders).replace(trader);
  Future deleteUser(Trader trader) => delete(traders).delete(trader);

//Withdrawals Query
  Future<List<Withdrawal>> getAllWithdrawals() => select(withdrawals).get();
  Stream<List<Withdrawal>> watchAllWithdrawals() => select(withdrawals).watch();
  Future insertWithdrawal(Withdrawal withdrawal) =>
      into(withdrawals).insert(withdrawal);
  Future updateWithdrawal(Withdrawal withdrawal) =>
      update(withdrawals).replace(withdrawal);
  Future deleteWithdrawal(Withdrawal withdrawal) =>
      delete(withdrawals).delete(withdrawal);
}
