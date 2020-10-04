import 'package:asoude/constants/assets.dart';
import 'package:asoude/constants/colors.dart';
import 'package:asoude/model/TradeResponseEntity.dart';
import 'package:asoude/utils/Utils.dart';
import 'package:asoude/widget/InputField.dart';
import 'package:asoude/widget/RaisedGradientButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

class CreateServicePage extends StatefulWidget {
  @override
  _CreateServicePage createState() => _CreateServicePage();
}

class _CreateServicePage extends State<CreateServicePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            _productWidget(),
            _timeWidget(),
            _descWidget(),
            _condition(Condition(title: " پارگی یا خراش نداشته باشد")),
            SizedBox(height: 20),
            _serviceCostWidget(),
            SizedBox(height: 50),
            _actionsWidget()
          ],
        ),
      ),
    );
  }

  Widget _condition(Condition condition) => Container(
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
          Assets.addDealIcon,
          width: 25,
          height: 25,
        )
      ],
    ),
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
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/tshirt.jpg",
              fit: BoxFit.fill,
            ),
          ),
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

  _actionsWidget() => Container(
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
          Container(
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
                Icon(Icons.navigate_next),
                Text("بعدی",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ],
            )),
          ),
          Container(
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
                Text("انصراف",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                Icon(Icons.close),
              ],
            )),
          ),
        ],
      ));

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
//            controller: _verificationController,
                textInputType: TextInputType.number,
//            validationCallback: (text) =>
//            _isVerificationCodeValid(text) || resendCodeEnabled,
//            errorMessage: "کدفعالسازی ۶رقمی است",
//            onChanged: (text) {
//              setState(() {
//                isContinueEnable = _isVerificationCodeValid(text);
//              });
              )),
        ],
      );
}
