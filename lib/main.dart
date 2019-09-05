import 'package:flutter/material.dart';
import 'welcome_page.dart';
import 'users_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lenguaje de Señas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/users': (context) => UsersPage(),
      },
    );
  }
}
