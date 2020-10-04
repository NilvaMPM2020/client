import 'dart:async';

import 'package:asoude/bloc/AuthBloc.dart';
import 'package:asoude/bloc/timer/TimerBloc.dart';
import 'package:asoude/bloc/timer/TimerEvent.dart';
import 'package:asoude/bloc/timer/Tricker.dart';
import 'package:asoude/constants/colors.dart';
import 'package:asoude/constants/strings.dart';
import 'package:asoude/screen/HomePage.dart';
import 'package:asoude/utils/Utils.dart';
import 'package:asoude/widget/ActionButton.dart';
import 'package:asoude/widget/InputField.dart';
import 'package:asoude/widget/OptionButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:asoude/widget/Timer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:asoude/networking/Response.dart';
import 'RoleType.dart';
import 'package:rxdart/rxdart.dart';


enum StartType { SIGN_UP, LOGIN }

class StartPage extends StatefulWidget {
  StartPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  TimerBloc _timerBloc = TimerBloc(ticker: Ticker());
  final AuthBloc _authBloc = AuthBloc();

  String currentPhoneNumber = "";
  StreamController<RoleType> _controller = BehaviorSubject();
  final _phoneNumberController = TextEditingController();
  final _doctorIdController = TextEditingController();
  final _verificationController = TextEditingController();
  final _fullNameController = TextEditingController();

  RoleType currentRoleType = RoleType.USER;
  StartType startType = StartType.SIGN_UP;
  AlertDialog _loadingDialog = getLoadingDialog();
  bool _loadingEnable;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  handle(Response response) {
    switch (response.status) {
      case Status.LOADING:
        showDialog(
            context: context,
            builder: (BuildContext context) => _loadingDialog);
        _loadingEnable = true;
        return false;
      case Status.ERROR:
        if (_loadingEnable) {
          Navigator.of(context).pop();
          _loadingEnable = false;
        }
        showErrorSnackBar(response.error.toString());
        return false;
      default:
        if (_loadingEnable) {
          Navigator.of(context).pop();
          _loadingEnable = false;
        }
        return true;
    }
  }

  showErrorSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    ));
  }

  Future<void> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("token")) {
      bool isUser = prefs.getBool("isUser");
      switchRole(isUser ? RoleType.USER : RoleType.COMPANY);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage(isUser: isUser)));
    }
  }

  bool resendCodeEnabled = false;

  void resetTimer() {
    _timerBloc = TimerBloc(ticker: Ticker());
    _timerBloc.add(Start(duration: 60));
    listenToTime();
  }

  @override
  void initState() {
    switchRole(currentRoleType);
    checkToken();
    listenToTime();
    _authBloc.loginStream.listen((data) {
      if (handle(data)) {
        setState(() {
          startType = StartType.LOGIN;
        });
        _timerBloc.add(Start(duration: 60));
      }
    });

    _authBloc.verifyStream.listen((data) {
      if (handle(data)) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage(isUser: currentRoleType == RoleType.USER)));
      }
    });

    super.initState();
  }

  void listenToTime() {
    _timerBloc.listen((time) {
      setState(() {
        resendCodeEnabled = time.duration == 0;
      });
    });
  }

  void switchRole(RoleType roleType) {
    _controller.add(roleType);
    IColors.changeThemeColor(roleType);
//    BlocProvider.of<EntityBloc>(context).add(EntityChangeType(type: roleType));
    setState(() {
      currentRoleType = roleType;
    });
  }

  void submit({bool resend}) {
    if (_formKey.currentState.validate()) {
      if(_phoneNumberController.text.isNotEmpty){
        currentPhoneNumber = _phoneNumberController.text;
      }
      _phoneNumberController.text = "";
      setState(() {
        switch (startType) {
          case StartType.SIGN_UP:
            _authBloc.login(currentPhoneNumber);
            break;
          case StartType.LOGIN:
            if (resend != null && resend) {
                _authBloc.login(currentPhoneNumber);
              resetTimer();
            } else {
              _authBloc.verify(currentPhoneNumber, currentRoleType, int.parse(_verificationController.text));
            }
            break;
        }
      });
    }
  }

  void back() {
    _verificationController.text = "";
    _phoneNumberController.text = "";
    setState(() {
      startType = StartType.SIGN_UP;
    });
    resetTimer();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (startType == StartType.LOGIN) {
          setState(() {
            startType = StartType.SIGN_UP;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 80),
                _optionsWidget(),
                SizedBox(height: 40),
                _titleWidget(),
                SizedBox(height: 5),
                _messageWidget(),
                SizedBox(height: 50),
                _inputFieldsWidget(),
                SizedBox(height: 10),
                _timerWidget(),
                SizedBox(height: 80),
                _actionWidget(),
                SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    _phoneNumberController.dispose();
    _doctorIdController.dispose();
    _verificationController.dispose();
    _fullNameController.dispose();
    _authBloc.dispose();
    super.dispose();
  }

  _timerWidget() => startType == StartType.LOGIN
      ? Padding(
          padding: EdgeInsets.only(right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Visibility(
                  visible: !resendCodeEnabled,
                  child: BlocProvider(
                      create: (context) => _timerBloc, child: Timer())),
              GestureDetector(
                onTap: () => submit(resend: true),
                child: Text(" ارسال مجدد کد",
                    style: TextStyle(
                        color: IColors.themeColor,
                        fontWeight: FontWeight.bold,
                        decoration: resendCodeEnabled
                            ? TextDecoration.underline
                            : TextDecoration.none)),
              ),
            ],
          ),
        )
      : SizedBox.shrink();

  _actionWidget() {
    switch (startType) {
      case StartType.SIGN_UP:
        return _signUpActionWidget();
      case StartType.LOGIN:
        return _loginActionWidget();
    }
  }

  _loginActionWidget() => Padding(
      padding: EdgeInsets.only(left: 40.0, right: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ActionButton(
            color: isContinueEnable ? IColors.themeColor : Colors.grey,
            title: Strings.continueAction,
            callBack: submit,
          ),
          GestureDetector(
            onTap: back,
            child: Container(
                decoration: BoxDecoration(
                    color: IColors.themeColor,
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(Icons.arrow_forward_ios,
                      size: 18, color: Colors.white),
                )),
          ),
        ],
      ));

  _signUpActionWidget() => ActionButton(
        color: IColors.themeColor,
        title: "دریافت کد",
        rtl: false,
        callBack: submit,
      );

  _optionsWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Visibility(
              visible: currentRoleType == RoleType.COMPANY ||
                  startType == StartType.SIGN_UP,
              child: GestureDetector(
                onTap: () => switchRole(RoleType.COMPANY),
                child:
                    OptionButton(RoleType.COMPANY, stream: _controller.stream),
              )),
          SizedBox(width: 20),
          Visibility(
            visible: currentRoleType == RoleType.USER ||
                startType == StartType.SIGN_UP,
            child: GestureDetector(
              onTap: () => switchRole(RoleType.USER),
              child: OptionButton(RoleType.USER, stream: _controller.stream),
            ),
          )
        ],
      );

  _messageWidget() => Text(
        startType == StartType.SIGN_UP ? "با مامله مطمئن و ساده پرداخت کنید" : "کد ارسال شده به ایمیل یا شماره همراه خود را\n وارد کنید",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      );

  _titleWidget() => Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: startType == StartType.SIGN_UP,
        child: Text(
          "مامله",
          style: TextStyle(
              color: IColors.themeColor,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      );

  _inputFieldsWidget() => Padding(
      padding: EdgeInsets.only(left: 40.0, right: 40.0),
      child: Container(child: _inputFieldsInnerWidget()));

  _isVerificationCodeValid(String validationCode) => validationCode.length == 6;

  bool isContinueEnable = false;

  _inputFieldsInnerWidget() {
    switch (startType) {
      case StartType.SIGN_UP:
        return InputField(
          inputHint: Strings.usernameInputHint,
          controller: _phoneNumberController,
          textInputType: TextInputType.phone,
          validationCallback: (text) => validatePhoneNumber(text),
          errorMessage: "شماره همراه معتبر نیست",
          onChanged: (text){},
        );
      case StartType.LOGIN:
        return InputField(
            inputHint: Strings.verificationHint,
            controller: _verificationController,
            textInputType: TextInputType.number,
            validationCallback: (text) =>
                _isVerificationCodeValid(text) || resendCodeEnabled,
            errorMessage: "کدفعالسازی ۶رقمی است",
            onChanged: (text) {
              setState(() {
                isContinueEnable = _isVerificationCodeValid(text);
              });
            });
    }
  }

}
