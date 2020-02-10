import "package:flutter/material.dart";

import "package:easeely/models/account.dart";
import "package:easeely/models/Lot.dart";

class Reservation {
  String _id;
  Account _customer;
  Lot _lot;
  DateTime _start;
  Duration _duration;

  Reservation({@required String id, @required Account customer, @required Lot lot, @required DateTime schedule, @required Duration duration}) {
    this._id = id;
    this._customer = customer;
    this._lot = lot;
    this._start = schedule;
    this._duration = duration;
  }

  String get id {
    return this._id;
  }

  Account get customer {
    return this._customer;
  }

  DateTime get schedule {
    return this._start;
  }

  Duration get duration {
    return this._duration; 
  }

  Lot get lot {
    return this._lot;
  }

  DateTime get end {
    return this._start.add(this.duration);
  }
}