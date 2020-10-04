import 'dart:async';
import 'dart:convert';

import 'package:asoude/bloc/ProfileBloc.dart';
import 'package:asoude/model/User.dart';
import 'package:asoude/screen/profile/Avatar.dart';
import 'package:asoude/screen/profile/Header.dart';
import 'package:asoude/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:asoude/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  final int id;

  ProfilePage({Key key, this.id}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with WidgetsBindingObserver {
  AlertDialog _loadingDialog = getLoadingDialog();
  bool _loadingEnable;
  ProfileBloc _profileBloc = ProfileBloc();
  BuildContext loadingContext;

  @override
  void initState() {
    _profileBloc.add(ProfileGet(id: widget.id));
    _loadingEnable = false;
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
    _sub.cancel();
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
        child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Header(title: "پروفایل"),
                SizedBox(height: 10),
                _userInfoLabelWidget(),
                _userInfoWidget(),
                SizedBox(height: 20),
                SizedBox(height: 10),
                _supportWidget()
              ],
            )));
  }

  Widget _ProfileView(width) => Container(
    constraints: BoxConstraints.expand(width: width, height: width * 3/4),
    decoration: BoxDecoration(
      borderRadius:
    ),
  );

  _supportWidget() =>
      GestureDetector(
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: TextStyle(
                      fontFamily: 'iransans',
                      color: Colors.black87,
                      fontSize: 15),
                  children: <TextSpan>[
                    TextSpan(
                        text:
                        "لطفا انتقادات و پیشنهادات خود را با شماره تماس ۰۹۳۳۵۷۰۵۹۹۷ در واتس اپ یا تلگرام با تیم"),
                    TextSpan(
                        text: " مامله ",
                        style: TextStyle(
                            color: IColors.themeColor,
                            fontWeight: FontWeight.bold)),
                    TextSpan(text: "در میان بگذارید ")
                  ]),
            )),
      );

  _userInfoWidget() {
    // User user = User(
    //     username: 'abas',
    //     name: 'gholoomi',
    //     avatar:
    //         'https://i.picsum.photos/id/719/300/300.jpg?hmac=LumeKhy-hJsLsniO_ajSrRJJxeRzqg7tXAdxZ6hOE_c',
    //     rate: 10,
    //     phone: '09366637984',
    //     email: 'gholleam@adsf.asdf',
    //     userType: 0);
    return BlocConsumer<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            // showDialog(
            //     context: context,
            //     builder: (BuildContext context) {
            //       loadingContext = context;
            //       return _loadingDialog;
            //     });
            // _loadingEnable = true;
          } else if (state is ProfileLoaded || state is ProfileError) {
            // _loadingEnable = false;
            // Navigator.of(loadingContext).pop();
          }
          User user = state.user;
          String name = user == null || user.name == null ? 'نام کاربری' : user.name;
          try {
            name = utf8.decode(name
                .toString()
                .codeUnits);
          } catch (_) {}
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Column(
                  children: <Widget>[
                  Text(name, style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text(
                  "${user == null || user.phone == null ? 'شماره تلفن' : replaceFarsiNumber(user.phone)}",
                  style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(width: 20),
          Avatar(user:
          user
          )
          ,
          ]
          ,
          );
        },
        listener: (context, state) {});
  }

  _userInfoLabelWidget() =>
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text("اطلاعات کاربری",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right),
      );

  StreamSubscription _sub;
}
