import 'dart:convert';

// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.userId,
    required this.userTypeId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.message,
    required this.status,
  });

  String userId;
  String userTypeId;
  String firstName;
  String lastName;
  String email;
  String phone;
  String message;
  bool status;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        userTypeId: json["user_type_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_type_id": userTypeId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "message": message,
        "status": status,
      };
}

// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    required this.userId,
    required this.userTypeId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.lastLogin,
    required this.status,
    required this.message,
  });

  String userId;
  String userTypeId;
  String firstName;
  String lastName;
  String email;
  String phone;
  String lastLogin;
  int status;
  String message;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        userId: json["user_id"],
        userTypeId: json["user_type_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        lastLogin: json["last_login"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_type_id": userTypeId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "last_login": lastLogin,
        "status": status,
        "message": message,
      };
}

// To parse this JSON data, do
//
//     final open = openFromJson(jsonString);

Open openFromJson(String str) => Open.fromJson(json.decode(str));

String openToJson(Open data) => json.encode(data.toJson());

class Open {
  Open({
    required this.openingBalId,
    required this.userId,
    required this.amount,
  });

  String openingBalId;
  String userId;
  String amount;

  factory Open.fromJson(Map<String, dynamic> json) => Open(
        openingBalId: json["opening_bal_id"],
        userId: json["user_id"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "opening_bal_id": openingBalId,
        "user_id": userId,
        "amount": amount,
      };
}

// To parse this JSON data, do
//
//     final supervisor = supervisorFromJson(jsonString);

Supervisor supervisorFromJson(String str) =>
    Supervisor.fromJson(json.decode(str));

String supervisorToJson(Supervisor data) => json.encode(data.toJson());

class Supervisor {
  Supervisor({
    required this.userId,
    required this.userTypeId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.lastLogin,
    required this.status,
    required this.message,
  });

  String userId;
  String userTypeId;
  String firstName;
  String lastName;
  String email;
  String phone;
  String lastLogin;
  int status;
  String message;

  factory Supervisor.fromJson(Map<String, dynamic> json) => Supervisor(
        userId: json["user_id"],
        userTypeId: json["user_type_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        lastLogin: json["last_login"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_type_id": userTypeId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "last_login": lastLogin,
        "status": status,
        "message": message,
      };
}

// To parse this JSON data, do
//
//     final traderWithdrawal = traderWithdrawalFromJson(jsonString);

TraderWithdrawal traderWithdrawalFromJson(String str) =>
    TraderWithdrawal.fromJson(json.decode(str));

String traderWithdrawalToJson(TraderWithdrawal data) =>
    json.encode(data.toJson());

class TraderWithdrawal {
  TraderWithdrawal({
    required this.message,
    required this.status,
    required this.userWithdrawal,
  });

  String message;
  int status;
  List<UserWithdrawal> userWithdrawal;

  factory TraderWithdrawal.fromJson(Map<String, dynamic> json) =>
      TraderWithdrawal(
        message: json["message"],
        status: json["status"],
        userWithdrawal: List<UserWithdrawal>.from(
            json["withdrawal"].map((x) => UserWithdrawal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "withdrawal": List<dynamic>.from(userWithdrawal.map((x) => x.toJson())),
      };
}

class UserWithdrawal {
  UserWithdrawal({
    required this.withdrawalId,
    required this.amount,
    required this.email,
    required this.supervisorEmail,
    required this.traderName,
    required this.supervisorName,
    required this.dateCreated,
  });

  String withdrawalId;
  String amount;
  String email;
  String supervisorEmail;
  String traderName;
  String supervisorName;
  DateTime dateCreated;

  factory UserWithdrawal.fromJson(Map<String, dynamic> json) => UserWithdrawal(
        withdrawalId: json["withdrawal_id"],
        amount: json["amount"],
        email: json["email"],
        supervisorEmail: json["supervisor_email"],
        traderName: json["trader_name"],
        supervisorName: json["supervisor_name"],
        dateCreated: DateTime.parse(json["date_created"]),
      );

  Map<String, dynamic> toJson() => {
        "withdrawal_id": withdrawalId,
        "amount": amount,
        "email": email,
        "supervisor_email": supervisorEmail,
        "trader_name": traderName,
        "supervisor_name": supervisorName,
        "date_created": dateCreated.toIso8601String(),
      };
}

// To parse this JSON data, do
//
//     final listUsers = listUsersFromJson(jsonString);

ListUsers listUsersFromJson(String str) => ListUsers.fromJson(json.decode(str));

String listUsersToJson(ListUsers data) => json.encode(data.toJson());

class ListUsers {
  ListUsers({
    required this.allUsers,
  });

  List<AllUser> allUsers;

  factory ListUsers.fromJson(Map<String, dynamic> json) => ListUsers(
        allUsers: List<AllUser>.from(
            json["allUsers"].map((x) => AllUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "allUsers": List<dynamic>.from(allUsers.map((x) => x.toJson())),
      };
}

class AllUser {
  AllUser({
    required this.userId,
    required this.userTypeId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.dateCreated,
    required this.lastLogin,
  });

  String userId;
  String userTypeId;
  String firstName;
  String lastName;
  String email;
  String phone;
  DateTime dateCreated;
  DateTime lastLogin;

  factory AllUser.fromJson(Map<String, dynamic> json) => AllUser(
        userId: json["user_id"],
        userTypeId: json["user_type_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        dateCreated: DateTime.parse(json["date_created"]),
        lastLogin: DateTime.parse(json["last_login"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_type_id": userTypeId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "date_created": dateCreated.toIso8601String(),
        "last_login": lastLogin.toIso8601String(),
      };
}

UpdateSupervisors updateSupervisorsFromJson(String str) =>
    UpdateSupervisors.fromJson(json.decode(str));

String updateSupervisorsToJson(UpdateSupervisors data) =>
    json.encode(data.toJson());

class UpdateSupervisors {
  UpdateSupervisors({
    required this.status,
  });

  int status;

  factory UpdateSupervisors.fromJson(Map<String, dynamic> json) =>
      UpdateSupervisors(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
