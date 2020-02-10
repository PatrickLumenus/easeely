import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:easeely/providers/Lots.dart";
import "package:easeely/models/Address.dart";
import "package:easeely/providers/Accounts.dart";
import "package:random_string/random_string.dart";

class CreateLotScreen extends StatefulWidget {
  static final String routeName = "/lots/create";
  @override
  _CreateLotScreenState createState() => _CreateLotScreenState();
}

class _CreateLotScreenState extends State<CreateLotScreen> {
  TextEditingController _lotName;
  TextEditingController _lotDescription;
  TextEditingController _addressLine1;
  TextEditingController _addressLine2;
  TextEditingController _addressCity;
  TextEditingController _addressState;
  TextEditingController _addressZip;
  TextEditingController _pricePerHour;
  final _formKey = GlobalKey<FormState>();
  FocusNode _nameFocus;
  FocusNode _descriptionFocus;
  FocusNode _addressline1Focus;
  FocusNode _addressLine2Focus;
  FocusNode _addressCityFocus;
  FocusNode _addressStateFocus;
  FocusNode _addressZipFocus;
  FocusNode _pricePerHourFocus;
  Lots _lotSource;
  Accounts _accountsSource;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0.0,
        title: Text(
          "Register New Lot",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(2.0),
            padding: const EdgeInsets.all(2.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _lotName,
                    focusNode: _nameFocus,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => this._changeFocus(context, _nameFocus, _descriptionFocus),
                    decoration: InputDecoration(
                      labelText: "Lot Title",
                      hintText: "My Lot with EV Charger.",
                    ),
                    validator: (String value) {
                      return value.isEmpty ? "This field is required" : null;
                    },
                  ),
                  TextFormField(
                    controller: _lotDescription,
                    focusNode: _descriptionFocus,
                    onEditingComplete: () => this._changeFocus(context, _descriptionFocus, _addressline1Focus),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Description",
                      hintText:
                          "This is my lot. It's got grass. And there is the parking space with the Tesla Charger",
                    ),
                    validator: (String value) {
                      return value.isEmpty ? "This field is required" : null;
                    },
                    minLines: 1,
                    maxLines: 5,
                    maxLength: 240,
                  ),
                  TextFormField(
                    controller: _addressLine1,
                    onEditingComplete: () => this._changeFocus(context, _addressline1Focus, _addressLine2Focus),
                    focusNode: _addressline1Focus,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Address Line 1",
                      hintText: "123 4th Street",
                    ),
                    validator: (String value) {
                      return value.isEmpty ? "This field is required" : null;
                    },
                  ),
                  TextFormField(
                    controller: _addressLine2,
                    focusNode: _addressLine2Focus,
                    onEditingComplete: () => this._changeFocus(context, _addressLine2Focus, _addressCityFocus),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Address Line 2",
                      hintText: "optional",
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (String value) {
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _addressCity,
                    focusNode: _addressCityFocus,
                    onEditingComplete: () => this._changeFocus(context, _addressCityFocus, _addressStateFocus),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "City",
                      hintText: "Philidelphia",
                    ),
                    validator: (String value) {
                      return value.isEmpty ? "This field is required" : null;
                    },
                  ),
                  TextFormField(
                    controller: _addressState,
                    focusNode: _addressStateFocus,
                    onEditingComplete: () => this._changeFocus(context, _addressStateFocus, _addressZipFocus),
                    maxLength: 2,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "State",
                      hintText: "PA",
                    ),
                    validator: (String value) {
                      return value.isEmpty ? "This field is required" : null;
                    },
                  ),
                  TextFormField(
                    controller: _addressZip,
                    focusNode: _addressZipFocus,
                    onEditingComplete: () => this._changeFocus(context, _addressZipFocus, _pricePerHourFocus),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: "Postal Code",
                      hintText: "12345",
                    ),
                    validator: (String value) {
                      return value.isEmpty ? "This field is required" : null;
                    },
                  ),
                  TextFormField(
                    controller: _pricePerHour,
                    focusNode: _pricePerHourFocus,
                    onEditingComplete: () => _pricePerHourFocus.unfocus(),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: "Price per Hour",
                      hintText: "8.00",
                    ),
                    validator: (String value) {
                      return value.isEmpty ? "This field is required" : null;
                    },
                  ),
                  Center(
                    child: RaisedButton(
                      child: Text("Create Lot"),
                      onPressed: () {
                        // create the lot
                        if (_formKey.currentState.validate()) {
                          Address addr = Address(
                            line1: _addressLine1.text,
                            line2: _addressLine2.text,
                            city: _addressCity.text,
                            state: _addressState.text,
                            postal: _addressZip.text,
                            id: randomString(20),
                          );
                          _lotSource.addLot(
                              _lotName.text,
                              _lotDescription.text,
                              _accountsSource.account,
                              addr,
                              double.parse(_pricePerHour.text));
                          Navigator.pop(context);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _changeFocus(BuildContext context, FocusNode currentFocus, FocusNode newFocus) {
    //FocusScope.of(context).unfocus();
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(newFocus);
  }

  @override
  void initState() {
    super.initState();
    _lotName = TextEditingController();
    _lotDescription = TextEditingController();
    _addressLine1 = TextEditingController();
    _addressLine2 = TextEditingController();
    _addressCity = TextEditingController();
    _addressState = TextEditingController();
    _addressZip = TextEditingController();
    _pricePerHour = TextEditingController();
    _nameFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _addressline1Focus = FocusNode();
    _addressLine2Focus = FocusNode();
    _addressCityFocus = FocusNode();
    _addressStateFocus = FocusNode();
    _addressZipFocus = FocusNode();
    _pricePerHourFocus = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _lotSource = Provider.of<Lots>(context);
    _accountsSource = Provider.of<Accounts>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _lotName.dispose();
    _lotDescription.dispose();
    _addressLine1.dispose();
    _addressLine2.dispose();
    _addressCity.dispose();
    _addressState.dispose();
    _addressZip.dispose();
    _pricePerHour.dispose();
    _nameFocus = FocusNode();
    _descriptionFocus.dispose();
    _addressline1Focus.dispose();
    _addressLine2Focus.dispose();
    _addressCityFocus.dispose();
    _addressStateFocus.dispose();
    _addressZipFocus.dispose();
    _pricePerHourFocus.dispose();
  }
}
