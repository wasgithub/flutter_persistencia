import 'package:fluter_persistencia/screens/contact_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contatos'),
        ),
        body: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text(
                  'Was',
                  style: TextStyle(fontSize: 24),
                ),
                subtitle: Text(
                  '1000',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(builder: (context) => ContactForm(),)
                ).then((newContact) => debugPrint(newContact.toString()),);
          },
        ));
  }
}
