import 'package:flutter/material.dart';
import 'package:listdesupermecado/layout.dart';


class AboutPage extends StatelessWidget {
  static String tag = 'about-page';
  @override
  Widget build(BuildContext context) {
    return Layout.getContent(context, Center(
        child: Text('Este app foi criado por List Aplicativos',
        style: TextStyle(color: Layout.dart()),
        ),
      ),
    );
  }
}
