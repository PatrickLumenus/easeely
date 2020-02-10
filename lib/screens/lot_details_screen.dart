import "package:flutter/material.dart";

import "package:provider/provider.dart";

import "package:easeely/providers/Lots.dart";
import "package:easeely/providers/Device.dart";
import "package:easeely/models/Lot.dart";
import "package:easeely/screens/create_reservation_screen.dart";

class LotDetailsScreen extends StatefulWidget {
  final String lotId;
  static String routeName = "/lot/details";

  LotDetailsScreen({Key key, @required this.lotId});

  @override
  _LotDetailsScreenState createState() => _LotDetailsScreenState();
}

class _LotDetailsScreenState extends State<LotDetailsScreen> {
  Lot _lot;
  Device _deviceInfo;
  TextEditingController _hoursController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0.0,
        title: Text(
          _lot.name,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.all(2.0),
                padding: EdgeInsets.all(2.0),
                height: 200.0,
                width: 200.0,
                child: Image.asset(
                  "assets/images/lot.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(2.0),
              padding: EdgeInsets.all(5.0),
              width: _deviceInfo.widthFromPercentage(context, 1.0),
              height: _deviceInfo.heightFromPercentage(context, 0.2),
              child: Text(_lot.description),
            ),
            Container(
              margin: EdgeInsets.all(2.0),
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10.0),
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/profile.png")),
                    ),
                  ),
                  Text(
                    _lot.host.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            // Make reservation
            Container(
              width: _deviceInfo.widthFromPercentage(context, 1.0),
              height: _deviceInfo.heightFromPercentage(context, 0.08),
              child: SizedBox.expand(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: Colors.green,
                  child: Text(
                    "Make Reservation (\$${_lot.pricePerHour} per hour)",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateReservationScreen(
                            lot: _lot,
                          ),
                        ));
                  },
                ),
              ),
            ),
            // show the chargers available.
            Container(
              margin: const EdgeInsets.only(
                top: 10.0,
                bottom: 2.0,
              ),
              padding: const EdgeInsets.all(2.0),
              child: Text(
                "Available Chargers",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: _deviceInfo.widthFromPercentage(context, 1.0),
              height: _deviceInfo.heightFromPercentage(context, 0.5),
              margin: EdgeInsets.all(2.0),
              child: ListView.builder(
                itemCount: _lot.chargers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _lot.chargers[index].brand,
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _lot = Provider.of<Lots>(context).findLotById(widget.lotId);
    _deviceInfo = Provider.of<Device>(context);
  }

  @override
  void initState() {
    super.initState();
    _hoursController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _hoursController.dispose();
  }
}
