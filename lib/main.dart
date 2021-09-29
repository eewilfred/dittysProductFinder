
import 'package:flutter/material.dart';
import 'SearchResultpage.dart';


import 'package:flutter/material.dart';

void main() {
  runApp(Nav2App());
}

class Nav2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        // Handle '/'
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => HomeScreen());
        }

        // Handle '/details/:id'
        var uri = Uri.parse(settings.name!);
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'result') {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(builder: (context) => ListViewHomeLayout(unformatedItemsToSearch: id) );
        }

        return MaterialPageRoute(builder: (context) => UnknownScreen());
      },
    );
  }
}

class HomeScreen extends StatelessWidget {

  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: myController,
              decoration: InputDecoration(hintText: "Insert your message",),
              scrollPadding: EdgeInsets.all(20.0),
              keyboardType: TextInputType.multiline,
              autofocus: true,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(onSurface: Colors.red),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/result/' + myController.text,
                );
              },
              child: Text("Get Results"),
            )

          ],
        )
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  String id;

  DetailScreen({
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Product Finder"),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Viewing details for item $id'),
            FlatButton(
              child: Text('Pop!'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}

class EntrypageLayout extends StatefulWidget {

  @override
  Entrypage createState() {

    return new Entrypage();
  }
}
class Entrypage extends State<EntrypageLayout> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Finder"),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
