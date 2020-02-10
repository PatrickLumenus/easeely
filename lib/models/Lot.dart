import "package:flutter/material.dart";

import "package:money/money.dart";

import "package:easeely/models/Address.dart";
import 'package:easeely/models/EVCharger.dart';
import "package:easeely/models/account.dart";


class Lot {
  String _id;
  String _name;
  Account _host;
  Address _address;
  List<EVCharger> _chargers;
  String _description;
  Money _pricePerHour;

  Lot({
    @required String id,
    @required Account host,
    @required String name,
    @required Address address,
    List<EVCharger> chargers,
    String description,
    Money perHourFee
  }) {
    this._id = id;
    this._host = host;
    this._name = name;
    this._address = address;
    this._chargers = (chargers != null) ? chargers : [];
    this._description = description;
    this._pricePerHour = perHourFee;
  }

  String get id {
    return this._id;
  }

  String get name {
    return this._name;
  }

  Address get address {
    return this._address;
  }

  String get description {
    return this._description;
  }

  List<EVCharger> get chargers {
    return this._chargers;
  }

  String get pricePerHour {
    return this._pricePerHour.amountAsString;
  }

  Account get host {
    return this._host;
  }

  void addCharger(EVCharger charger) {
    this._chargers.add(charger);
  }

  bool removeCharger(EVCharger charger) {
    return this._chargers.remove(charger);
  }
}
