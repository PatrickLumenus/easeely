import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:intl/intl.dart";

import "package:easeely/providers/Accounts.dart";
import "package:easeely/models/Reservation.dart";
import "package:easeely/providers/Device.dart";
import "package:easeely/providers/Reservations.dart";


class ReservationsScreen extends StatefulWidget {
  static String routeName = "/reservations";

  @override
  _ReservationsScreenState createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  Accounts _accounts;
  Device _deviceInfo;
  Reservations _reservations;
  DateFormat _format;

  @override
  Widget build(BuildContext context) {
    List<Reservation> _userReservations =
        _reservations.getForCustomer(_accounts.account);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0.0,
        title: Text("My Reservations",
            style: TextStyle(
              color: Colors.black,
            )),
      ),
      //drawer: AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: _deviceInfo.widthFromPercentage(context, 1.0),
            height: _deviceInfo.heightFromPercentage(context, 1.0),
            child: ((_userReservations.length > 0))
                ? ListView.builder(
                    itemCount: _userReservations.length,
                    itemBuilder: (context, index) {
                      Reservation res = _userReservations[index];
                      String title = res.lot.name;
                      DateTime start = res.schedule;
                      DateTime end = start.add(res.duration);
                      String date = _format.format(res.schedule);
                      String time =
                          "${start.hour}:${start.minute} - ${end.hour}:${end.minute}";
                      return ListTile(
                        title: Text(title),
                        trailing: Column(
                          children: <Widget>[
                            Text(res.lot.address.toString()),
                            Text(date + " @ " + time),
                          ],
                        ),
                      );
                    })
                : Center(child: Text("No Reservations")),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _accounts = Provider.of<Accounts>(context);
    _deviceInfo = Provider.of<Device>(context);
    _reservations = Provider.of<Reservations>(context);
    _format = DateFormat.yMd();
  }
}
