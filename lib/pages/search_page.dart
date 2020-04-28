import 'package:flutter/material.dart';
import 'package:fluttertrip/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SearchBar(
            hideLeft: true,
            defaultText: "hahhah",
            hint: "7987987",
            leftButtonClick: (){
              Navigator.pop(context);
            },
            onChanged: _onTextChange,
          ),

        ],
      ),
    );
  }

  _onTextChange(text) {

  }
}
