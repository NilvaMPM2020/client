import 'package:asoude/model/User.dart';
import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:asoude/constants/colors.dart';

class Avatar extends StatelessWidget {
  final User user;

  const Avatar({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width * 0.25,
        child: ClipPolygon(
          sides: 6,
          rotate: 90,
          boxShadows: [
            PolygonBoxShadow(color: Colors.black, elevation: 1.0),
            PolygonBoxShadow(color: Colors.grey, elevation: 5.0)
          ],
          child: user != null && user.avatar != null
              ? Image.network(user.avatar)
              : Image.asset("assets/avatar.png"),
        ),
      ),
      Visibility(
        visible: true,
        child: Positioned(
          bottom: 0,
          left: 16,
          child: Icon(
            Icons.brightness_1,
            color: IColors.themeColor,
            size: 16,
          ),
        ),
      ),
    ]);
  }
}
