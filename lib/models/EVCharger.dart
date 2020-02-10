import "package:flutter/material.dart";

class EVCharger {
  String _id;
  String _brand;
  String _tag;

  EVCharger({@required String id, @required String brand, @required String tag}) {
    this._id = id;
    this._brand = brand;
    this._tag = tag;
  }

  String get id {
    return this._id;
  }

  String get brand {
    return this._brand;
  }

  String get tag {
    return this._tag;
  }
}