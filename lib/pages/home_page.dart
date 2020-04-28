import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:fluttertrip/dao/home_dao.dart';
import 'package:fluttertrip/model/common_model.dart';
import 'package:fluttertrip/model/grid_nav_model.dart';
import 'package:fluttertrip/model/sales_box_model.dart';
import 'package:fluttertrip/widget/grid_nav.dart';
import 'package:fluttertrip/widget/loading_container.dart';
import 'package:fluttertrip/widget/local_nav.dart';
import 'package:fluttertrip/widget/sales_box.dart';
import 'package:fluttertrip/widget/sub_nav.dart';
import 'package:fluttertrip/widget/web_view.dart';

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
  List<CommonModel> localnavList = [];
  List<CommonModel> subNavList = [];
  List<CommonModel> bannerList = [];
  GridNavModel gridNavModel;
  SalesBoxModel salesBoxModel;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

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

 Future<Null> _handleRefresh() async {
    HomeDao.fetch().then((result) {
      setState(() {
        _loading = false;
        localnavList = result.localNavList;
        gridNavModel = result.gridNav;
        subNavList = result.subNavList;
        salesBoxModel = result.salesBox;
        bannerList = result.bannerList;
      });
    }).catchError((error) {
      setState(() {
        _loading = false;
        print(error.toString());
      });
    });

    return null;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: LoadingContainer(
          isLoading: _loading,
          child: Stack(
            children: <Widget>[
              MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: RefreshIndicator(
                    onRefresh: _handleRefresh,
                    child: NotificationListener(
                      // ignore: missing_return
                      onNotification: (scrollNotification) {
                        if (scrollNotification is ScrollUpdateNotification &&
                            scrollNotification.depth == 0) {
                          //滚动且是列表滚动的时候
                          _onScroll(scrollNotification.metrics.pixels);
                        }
                      },
                      child: _listView,
                    )),
              ),
              _appBar,
            ],
          ),
        ),
    );
  }

  Widget get _listView{
    return ListView(
      children: <Widget>[
       _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localnavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: GridNav(gridNavModel: gridNavModel),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(subNavList: subNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SalesBox(salesBox: salesBoxModel),
        ),
      ],
    );
  }

  Widget get _banner{
    return Container(
      height: 160,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            bannerList[index].icon,
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(),
        viewportFraction: 0.8,
        scale: 0.9,
        scrollDirection: Axis.horizontal,
        loop: true,
        fade: 0.7,
        onIndexChanged: (index) {},
        onTap: (index) {
          BotToast.showText(text: "$index");
          var bannerPage = bannerList[index];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebView(
                url: bannerPage.url,
                title: bannerPage.title,
                hideAppBar: bannerPage.hideAppBar,
                statusBarColor: bannerPage.statusBarColor,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget get _appBar{
    return Opacity(
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
    );
  }
}
