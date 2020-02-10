
import "package:flutter/material.dart";

import "package:provider/provider.dart";

import "package:easeely/providers/Accounts.dart";

import "package:easeely/screens/driver_screen.dart";
import "package:easeely/screens/host_screen.dart";

/// The HomeScreen
///
/// The Home Screen is the start of the entrie demo. From the HomeScreen, users can choose to view
/// the demo as a user or as a host.
///

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Accounts accounts;

  @override
  Widget build(BuildContext context) {
    accounts = Provider.of<Accounts>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Center(
                child: Text(
                  "Easeely",
                  style: TextStyle(
                    fontSize: 50.0,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text(
                  "Insert description here",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Start Demo",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("Try as Driver"),
                        onPressed: () {
                          accounts.selectAccount();
                          Navigator.pushReplacementNamed(context, DriverScreen.routeName);
                        },
                      ),
                      RaisedButton(
                        child: Text("Try as Host"),
                        onPressed: () {
                          accounts.selectAccount();
                          Navigator.pushNamed(context, HostsScreen.routeName);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
