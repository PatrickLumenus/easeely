import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:easeely/models/Lot.dart";
import "package:easeely/models/EVCharger.dart";

import "package:easeely/providers/Device.dart";
import "package:easeely/providers/Lots.dart";

class HostLotDetailsScreen extends StatefulWidget {
  final Lot lot;

  HostLotDetailsScreen({@required this.lot});

  @override
  _HostLotDetailsScreenState createState() => _HostLotDetailsScreenState();
}

class _HostLotDetailsScreenState extends State<HostLotDetailsScreen> {
  Device _deviceInfo;
  Lots _lotsSource;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _brand;
  TextEditingController _tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0.0,
        title: Text(
          widget.lot.name,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: _deviceInfo.widthFromPercentage(context, 1.0),
            height: _deviceInfo.heightFromPercentage(context, 1.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 100.0,
                  width: 100.0,
                  margin: const EdgeInsets.all(2.0),
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(
                    "assets/images/lot.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: _deviceInfo.widthFromPercentage(context, 1.0),
                  height: _deviceInfo.heightFromPercentage(context, 0.1),
                  margin: const EdgeInsets.all(2.0),
                  padding: const EdgeInsets.all(2.0),
                  child: Text(widget.lot.description),
                ),
                Container(
                  //margin: const EdgeInsets.all(10.0),
                  //padding: const EdgeInsets.all(10.0),
                  child: Flexible(
                    child: ListView.builder(
                      itemCount: widget.lot.chargers.length,
                      itemBuilder: (context, index) {
                        EVCharger charger = widget.lot.chargers[index];
                        return ListTile(
                          title: Text(charger.brand),
                          trailing: Text(charger.tag),
                        );
                      }),
                )),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showNewChargerForm(context);
        },
      ),
    );
  }

  Future<void> _showNewChargerForm(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _brand,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Brand",
                          hintText: "required",
                        ),
                        validator: (String value) {
                          return value.isEmpty
                              ? "This field is required"
                              : null;
                        },
                      ),
                      TextFormField(
                        controller: _tag,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Tag",
                          hintText: "optional",
                        ),
                      ),
                      Center(
                        child: RaisedButton(
                            child: Text("Add Charger"),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _lotsSource.addEVCharger(
                                    widget.lot, _brand.text, _tag.text);
                                _brand.text = "";
                                _tag.text = "";
                                Navigator.pop(context);
                              }
                            }),
                      )
                    ],
                  ),
                )),
          );
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _deviceInfo = Provider.of<Device>(context);
    _lotsSource = Provider.of<Lots>(context);
  }

  @override
  void initState() {
    super.initState();
    _brand = TextEditingController();
    _tag = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _brand.dispose();
    _tag.dispose();
  }
}
