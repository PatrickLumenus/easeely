import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:easeely/screens/home_screen.dart";
import "package:easeely/providers/Accounts.dart";


class HostAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/profile.png"),
                    ),
                  ),
                ),
                Text(
                  Provider.of<Accounts>(context).account.name,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text("Return to Home Screen"),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
