import "package:flutter/material.dart";

class Account {

  String _name;
  String _licensePlate;

  Account({@required String name, @required String license}) {
    this._name = name;
    this._licensePlate = license;
  }

  String get name {
    return this._name;
  }

  String get licensePlate {
    return this._licensePlate;
  }

  @override
  String toString() {
    return this.name;
  }
}