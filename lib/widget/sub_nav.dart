import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertrip/model/common_model.dart';
import 'package:fluttertrip/widget/web_view.dart';

class LocalNav extends StatelessWidget {
  final List<CommonModel> localNavList;

  const LocalNav({Key key, @required this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (localNavList == null) return null;
    List<Widget> items = [];
    localNavList.forEach((model) {
      items.add(_item(context, model));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _item(BuildContext context, CommonModel commonModel) {
    return GestureDetector(
      onTap: () {
        BotToast.showText(text: commonModel.title);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
                WebView(url: commonModel.url,
                    statusBarColor: commonModel.statusBarColor,
                    title: commonModel.title,
                    hideAppBar: commonModel.hideAppBar)
            )
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            commonModel.icon,
            width: 32,
            height: 32,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.only(top: 3),
            child: Text(
              commonModel.title,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
