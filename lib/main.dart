import 'package:easy_tax_map/pages/LoginPage.dart';
import 'package:easy_tax_map/pages/MainPage.dart';
import 'package:easy_tax_map/provider/LocationProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/MainProvider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        // MainProvider
        ChangeNotifierProvider<LocationProvider>(
            create: (_) => LocationProvider()),
        ChangeNotifierProvider<MainProvider>(create: (_) => MainProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EasyTaxMap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => MainPage(),
      },
    );
  }
}
