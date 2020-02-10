import "dart:math";

import "package:flutter/material.dart";

import "package:easeely/models/account.dart";

class Accounts with ChangeNotifier {

  final List<Account> accountChoices = [
    new Account(name: "Eelon Mask", license: "ABCD-1234"),
    new Account(name: "Eelizabeth Holmes", license: "DCBA4321"),
    new Account(name: "Eelvis Presley", license: ""),
  ];

  Account selectedAccount;

  Accounts() {
    //
  }

  Account selectAccount() {
    final random = Random();
    final randomInt = random.nextInt(accountChoices.length);
    this.selectedAccount = accountChoices[randomInt];
    notifyListeners();
    return this.account;
  }

  Account get account {
    return this.selectedAccount;
  }

  List<Account> getAll() {
    return this.accountChoices;
  }
}
