import 'dart:ffi';

class Store {
  /// store Id
  String Id = "";

  /// store Name
  String Name = "";
}

class Users {
  /// userId
  String Id = "";

  /// user Name
  String Name = "";

  /// user role   "owner |   employee"
  UserRole Role = UserRole.owner;

  /// store id
  String StoreId = "";
}

class Customer {
  /// customer Id
  String Id = "";

  /// customer Name
  String Name = "";

  /// store id
  String StoreId = "";
}

class Orders {
  /// Order ID
  String Id = '';

  /// Order Name  like  "1 kg sugar"
  String ProductName = "";

  /// Order Date
  DateTime CreationDate = DateTime.now();

  /// Order Amount
  double Amount = 0;

  bool IsPaid = false;

  /// Customer ID
  String CustomerId = "";

  /// store id
  String StoreId = "";
}

class Transactions {
  Int Id = 0 as Int;

  DateTime CreationDate = DateTime.now();

  double Amount = 0;

  /// Customer ID
  String CustomerId = "";

  String OrderId = "";

  /// store id
  String StoreId = "";
}

enum UserRole { owner, emp }
