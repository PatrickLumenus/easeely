import "package:flutter/material.dart";

class Address {
  String _id;
  String _line1;
  String _line2;
  String _city;
  String _state;
  String _postal;

  Address({@required String id, @required String line1, String line2, @required String city, @required String state, @required String postal}) {
    this._id = id;
    this._line1 = line1;
    this._line2 = line2;
    this._city = city;
    this._state = state;
    this._postal = postal;
  }

  String get id {
    return this._id;
  }

  String get line1 {
    return this._line1;
  }

  String get line2 {
    return this._line2;
  }

  String get street {
    return this.line1 + " " + this.line2;
  }

  String get city {
    return this._city;
  }

  String get state {
    return this._state;
  }

  String get postalCode {
    return this._postal;
  }

  @override
  String toString() {
    String street = this.line1;
    street += this.line2 != null ? this.line2 + ", " : ", ";
    return street + this.city + " " + this.state + " " + this.postalCode;
  }
}