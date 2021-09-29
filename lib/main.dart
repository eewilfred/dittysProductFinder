import 'package:flutter/material.dart';
import 'package:untitled/SearchResultModel.dart';
import 'package:untitled/SearchRequest.dart';
import 'dart:html' as html;



/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);
}

class ListViewHomeLayout extends StatefulWidget {

  String unformatedItemsToSearch;
  ListViewHomeLayout({
    required this.unformatedItemsToSearch,
  });

  @override
  ListViewHome createState() {
    
    return new ListViewHome(unformatedItemsToSearch);
  }
}
class ListViewHome extends State<ListViewHomeLayout> {
  late String unformatedItemsToSearch;

  var searchMap = Map<String, List<Value>>();
  List<String> searchItems = [
  "WMN-WM65RXU	Samsung Wallmount WMN-WM65R for Flip2 65",
  "DS-D5AW/Q	Hik Vision Wall-mounted Bracket, suitable for all models",
  "920-004519	Logitech Wireless Combo MK270 - ARA (102) - 2.4GHZ - INTNL",
  "920-004509	Logitech Wireless Combo MK270 - US INT'L - 2.4GHZ - INTNL",
  "981-000512	Logitech Wireless Headset Mono H820e  - USB  - EMEA28 - WIRELESS MONO",
  "210-1026P	Dell X Series Switches 210-1026P",
  "ANC6AUPYL-10MT	Avalon Network Yellow Colour Patch Cords ANC6AUPYL-10MT",
  "ANC6AUPYL-1MT	Avalon Network Yellow Colour Patch Cords ANC6AUPYL-1MT",
  "ANC6AUPYL-2MT	Avalon Network Yellow Colour Patch Cords ANC6AUPYL-2MT",
  "ANC6AUPYL-3MT	Avalon Network Yellow Colour Patch Cords ANC6AUPYL-3MT",
  "ANC6AUPYL-5MT	Avalon Network Yellow Colour Patch Cords ANC6AUPYL-5MT"
  ];

  List<ListItem> listViewData = [];

  final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time];
  var request = SearchRequest();
  List<Value> _results = [];
  ListViewHome(String unformatedItemsToSearch) {

    this.unformatedItemsToSearch = unformatedItemsToSearch;
    getSearchResults();
  }

  Future<void> getSearchResults() async {
    for (var searchterm in searchItems) {
      var results = await request.getResults(searchterm, "");
      setState(() {
        searchMap[searchterm] = results;
        listViewData.add(
          HeadingItem(searchterm)
        );
        for(var result in results) {
          listViewData.add(
              MessageItem(result)
          );
        }
        listViewData.add(Spacer());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listViewData.length ,
        itemBuilder: (context, index) {
          final item = listViewData[index];
          return item.buildTitle(context);
        });
  }
}



/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    var textStyle = TextStyle(
      color: Colors.black,
      fontSize: 25,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.double,
    );
    return SelectableText(
      heading,
      style: textStyle,
    );
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {

  final Value result;

  MessageItem(this.result);

  @override
  Widget buildTitle(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
        child: Column(
          children: [
            ListTile(

              title: SelectableText(result.title),
              subtitle: SelectableText(result.description),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(onSurface: Colors.red),
              onPressed: () {
                print("\n\n\nURL:::" + result.url);
                html.window.open(result.url,"_blank");
              },
              child: Text(result.url),
            )
          ],
        )
    );
  }
}

class Spacer implements ListItem {

  @override
  Widget buildTitle(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ColoredBox(
        color: Colors.white,
      ),
    );
  }
}