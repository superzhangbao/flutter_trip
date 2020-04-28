import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertrip/model/common_model.dart';
import 'package:fluttertrip/widget/web_view.dart';

class SubNav extends StatelessWidget {
  final List<CommonModel> subNavList;

  const SubNav({Key key, @required this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (subNavList == null) return null;
    List<Widget> items = [];
    subNavList.forEach((model) {
      items.add(_item(context, model));
    });
    //计算每行现实的数量
    int separate = (subNavList.length / 2 + 0.5).toInt();
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate, subNavList.length),
          ),
        ),
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel commonModel) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          BotToast.showText(text: commonModel.title);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebView(
                      url: commonModel.url,
                      statusBarColor: commonModel.statusBarColor,
                      title: commonModel.title,
                      hideAppBar: commonModel.hideAppBar)));
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(3, 5, 3, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                commonModel.icon,
                width: 18,
                height: 18,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.only(top: 6),
                child: Text(
                  commonModel.title,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
