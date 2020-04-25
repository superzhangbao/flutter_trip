import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:bot_toast/bot_toast.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
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
                  onIndexChanged: (index) {
                    print("下标index:$index");
                  },
                  onTap: (index){
                    BotToast.showText(text: "$index");
                  },
                )
            )
          ],
        ),
      ),
    );

  }
}
