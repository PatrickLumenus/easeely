import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:easeely/components/host_app_drawer.dart";
import "package:easeely/providers/Lots.dart";
import "package:easeely/models/Lot.dart";
import "package:easeely/providers/Accounts.dart";
import "package:easeely/providers/Device.dart";
import "package:easeely/screens/host_lot_details_screen.dart";
import "package:easeely/screens/create_lot_screen.dart";

class HostsScreen extends StatefulWidget {
  static final String routeName = "/host";
  @override
  _HostsScreenState createState() => _HostsScreenState();
}

class _HostsScreenState extends State<HostsScreen> {
  Lots _lotsSource;
  Accounts _accountsSource;
  Device _deviceInfo;
  List<Lot> _myLots;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // show the add lot form.
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateLotScreen()));
            },
          ),
        ],
        backgroundColor: Colors.white,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0.0,
        title: Text(
          "My Lots",
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: HostAppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: _deviceInfo.widthFromPercentage(context, 1.0),
            height: _deviceInfo.heightFromPercentage(context, 1.0),
            child: (_myLots.length > 0)
                ? ListView.builder(
                    itemCount: _myLots.length,
                    itemBuilder: (context, index) {
                      Lot lot = _myLots[index];
                      return GestureDetector(
                        onTap: () {
                          // show details of lot.
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return HostLotDetailsScreen(lot: lot,);
                          }));
                        },
                        child: ListTile(
                          leading: Container(
                            width: 100.0,
                            height: 100.0,
                            child: Image.asset("assets/images/lot.jpg",
                                fit: BoxFit.cover),
                          ),
                          title: Text(lot.name),
                          trailing: Text("EV Chargers: ${lot.chargers.length}"),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text("Not Lots"),
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
    _accountsSource = Provider.of<Accounts>(context);
    _lotsSource = Provider.of<Lots>(context);
    _myLots = _lotsSource.getHostLots(_accountsSource.account);
  }
}
