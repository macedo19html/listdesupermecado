import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listdesupermecado/pages/settings.dart';
import 'models/Lista.dart';
import 'pages/home.dart';
import 'pages/about.dart';
import 'pages/settings.dart';

class Layout {
  static final pages = [HomePage.tag, AboutPage.tag, SettingsPage.tag];

  static int currItem = 0;
  static Scaffold getContent(BuildContext context, content,
      [bool showbtton = true]) {
    BottomNavigationBar bottonNavBar = BottomNavigationBar(
      currentIndex: currItem,
      fixedColor: primary(),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
        BottomNavigationBarItem(
            icon: Icon(Icons.question_answer), title: Text('Sobre')),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), title: Text('Cofiguraçoes'))
      ],
      onTap: (int i) {
        currItem = i;
        Navigator.of(context).pushReplacementNamed(pages[i]);
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Layout.primary(),
        title: Text('ListadeSupermecado'),
        actions: showbtton ? _getActions(context) : [],
      ),
      bottomNavigationBar: showbtton ? bottonNavBar : null,
      body: content,
    );
  }

  static List<Widget> _getActions(BuildContext context) {
    List<Widget> Items = List<Widget>();

    TextEditingController _c = TextEditingController();

    if (pages[currItem] == HomePage.tag) {
      Items.add(GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext ctx) {
              final input = TextField(
                controller: _c,
                autofocus: true,
                decoration: InputDecoration(
                    hintText: 'Nome',
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              );

              return AlertDialog(
                title: Text('Nova lista'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[input],
                  ),
                ),
                actions: <Widget>[
                  RaisedButton(
                    color: secondary(),
                    child: Text('Cancelar',
                        style: TextStyle(color: Layout.light())),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  ),
                  RaisedButton(
                    color: primary(),
                    child: Text('Adicionar',
                        style: TextStyle(color: Layout.light())),
                    onPressed: () {
                      ModelLista listaMs = ModelLista();

                      listaMs.insert({
                        'name': _c.text,
                        'created': DateTime.now().toString()
                      }).then((newRowId) {
                        Navigator.of(ctx).pop();
                        Navigator.of(ctx).pushReplacementNamed(HomePage.tag);
                      });
                    },
                  )
                ],
              );
            });
      },
      child: Icon(Icons.add),
    ));
    }

    Items.add(Padding(padding: EdgeInsets.only(right: 20)));
    return Items;
  }

  static Color primary([double opacity = 1]) =>
      Color.fromRGBO(62, 63, 89, opacity);
  static Color secondary([double opacity = 1]) =>
      Color.fromRGBO(150, 150, 191, opacity);
  static Color light([double opacity = 1]) =>
      Color.fromRGBO(242, 234, 228, opacity);
  static Color dart([double opacity = 1]) =>
      Color.fromRGBO(51, 51, 51, opacity);

  static Color danger([double opacity = 1]) =>
      Color.fromRGBO(217, 74, 74, opacity);
  static Color success([double opacity = 1]) =>
      Color.fromRGBO(5, 100, 50, opacity);
  static Color info([double opacity = 1]) =>
      Color.fromRGBO(100, 150, 255, opacity);
  static Color warning([double opacity = 1]) =>
      Color.fromRGBO(166, 134, 0, opacity);
}
