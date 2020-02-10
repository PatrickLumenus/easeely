
import "package:flutter/material.dart";

import "package:easeely/models/Reservation.dart";
import "package:easeely/models/account.dart";
import 'package:random_string/random_string.dart';
import "package:easeely/models/Lot.dart";

class Reservations with ChangeNotifier {
  List<Reservation> _reservations;

  Reservations() {
    this._reservations = [];
    this._populate();
  }

  void add({@required Account customer, @required Lot lot, @required DateTime schedule, @required Duration duration}) {
    this._reservations.add(Reservation(
      id: randomString(20),
      customer: customer,
      lot: lot,
      duration: duration,
      schedule: schedule
    ));
  }

  Reservation getById(String id) {
    return this._reservations.where((reservation) {
      return reservation.id == id;
    }).first;
  }

  List<Reservation> getForCustomer(Account cust) {
    return this._reservations.where((res) {
      return res.customer.name == cust.name;
    }).toList();
  }

  List<Reservation> getForHos(Account host) {
    return this._reservations.where((res) {
      return res.lot.host.name == host.name;
    });
  }

  void _populate() {

  }
}