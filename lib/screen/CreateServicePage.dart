import 'package:asoude/bloc/ServiceBloc.dart';
import 'package:asoude/constants/assets.dart';
import 'package:asoude/constants/colors.dart';
import 'package:asoude/model/TradeResponseEntity.dart';
import 'package:asoude/utils/Utils.dart';
import 'package:asoude/widget/InputField.dart';
import 'package:asoude/widget/RaisedGradientButton.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateServicePage extends StatefulWidget {
  CreateServicePage();

  @override
  _CreateServicePage createState() => _CreateServicePage();
}

class _CreateServicePage extends State<CreateServicePage> {
  int _currentStep = 0;
  ServiceBloc _bloc = ServiceBloc();

  @override
  void initState() {
    _bloc.listen((state) {
      if (state is CreateServiceLoaded) {
        ClipboardManager.copyToClipBoard(state.result.link);
        showOneButtonDialog(context, "لینک کپی شد", "بازگشت", (){
          Navigator.of(context).pop();
        });

      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (context) {
      return Container(
        child: _currentStep == 0
            ? Column(children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _productWidget(),
                      SizedBox(height: 20),
                      _serviceCostWidget(),
                    ],
                  ),
                )),
                _actionsWidget("انصراف", "بعدی")
              ])
            : Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        _timeWidget(),
                        SizedBox(height: 20),
                        _descWidget(),
                        SizedBox(height: 20),
                        _conditionsWidget(),
                      ],
                    ),
                  )),
                  _actionsWidget("قبلی", "دریافت لینک")
                ],
              ),
      );
    }));
  }

  _conditionsWidget() => Padding(
        padding: EdgeInsets.only(right: 48.0),
        child: Column(
          children: [
            _condition(Condition(title: " پارگی یا خراش نداشته باشد")),
            _condition(Condition(title: "با تصویر منطبق باشد")),
          ],
        ),
      );

  Widget _condition(Condition condition) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              textDirection: TextDirection.rtl,
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
          ),
        ],
      );

  int _timeSelected = 24;

  _descWidget() => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 48.0),
                child: Text(
                  "توضیحات",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 48.0),
                child: Text(
                  "دقت شود برای فسخ معامله فقط موارد زیر میتواند مورد بررسی قرار بگیرد",
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
        ],
      );

  _timeWidget() => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 48.0),
                child: Text(
                  "زمان انتقال",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          RaisedGradientButton(
            child: Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset("assets/pay_time.svg"),
                    _timeBoxWidget(72),
                    _timeBoxWidget(48),
                    _timeBoxWidget(24),
                  ],
                )),
            gradient: LinearGradient(
              colors: <Color>[
                Color.fromRGBO(34, 197, 185, 1),
                Color.fromRGBO(32, 167, 202, 1)
              ],
            ),
          ),
        ],
      );

  Widget _timeBoxWidget(int time) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _timeSelected = time;
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          gradient: _timeSelected == time
              ? LinearGradient(
                  colors: <Color>[
                    Color.fromRGBO(254, 187, 1, 1),
                    Color.fromRGBO(255, 164, 72, 1)
                  ],
                )
              : LinearGradient(
                  colors: <Color>[
                    Color.fromRGBO(255, 255, 255, 1),
                    Color.fromRGBO(255, 255, 255, 1)
                  ],
                ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [Text(replaceFarsiNumber(time.toString())), Text("ساعت")],
        ),
      ),
    );
  }

  _productWidget() => Column(
        children: [
          _productHeader(),
          SizedBox(
            height: 20,
          ),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "نام محصول",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "تی شرت Tealer",
                style: TextStyle(
                    color: IColors.themeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                textDirection: TextDirection.rtl,
              ),
            ],
          )
        ],
      );

  Widget _productHeader() {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
        "assets/tshirt.jpg",
        fit: BoxFit.cover,
      ),
    );
  }

  _actionsWidget(String prevLabel, String nextLabel) => Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: IColors.secondary,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (_currentStep == 0) {
                      setState(() {
                        _currentStep = 1;
                      });
                    } else {
                      _bloc.add(CreateService(
                          name: "تی شرت Tealer",
                          gotStock: _controller.text,
                          duration: _timeSelected,
                          conditions: [
                            Condition(
                                id: 1,
                                title: " پارگی یا خراش نداشته باشد",
                                description: " پارگی یا خراش نداشته باشد",
                                checked: true),
                            Condition(
                                id: 2,
                                title: "با تصویر منطبق باشد",
                                description: "با تصویر منطبق باشد",
                                checked: true),
                          ]));
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(nextLabel,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        SizedBox(width: 5),
                        Icon(Icons.navigate_next),
                      ],
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentStep = 0;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(prevLabel,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Icon(Icons.close),
                      ],
                    )),
                  ),
                ),
              ],
            )),
      );

  TextEditingController _controller = new TextEditingController();

  _serviceCostWidget() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 48.0),
                child: Text(
                  "مبلغ را به ریال وارد کنید",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.only(right: 12, left: 12),
              width: MediaQuery.of(context).size.width * 0.7,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromRGBO(237, 239, 243, 1),
                border: Border.all(
                    color: Color.fromRGBO(237, 239, 243, 1), width: 3),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: InputField(
                withUnderline: false,
                inputHint: "مبلغ",
                controller: _controller,
                textInputType: TextInputType.number,
              )),
        ],
      );

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
