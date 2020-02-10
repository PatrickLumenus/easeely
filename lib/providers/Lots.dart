import "package:flutter/material.dart";
import "package:random_string/random_string.dart";
import "package:money/money.dart";

import "package:easeely/models/Lot.dart";
import "package:easeely/models/account.dart";
import "package:easeely/models/Address.dart";
import "package:easeely/models/EVCharger.dart";
import "Accounts.dart";

class Lots with ChangeNotifier {
  List<Lot> _lots;

  Lots() {
    final accounts = Accounts().getAll();
    _lots = [];
    this._populate(accounts);
  }

  void addLot(String name, String description, Account host, Address address, double pricePerHour) {
    final newLot = Lot(
        id: randomString(20),
        name: name,
        description: description,
        host: host,
        address: address,
        chargers: [],
        perHourFee: Money.fromDouble(pricePerHour, Currency("usd")));

    this._lots.add(newLot);
    notifyListeners();
  }

  void removeLot(String lotId) {
    this._lots.removeWhere((lot) {
      return lot.id == lotId;
    });
    notifyListeners();
  }

  List<Lot> findLotsForHost(Account host) {
    final lots = this._lots.where((lot) {
      return lot.host.name == host.name;
    }).toList();
    notifyListeners();
    return lots;
  }

  List<Lot> getHostLots(Account host) {
    final lots = this._lots.where((lot) {
      return lot.host.name == host.name;
    }).toList();
    return lots;
  }

  Lot findLotById(String id) {
    return this._lots.where((lot) {
      return lot.id == id;
    }).first;
  }

  List<Lot> getAll() {
    return this._lots;
  }

  List<Lot> findLots(String query) {
    final foundLots = this._lots.where((lot) {
      return lot.address.toString().contains(query);
    });

    notifyListeners();
    return foundLots;
  }

  void addEVCharger(Lot lot, String brand, String tag) {
    this.findLotById(lot.id).addCharger(EVCharger(
      id: randomString(20),
      brand: brand,
      tag: tag
    ));
    notifyListeners();
  }

  void _populate(List<Account> accounts) {
    for (Account account in accounts) {
      final randInt = int.parse(randomNumeric(1));
      final lot = Lot(
        id: randomString(20),
        host: account,
        name: "Lot Near Great Area",
        description: "From they fine john he give of rich he. They age and draw mrs like. Improving end distrusts may instantly was household applauded incommode. Why kept very ever home mrs. Considered sympathize ten uncommonly occasional assistance sufficient not. Letter of on become he tended active enable to. Vicinity relation sensible sociable surprise screened no up as. ",
        chargers: [],
        perHourFee: Money.fromDouble(15.0, Currency("usd")),
        address: Address(
          line1: "${randomNumeric(4)} First Street",
          line2: "",
          city: (randInt > 4) ? "Wilson" : "Philidelphia",
          state: (randInt > 4) ? "Wilson" : "Philidelphia",
          id: randomString(20),
          postal: randomNumeric(5),
        )
      );

      _lots.add(lot);
    }

    notifyListeners();
  }
}
