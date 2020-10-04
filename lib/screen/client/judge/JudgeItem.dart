import 'package:asoude/constants/assets.dart';
import 'package:asoude/constants/strings.dart';
import 'package:asoude/widget/ActionButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:asoude/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JudgeItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return JudgeItemState();
  }
}

class JudgeItemState extends State<JudgeItem> {
  Widget _condition(Condition condition) => Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              condition.title,
              style: TextStyle(fontSize: 12),
            ),
            SvgPicture.asset(
              Assets.checkboxIcon,
              width: 25,
              height: 25,
            )
          ],
        ),
      );

  Widget _description(String description, List<Condition> conditions,
          {width}) =>
      Container(
          constraints:
              BoxConstraints.expand(height: 330, width: width / 2 - 25),
          child: Stack(
            children: [
              Container(
                constraints:
                    BoxConstraints.expand(height: 300, width: width / 2 - 25),
                decoration: BoxDecoration(
                    color: IColors.whiteGrey,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding:
                    EdgeInsets.only(top: 25, bottom: 30, left: 15, right: 15),
                child: Column(
                  children: [
                    Text(
                      description,
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Expanded(
                      // alignment: Alignment.centerRight,
                      // constraints: BoxConstraints.expand(height: 230),
                      flex: 2,
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: conditions.map((c) => _condition(c)).toList(),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment(0, .93),
                child: Container(
                  child: ActionButton(
                    width: width / 2 - 60,
                    title: 'مدارک',
                    color: Colors.white,
                    callBack: () {},
                    textColor: Colors.black,
                    icon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: IColors.primary,
                    ),
                  ),
                ),
              )
            ],
          ));

  Widget _compare(width) {
    return Container(
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
              padding: EdgeInsets.only(top: 30),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _description(
                        'پیراهن به من فروخته پارست',
                        [
                          Condition(title: 'a', checked: true),
                          Condition(title: 'b', checked: false),
                          Condition(title: 'b', checked: false),
                          Condition(title: 'b', checked: false),
                          Condition(title: 'b', checked: false),
                          Condition(title: 'b', checked: false),
                        ],
                        width: width),
                    _description(
                        'خودت پاره‌ای اگه ببینمت',
                        [
                          Condition(title: 'a', checked: true),
                          Condition(title: 'b', checked: false)
                        ],
                        width: width),
                  ])),
          Align(
              alignment: Alignment(0, 1),
              child: Container(
                // alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.white),
                child: ActionButton(
                  rtl: true,
                  callBack: () {},
                  width: 100,
                  color: IColors.secondary,
                  title: 'در مقابل',
                  textColor: Colors.white,
                ),
              ))
        ],
      ),
    );
  }

  Widget _actions() => Container(
      margin: EdgeInsets.only(top: 30),
      constraints: BoxConstraints.expand(height: 200),
      child: Column(
        children: [
          ActionButton(
            title: Strings.tradeShouldCancel,
            color: IColors.secondary,
            rtl: true,
            width: 250,
            callBack: () {},
          ),
          SizedBox(
            height: 15,
          ),
          ActionButton(
            title: Strings.tradeShouldResume,
            color: IColors.primary,
            rtl: true,
            width: 250,
            callBack: () {},
          ),
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      constraints: BoxConstraints.expand(height: 800),
      child: Column(
        children: [_compare(MediaQuery.of(context).size.width), _actions()],
      ),
    );
  }
}

class Condition {
  String title;
  bool checked;

  Condition({this.title, this.checked});
}
