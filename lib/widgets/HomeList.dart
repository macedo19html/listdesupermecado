import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:listdesupermecado/pages/items.dart';
import '../models/Lista.dart';
import '../pages/items.dart';
import '../pages/home.dart';
import '../layout.dart';

enum ListAction { edit, delete }

class HomeList extends StatefulWidget {
  final List<Map> Items;

  HomeList({this.Items}) : super();

  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {

  ModelLista listaMs = ModelLista();
  @override
  Widget build(BuildContext context) {
    // Item default
    if (widget.Items.length == 0) {
      return ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.pages),
            title: Text('Nenhuma lista cadastrada ainda...'),
          )
        ],
      );
    }

    DateFormat df = DateFormat('dd/MM/yy HH:mm');

    return ListView.builder(
      itemCount: widget.Items.length,
      itemBuilder: (BuildContext context, int index) {
        Map item = widget.Items[index];
        DateTime created = DateTime.tryParse(item['created']);
        return ListTile(
          leading: Icon(Icons.pages, size: 42),
          title: Text(item['name']),
          subtitle: Text(df.format(created)),
          trailing: PopupMenuButton<ListAction>(
            onSelected: (ListAction result) {
              switch (result) {
                case ListAction.edit:
                  this.showEditDialog(context, item);
                  break;
                case ListAction.delete:
                  listaMs.delete(item['pk_lista']).then((deleted) {
                    if (deleted) {
                      Navigator.of(context).pushReplacementNamed(HomePage.tag);
                    }
                  });
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<ListAction>>[
                PopupMenuItem<ListAction>(
                  value: ListAction.edit,
                  child:
                      Row(children: <Widget>[Icon(Icons.edit), Text('Editar')]),
                ),
                PopupMenuItem<ListAction>(
                  value: ListAction.delete,
                  child: Row(
                      children: <Widget>[Icon(Icons.delete), Text('Excluir')]),
                )
              ];
            },
          ),
          onTap: () {
            //Aponta na lista esta selecionada
            ItemsPage.pkList = item['pk_lista'];

            //Muda de pagina
            Navigator.of(context).pushNamed(ItemsPage.tag);
          },
        );
      },
    );
  }

  void showEditDialog(BuildContext context, Map item) {
    TextEditingController _cEdit = TextEditingController();
    _cEdit.text = item['name'];

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          final input = TextFormField(
            controller: _cEdit,
            autofocus: true,
            decoration: InputDecoration(
                hintText: 'Nome',
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          );

          return AlertDialog(
            title: Text('Editar'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[input],
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                color: Layout.secondary(),
                child:
                    Text('Cancelar', style: TextStyle(color: Layout.light())),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
              RaisedButton(
                color: Layout.primary(),
                child: Text('Salvar', style: TextStyle(color: Layout.light())),
                onPressed: () {
                  ModelLista listaMs = ModelLista();
                  listaMs.update({
                    'name': _cEdit.text,
                    'created': DateTime.now().toString()
                  }, item['pk_lista']).then((saned) {
                    Navigator.of(ctx).pop();
                    Navigator.of(ctx).pushReplacementNamed(HomePage.tag);
                  });
                },
              )
            ],
          );
        });
  }
}
