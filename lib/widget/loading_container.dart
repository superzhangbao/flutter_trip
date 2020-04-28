import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 加载进度条组建
class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  //是否覆盖布局
  final bool cover;

  const LoadingContainer(
      {Key key,
      @required this.isLoading,
      this.cover = true,
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      if(cover) {
        return Stack(
          children: <Widget>[
            child,
            _loadingView,
          ],
        );
      }else{
        return _loadingView;
      }
    } else {
      return child;
    }
  }

  Widget get _loadingView {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(140, 0, 0, 0),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.lightBlue,
          ),
        ),
      ),
    );
  }
}
