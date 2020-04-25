import 'package:flutter/material.dart';
import 'package:fluttertrip/pages/home_page.dart';
import 'package:fluttertrip/pages/mine_page.dart';
import 'package:fluttertrip/pages/search_page.dart';
import 'package:fluttertrip/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _countIndex = 0;

  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(),
          TravelPage(),
          MinePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _countIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _countIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _defaultColor,
              ),
              activeIcon: Icon(Icons.home, color: _activeColor),
              title: Text('首页',
                  style: TextStyle(
                      color: _countIndex != 0 ? _defaultColor : _activeColor))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _defaultColor,
              ),
              activeIcon: Icon(Icons.search, color: _activeColor),
              title: Text('搜索',
                  style: TextStyle(
                      color: _countIndex != 1 ? _defaultColor : _activeColor))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.camera_alt,
                color: _defaultColor,
              ),
              activeIcon: Icon(Icons.camera_alt, color: _activeColor),
              title: Text('旅拍',
                  style: TextStyle(
                      color: _countIndex != 2 ? _defaultColor : _activeColor))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                color: _defaultColor,
              ),
              activeIcon: Icon(Icons.account_circle, color: _activeColor),
              title: Text('我的',
                  style: TextStyle(
                      color: _countIndex != 3 ? _defaultColor : _activeColor))),
        ],
      ),
    );
  }
}