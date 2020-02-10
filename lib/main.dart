import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:flutter/services.dart";

import "package:easeely/screens/home_screen.dart";
import "package:easeely/screens/driver_screen.dart";
import "package:easeely/screens/reservations_screen.dart";
import "package:easeely/screens/host_screen.dart";

import "package:easeely/providers/Accounts.dart";
import "package:easeely/providers/Device.dart";
import "package:easeely/providers/Lots.dart";
import "package:easeely/providers/Reservations.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Accounts(),
        ),
        ChangeNotifierProvider(
          create: (_) => Device(),
        ),
        ChangeNotifierProvider(
          create: (_) => Lots(),
        ),
        ChangeNotifierProvider(
          create: (context) => Reservations(),
        ),
      ],
      child: Consumer<Accounts>(
        builder: (context, account, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomeScreen(),
            routes: {
              HomeScreen.routeName: (context) => HomeScreen(),
              DriverScreen.routeName: (context) => DriverScreen(),
              ReservationsScreen.routeName: (context) => ReservationsScreen(),
              HostsScreen.routeName: (context) => HostsScreen(),
            },
          );
        },
      ),
    );
  }
}
