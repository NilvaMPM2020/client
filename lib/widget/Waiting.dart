
import 'package:asoude/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Waiting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(IColors.themeColor),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "منتظر باشید",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
