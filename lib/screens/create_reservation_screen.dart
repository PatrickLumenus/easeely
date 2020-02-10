import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:provider/provider.dart";
import "package:intl/intl.dart";
import "package:datetime_picker_formfield/datetime_picker_formfield.dart";

import "package:easeely/providers/Device.dart";
import "package:easeely/providers/Reservations.dart";
import "package:easeely/providers/Accounts.dart";
import "package:easeely/models/Lot.dart";

class CreateReservationScreen extends StatefulWidget {
  final Lot lot;
  static String routeName = "/reservations/create";

  CreateReservationScreen({
    this.lot,
  });

  @override
  _CreateReservationScreenState createState() =>
      _CreateReservationScreenState();
}

class _CreateReservationScreenState extends State<CreateReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _duration;
  Device _deviceInfo;
  Reservations _reservations;
  Accounts _accounts;
  DateTime _schedule;
  DateFormat _format;
  TextEditingController _scheduleController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0.0,
        title: Text(
          "Create Reservation",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
          margin: EdgeInsets.all(2.0),
          padding: EdgeInsets.all(2.0),
          width: _deviceInfo.widthFromPercentage(context, 1.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  width: _deviceInfo.widthFromPercentage(context, 1.0),
                  child: TextFormField(
                    enabled: false,
                    initialValue: widget.lot.name,
                    decoration: InputDecoration(
                      labelText: "Name",
                    ),
                  ),
                ),
                Container(
                  width: _deviceInfo.widthFromPercentage(context, 1.0),
                  child: TextFormField(
                    enabled: false,
                    initialValue: widget.lot.address.toString(),
                    decoration: InputDecoration(
                      labelText: "Address",
                    ),
                  ),
                ),
                Container(
                  width: _deviceInfo.widthFromPercentage(context, 1.0),
                  child: Center(
                    child: DateTimeField(
                      controller: _scheduleController,
                      decoration: InputDecoration(
                        labelText: "Schedule",
                        hintText: "Select Schedule"
                      ),
                      onChanged: (DateTime dt) {
                        setState(() {
                          _scheduleController.text = _format.format(dt);
                          print(_format.format(dt));
                          _schedule = dt;
                        });
                      },
                      format: _format,
                      onShowPicker: (context, currentValue) async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 2)));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  width: _deviceInfo.widthFromPercentage(context, 1.0),
                  child: TextFormField(
                    controller: _duration,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    decoration:
                        InputDecoration(labelText: "Minutes", hintText: "60"),
                  ),
                ),
                Container(
                  width: _deviceInfo.widthFromPercentage(context, 1.0),
                  child: Center(
                    child: RaisedButton(
                      child: Text("Make Reservation"),
                      onPressed: () {
                        // make the reservation.
                        _reservations.add(
                            customer: _accounts.account,
                            lot: widget.lot,
                            duration:
                                Duration(minutes: int.parse(_duration.text)),
                            schedule: _schedule);
                        
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _deviceInfo = Provider.of<Device>(context);
    _reservations = Provider.of<Reservations>(context);
    _accounts = Provider.of<Accounts>(context);
  }

  @override
  void initState() {
    super.initState();
    _duration = TextEditingController();
    _duration.text = "60";
    _format = DateFormat.yMd().add_jm();
    _scheduleController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _duration.dispose();
    _scheduleController.dispose();
  }
}
