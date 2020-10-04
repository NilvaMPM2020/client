import 'package:asoude/constants/assets.dart';
import 'package:asoude/constants/colors.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;

  Header({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Container(
              margin: EdgeInsets.only(top: 20, right: 20),
              width: 40,
              child: Image.asset(Assets.mameleLogo)),
          alignment: Alignment.centerRight,
        ),
        _headerWidget()
      ],
    );
  }

  _headerWidget() => Visibility(
        visible: title != null,
        child: Center(
            child: Text(title == null ? "" : title,
                style: TextStyle(color: IColors.themeColor, fontSize: 24))),
      );
}
