import 'dart:convert';

import 'package:asoude/bloc/ProfileBloc.dart';
import 'package:asoude/constants/assets.dart';
import 'package:asoude/model/User.dart';
import 'package:asoude/utils/Utils.dart';
import 'package:asoude/widget/APICallLoading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:asoude/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProfilePage extends StatefulWidget {
  final int id;

  ProfilePage({Key key, this.id}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with WidgetsBindingObserver {
  ProfileBloc _profileBloc = ProfileBloc();
  BuildContext loadingContext;

  @override
  void initState() {
    _profileBloc.add(ProfileGet(id: widget.id));
    // if (Platform.isIOS) {
    //   KeyboardVisibilityNotification().addNewListener(onShow: () {
    //     showOverlay(context);
    //   }, onHide: () {
    //     removeOverlay();
    //   });
    // }
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  OverlayEntry overlayEntry;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ProfileBloc>(
            create: (BuildContext context) => _profileBloc,
          ),
        ],
        child:
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is ProfileLoading || state is ProfileUnloaded)
            return APICallLoading();
          return SingleChildScrollView(
              child: Container(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              _profileView(MediaQuery.of(context).size.width),
              _profileBody()
            ],
          )));
        }));
  }

  Widget _profileBody() =>
      BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        User user = state.user;
        String phone = user != null && user.phone != null ? user.phone : '';
        String email = user != null && user.email != null ? user.email : '';
        String type =
            user != null && user.userType != null && user.userType == 0
                ? 'کاربر شخصی'
                : 'کسب و کار';
        return Container(
            margin: EdgeInsets.only(top: 40),
            child: Column(
              children: [
                _keyValue(
                    Icon(
                      Icons.person_pin_outlined,
                      size: 40,
                      color: IColors.themeColor,
                    ),
                    type,
                    MediaQuery.of(context).size.width,
                    underlined: false),
                _keyValue(
                    Icon(
                      Icons.phone_android,
                      size: 30,
                      color: IColors.themeColor,
                    ),
                    phone,
                    MediaQuery.of(context).size.width),
                _keyValue(
                    Icon(
                      Icons.email_outlined,
                      size: 30,
                      color: IColors.themeColor,
                    ),
                    email,
                    MediaQuery.of(context).size.width),
              ],
            ));
      });

  Widget _keyValue(Widget icon, value, width, {underlined = true}) => Container(
      margin: EdgeInsets.only(top: 15, bottom: underlined ? 15 : 15),
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(right: width * .1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.right,
                  )),
              icon
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          constraints: BoxConstraints(maxWidth: width * .8),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: underlined
                          ? IColors.deactivePanelMenu
                          : Colors.transparent,
                      width: 3 / 4))),
        )
      ]));

  Widget _profileView(width) => BlocConsumer<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          loadingContext = context;
        } else if (state is ProfileLoaded || state is ProfileError) {}
        User user = state.user;
        double rate = user != null && user.rate != null ? user.rate : 0;
        int tradeCount =
            user != null && user.tradeCount != null ? user.tradeCount : 0;
        String name =
            user == null || user.name == null ? 'نام کاربری' : user.name;
        try {
          name = utf8.decode(name.toString().codeUnits);
        } catch (_) {}
        return Container(
            constraints:
                BoxConstraints.expand(width: width, height: width * 3 / 4),
            child: Stack(children: [
              Container(
                  constraints: BoxConstraints.expand(
                      width: width, height: width * 3 / 4),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: user != null && user.avatar != null
                              ? NetworkImage(user.avatar)
                              : AssetImage(Assets.loadingGif)),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                            color: IColors.black,
                            offset: Offset(1, 3),
                            blurRadius: 10)
                      ])),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(right: 15, left: 15),
                  constraints: BoxConstraints.expand(width: width, height: 50),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(10, 10, 10, .2),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar(
                        itemCount: 5,
                        initialRating: rate,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemSize: 15,
                        itemBuilder: (context, _) =>
                            Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {},
                      ),
                      _userDetail(tradeCount, name)
                    ],
                  ),
                ),
              )
            ]));
      },
      listener: (context, state) {});
}

Widget _userDetail(tradeCount, name) =>
    Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
        margin: EdgeInsets.only(right: 5, left: 5),
        padding: EdgeInsets.only(right: 5, left: 5),
        decoration: BoxDecoration(
            color: IColors.themeColor, borderRadius: BorderRadius.circular(10)),
        child: Text(
          '${tradeCount} معامله ',
          textAlign: TextAlign.center,
        ),
      ),
      Text(
        name,
        style: TextStyle(color: Colors.white),
      )
    ]);
