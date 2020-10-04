import 'package:asoude/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomButtomNavigation extends StatefulWidget {
  final List<NavigationItem> children;
  Function(int) onTap;
  int index;

  CustomButtomNavigation({this.index, this.children});

  @override
  State<StatefulWidget> createState() {
    return CustomButtomNavigationState();
  }
}

class CustomButtomNavigationState extends State<CustomButtomNavigation> {
  int currentIndex = -1;

  @override
  initState() {
    if (currentIndex == -1) currentIndex = widget.index;
    super.initState();
  }

  Color _getItemColor(itemIndex) =>
      itemIndex == currentIndex ? Colors.white : Colors.black;

  @override
  Widget build(BuildContext context) {
    int i = 0;
    return Container(
        constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width),
        child: Container(
          child: Stack(
            children: [
              widget.children[currentIndex].widget,
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  constraints: BoxConstraints.expand(
                      height: 80, width: MediaQuery.of(context).size.width),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35)),
                      boxShadow: [
                        BoxShadow(
                            color: IColors.darkGrey,
                            offset: Offset(1, 3),
                            blurRadius: 15),
                      ]),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  constraints: BoxConstraints.expand(
                      width: MediaQuery.of(context).size.width, height: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.children
                        .map((c) => _navItem(i++, c.icon, c.title))
                        .toList(),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _navItem(itemIndex, icon, title) {
    bool isActive = itemIndex == currentIndex;
    return isActive
        ? AnimatedNavigationItem(
            isActive: isActive,
            title: title,
            icon: icon,
            onTap: () {
              setState(() {
                currentIndex = itemIndex;
              });
            },
          )
        : NavigationItemWidget(
            isActive: isActive,
            title: title,
            icon: icon,
            onTap: () {
              setState(() {
                currentIndex = itemIndex;
              });
            },
          );
  }
}

class AnimatedNavigationItem extends StatefulWidget {
  Function onTap;
  bool isActive;
  String icon;
  String title;

  AnimatedNavigationItem(
      {Key key, this.onTap, this.isActive, this.icon, this.title})
      : super(key: key);

  @override
  _AnimatedNavigationItemState createState() => _AnimatedNavigationItemState();
}

class _AnimatedNavigationItemState extends State<AnimatedNavigationItem>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _controller.forward(from: 0);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor: _animation,
        axis: Axis.vertical,
        // axisAlignment: -1,
        child: NavigationItemWidget(
            isActive: widget.isActive,
            title: widget.title,
            icon: widget.icon,
            onTap: widget.onTap));
  }
}

class NavigationItemWidget extends StatefulWidget {
  Function onTap;
  bool isActive;
  String icon;
  String title;

  NavigationItemWidget({this.onTap, this.isActive, this.icon, this.title});

  @override
  State<StatefulWidget> createState() {
    return NavigationItemWidgetState();
  }
}

class NavigationItemWidgetState extends State<NavigationItemWidget> {
  Color _getItemColor() => widget.isActive ? Colors.white : Colors.black;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints.expand(
              height: widget.isActive ? 100 : 80, width: 80),
          decoration: BoxDecoration(
            color: (widget.isActive ? IColors.themeColor : Colors.transparent),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                widget.icon,
                color: _getItemColor(),
                width: 30,
              ),
              widget.isActive
                  ? Text(
                      widget.title,
                      style: TextStyle(color: _getItemColor()),
                    )
                  : Container()
            ],
          ),
        ));
  }
}

class NavigationItem {
  Widget widget;
  String icon;
  String title;

  NavigationItem({this.widget, this.icon, this.title});
}
