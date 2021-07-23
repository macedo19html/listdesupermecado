
import 'package:flutter/material.dart';
import 'package:listdesupermecado/pages/items.dart';
import 'package:listdesupermecado/pages/settings.dart';
import 'pages/home.dart';
import 'pages/about.dart';
import 'pages/items.dart';
import 'layout.dart';
import 'pages/settings.dart';


void main() => runApp(ListadeSupermecado());

class ListadeSupermecado extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    HomePage.tag: (context) => HomePage(),
    AboutPage.tag: (context) => AboutPage(),
    SettingsPage.tag: (context) => SettingsPage(),
    ItemsPage.tag: (context) => ItemsPage()
  };

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'ListdeSupermecado',
      theme: ThemeData(
          primaryColor: Layout.primary(),
          accentColor: Layout.secondary(),
          brightness: Brightness.light,
          textTheme: TextTheme(
              // ignore: deprecated_member_use
              headline: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
              // ignore: deprecated_member_use
              title: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  color: Layout.primary()),
              // ignore: deprecated_member_use
              body1: TextStyle(fontSize: 14)
          )
      ),
      home: HomePage(),
      routes: routes,
    );
  }
}
