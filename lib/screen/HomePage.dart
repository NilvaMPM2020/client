import 'package:asoude/constants/assets.dart';
import 'package:asoude/constants/colors.dart';
import 'package:asoude/screen/client/judge/JudgeItem.dart';
import 'package:asoude/screen/CreateServicePage.dart';
import 'package:asoude/screen/MyTradesPage.dart';
import 'package:asoude/screen/client/judge/JudgePage.dart';
import 'package:asoude/screen/profile/ProfilePage.dart';
import 'package:asoude/widget/CustomButtomNavigation.dart';
import 'package:asoude/widget/RaisedGradientButton.dart';
import 'package:asoude/widget/TradeWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  final bool isUser;

  HomePage({this.isUser});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomButtomNavigation(children: [
      NavigationItem(
          widget: _getWidgetOptions()[0],
          title: 'حساب کاربری',
          icon: Assets.menuIcon),
      NavigationItem(
          widget: _getWidgetOptions()[4],
          title: 'معامله‌های من',
          icon: Assets.dealIcon),
      widget.isUser
          ? NavigationItem(
              widget: _getWidgetOptions()[2],
              title: 'داوری',
              icon: Assets.lawIcon)
          : NavigationItem(
              widget: _getWidgetOptions()[4],
              title: 'محصولات من',
              icon: Assets.lawIcon),
      NavigationItem(
          widget: _getWidgetOptions()[3], title: 'خانه', icon: Assets.homeIcon),
    ], index: 1));
    //   Scaffold(
    //   body: _getWidgetOptions().elementAt(_currentIndex),
    //   bottomNavigationBar: BottomNavigationBar(
    //     items: <BottomNavigationBarItem>[
    //       BottomNavigationBarItem(
    //         icon: _bottomNavItem(Assets.menuIcon, 0),
    //         title: Text("حساب کاربری",
    //             style: TextStyle(fontWeight: FontWeight.bold)),
    //       ),
    //       BottomNavigationBarItem(
    //         icon: _bottomNavItem(Assets.dealIcon, 1),
    //         title: Text("معامله‌های من",
    //             style: TextStyle(fontWeight: FontWeight.bold)),
    //       ),
    //       BottomNavigationBarItem(
    //         icon: _bottomNavItem(Assets.lawIcon, 2),
    //         title: Text("داوری", style: TextStyle(fontWeight: FontWeight.bold)),
    //       ),
    //       BottomNavigationBarItem(
    //         icon: _bottomNavItem(Assets.homeIcon, 3),
    //         title: Text("خانه", style: TextStyle(fontWeight: FontWeight.bold)),
    //       ),
    //     ],
    //     currentIndex: _currentIndex,
    //     selectedItemColor: IColors.themeColor,
    //     onTap: _onItemTapped,
    //   ),
    // );
  }

  Container _bottomNavItem(String asset, int index) => Container(
      constraints: BoxConstraints.expand(
          width: MediaQuery.of(context).size.width / 4, height: 40),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              child: (SvgPicture.asset(
                asset,
                color: _getBottomNavigationColor(index, secondary: Colors.grey),
                width: 30,
              ))),
          Align(
              alignment: Alignment(0, -1.65),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _getBottomNavigationColor(index),
                    boxShadow: [
                      BoxShadow(
                          color: _getBottomNavigationColor(index),
                          offset: Offset(1, 3),
                          blurRadius: 10)
                    ]),
                width: 10,
                height: 10,
              ))
        ],
      ));

  Color _getBottomNavigationColor(index,
      {primary, secondary = Colors.transparent}) {
    if (primary == null) primary = IColors.themeColor;
    return _currentIndex == index ? primary : secondary;
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  _getWidgetOptions() => [
        ProfilePage(),
        CreateServicePage(),
        JudgePage(),
        Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Assets.mameleLogo, width: 120, height: 120),
            Text(
              "مامله",
              style: TextStyle(
                  color: IColors.themeColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            SizedBox(
              height: 40,
            ),
            _landingPageFirstItem(),
            SizedBox(height: 20),
            _landingPageSecondItem(),
          ],
        )),
        MyTradesPage(),
      ];

  Widget _landingPageSecondItem() {
    if (widget.isUser) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _currentIndex = 1;
          });
        },
        child: _serviceButtonWidget(
            "معاملات من",
            "معامله‌های اخیر خود را رصد کنید",
            Assets.addDealIcon,
            Color.fromRGBO(254, 187, 1, 1),
            Color.fromRGBO(255, 164, 72, 1)),
      );
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            _currentIndex = 1;
          });
        },
        child: _serviceButtonWidget(
            "معامله‌های من",
            "معامله‌های اخیر خود را رصد کنید",
            Assets.addDealIcon,
            Color.fromRGBO(254, 187, 1, 1),
            Color.fromRGBO(255, 164, 72, 1)),
      );
    }
  }

  Widget _landingPageFirstItem() {
    if (widget.isUser) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _currentIndex = 2;
          });
        },
        child: _serviceButtonWidget(
            "داوری",
            "در داوری معامله‌ها کمک کن",
            Assets.dealIcon,
            Color.fromRGBO(32, 167, 202, 1),
            Color.fromRGBO(34, 197, 185, 1)),
      );
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateServicePage()));
        },
        child: _serviceButtonWidget(
            "ایجاد معامله",
            "معامله خود را ایجاد کنید",
            Assets.dealReqIcon,
            Color.fromRGBO(32, 167, 202, 1),
            Color.fromRGBO(34, 197, 185, 1)),
      );
    }
  }

  Widget _serviceButtonWidget(String title, String subTitle, String asset,
          Color fColor, Color sColor) =>
      Center(
        child: RaisedGradientButton(
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    Text(
                      subTitle,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: Colors.white60, fontSize: 14),
                    )
                  ],
                ),
                SvgPicture.asset(
                  asset,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          gradient: LinearGradient(
            colors: <Color>[fColor, sColor],
          ),
        ),
      );
}
