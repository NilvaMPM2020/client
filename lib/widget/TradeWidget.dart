import 'package:asoude/constants/assets.dart';
import 'package:asoude/constants/colors.dart';
import 'package:asoude/utils/Utils.dart';
import 'package:asoude/widget/ActionButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TradeWidget extends StatefulWidget {
  final String avatar;
  final String fullName;
  final int tradesCount;
  final String date;
  final String tradeName;
  final String tradeDesc;
  final String tradePrice;

  TradeWidget(
      {this.avatar,
        this.fullName,
      this.tradeName,
      this.tradesCount,
      this.date,
      this.tradePrice,
      this.tradeDesc});

  @override
  _TradeWidgetState createState() => _TradeWidgetState();
}

class _TradeWidgetState extends State<TradeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _tradeHeaderWidget(),
          SizedBox(height: 20),
          _tradeDetailWidget(),
          SizedBox(height: 10),
          _tradeCostWidget(),
          SizedBox(height: 20),
          _tradeActionsWidget(),
        ],
      ),
    );
  }

  _tradeActionsWidget() => ActionButton(
        width: MediaQuery.of(context).size.width * 0.6,
        color: IColors.themeColor,
        title: "پرداخت",
        icon: SvgPicture.asset(Assets.payIcon),
        rtl: true,
        callBack: () {},
      );

  _tradeCostWidget() => Container(
        padding: EdgeInsets.only(right: 12, left: 12),
        width: MediaQuery.of(context).size.width * 0.6,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Color.fromRGBO(237, 239, 243, 1),
          border: Border.all(color: Color.fromRGBO(237, 239, 243, 1), width: 3),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl,
          children: [
            Text("مبلغ"),
            Text(replaceFarsiNumber(widget.tradePrice)),
            Text("ریال")
          ],
        ),
      );


  _tradeDetailWidget() => Container(
      width: MediaQuery.of(context).size.width * 0.65,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(color: Color.fromRGBO(243, 244, 246, 1), width: 3),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(right: 24),
            width: MediaQuery.of(context).size.width * 0.3,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Center(
                child: Text(widget.tradeName,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold))),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              border:
                  Border.all(color: Color.fromRGBO(243, 244, 246, 1), width: 3),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Center(child: Text(widget.tradeDesc)),
          ),
        ],
      ));

  _tradeHeaderWidget() => Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _headerAvatarWidget(),
          _headerDataWidget(),
          _headerRateWidget()
        ],
      );

  List<Widget> _starsWidget() {
    final list =
        List.generate(3, (i) => Icon(Icons.star, color: Colors.amber)).toList();
    list.add(Icon(Icons.star_half, color: Colors.amber));
    return list;
  }

  _headerRateWidget() => Column(
        children: [
          Row(children: _starsWidget()),
          Text(replaceFarsiNumber(widget.date),
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey))
        ],
      );

  _headerDataWidget() => Column(
        children: [
          Text(
            widget.fullName,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textDirection: TextDirection.rtl,
          ),
          Text(
            " ${replaceFarsiNumber(widget.tradesCount.toString())} معامله       ",
            style: TextStyle(fontSize: 12),
            textDirection: TextDirection.rtl,
          ),
        ],
      );

  CircleAvatar _headerAvatarWidget() {
    return CircleAvatar(
      backgroundImage: widget.avatar == null ? AssetImage(Assets.mameleLogo) :NetworkImage(widget.avatar),
    );
  }
}
