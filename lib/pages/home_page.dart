import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:bot_toast/bot_toast.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    "http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg",
    "http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg",
    "http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg"
  ];
  double _appBarAlpha = 0;

  _onScroll(double offset) {
    var alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      _appBarAlpha = alpha;
    });
    print(_appBarAlpha);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
              // ignore: missing_return
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  //滚动且是列表滚动的时候
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  Container(
                      height: 160,
                      child: Swiper(
                        itemCount: _imageUrls.length,
                        autoplay: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            _imageUrls[index],
                            fit: BoxFit.fill,
                          );
                        },
                        pagination: SwiperPagination(),
                        viewportFraction: 0.95,
                        scale: 0.95,
                        scrollDirection: Axis.horizontal,
                        loop: true,
                        fade: 0.8,
                        onIndexChanged: (index) {},
                        onTap: (index) {
                          BotToast.showText(text: "$index");
                        },
                      )),
                  Container(height: 800, child: ListTile(title: Text("哈哈哈")))
                ],
              ),
            ),
          ),
          Opacity(
            opacity: _appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("首页"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
