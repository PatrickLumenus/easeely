import 'dart:ui';

import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:easeely/providers/Lots.dart";
import "package:easeely/providers/Device.dart";
import "package:easeely/providers/Accounts.dart";
import "package:easeely/components/app_drawer.dart";

import "package:easeely/screens/lot_details_screen.dart";

import "package:easeely/models/Lot.dart";

class DriverScreen extends StatefulWidget {
  static final String routeName = "/driver";

  @override
  _DriverScreenState createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  TextEditingController _searchQuery;
  List<Lot> _lots;
  Device device9nfo;
  Accounts accounts;

  @override
  Widget build(BuildContext context) {
    device9nfo = Provider.of<Device>(context);
    accounts = Provider.of<Accounts>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0.0,
        title: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
          controller: _searchQuery,
          onSubmitted: (query) {
            FocusScope.of(context).unfocus();
            this._searchLots(context);
          },
        ),
      ),
      drawer: AppDrawer(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: _lots.length == 0
              ? Center(
                  child: Text("No Lots to Show"),
                )
              // when there is a list of lots to show
              : SingleChildScrollView(
                  child: Container(
                    height: device9nfo.heightFromPercentage(context, 1.0),
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: _lots.length,
                      itemBuilder: (context, index) {
                        Lot lot = _lots[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LotDetailsScreen(
                                          lotId: lot.id,
                                        )));
                          },
                          child: Container(
                            margin: EdgeInsets.all(2.0),
                            padding: EdgeInsets.all(2.0),
                            child: ListTile(
                              leading: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.asset(
                                    "assets/images/lot.jpg",
                                    fit: BoxFit.cover,
                                  )),
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    lot.name,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(lot.host.toString()),
                                  Text(lot.address.toString())
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void _searchLots(BuildContext context) {
    print("Searching Lots");
    final lots = Provider.of<Lots>(context);
    String query = _searchQuery.text;
    _lots = (query.isNotEmpty) ? lots.findLots(query) : lots.getAll();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _lots = Provider.of<Lots>(context).getAll();
  }

  @override
  void initState() {
    super.initState();
    _searchQuery = TextEditingController();
    _lots = [];
  }

  @override
  void dispose() {
    super.dispose();
    _searchQuery.dispose();
  }
}
