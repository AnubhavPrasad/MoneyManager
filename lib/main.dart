import 'package:flutter/material.dart';
import 'package:money_manager/controllers/user_repository.dart';
import 'package:provider/provider.dart';

import 'screens/HomeScreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider<UserRepository>(
      create: (BuildContext context) => UserRepository(),
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.teal,
          accentColor: Colors.teal.shade100,
        ),
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
