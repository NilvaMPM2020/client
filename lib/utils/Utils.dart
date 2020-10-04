import 'dart:typed_data';
import 'package:asoude/constants/colors.dart';
import 'package:asoude/widget/ActionButton.dart';
import 'package:asoude/widget/Waiting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

enum WeekDay { SATURDAY, SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY }

extension WeekDaysExtension on WeekDay {
  String get name {
    switch (this) {
      case WeekDay.SATURDAY:
        return "شنبه";
      case WeekDay.SUNDAY:
        return "یکشنبه";
      case WeekDay.MONDAY:
        return "دوشنبه";
      case WeekDay.TUESDAY:
        return "سه شنبه";
      case WeekDay.WEDNESDAY:
        return "چهارشنبه";
      case WeekDay.THURSDAY:
        return "پنجشنبه";
      case WeekDay.FRIDAY:
        return "جمعه";
    }
  }
}
String replaceFarsiNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], farsi[i]);
  }

  return input;
}

DateTime getDateAndTimeFromWS(String str) {
  String date = str.split("T")[0];
  String time = str.split("T")[1];
  final timeArray = time.split(":");
  return DateTime(
      int.parse(date.split("-")[0]),
      int.parse(date.split("-")[1]),
      int.parse(date.split("-")[2]),
      int.parse(timeArray[0]),
      int.parse(timeArray[1]),
      int.parse(timeArray[2]));
}


bool validatePhoneNumber(String value) {
  Pattern pattern = r'^(\+98|0)?9\d{9}$';
  RegExp regex = new RegExp(pattern);
  return regex.hasMatch(value);
}

String normalizeCredit(String credit) {
  if (credit.contains(".")) {
    return credit.split(".")[0];
  } else
    return credit;
}

void hideKeyboard(context) => FocusScope.of(context).unfocus();


void showOneButtonDialog(
    context, String message, String action, Function callback,
    {Color color}) {
  BuildContext dialogContext;
  AlertDialog dialog = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    title: Text(
      message,
      style: TextStyle(fontSize: 14),
      textAlign: TextAlign.center,
    ),
    content: ActionButton(
      color: color == null ? IColors.themeColor : color,
      title: action,
      callBack: () {
        Navigator.pop(dialogContext);
        callback();
      },
    ),
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        dialogContext = context;
        return dialog;
      });
}

void showListDialog(
    context, List<String> items, String action, Function callback) {
  BuildContext dialogContext;

  AlertDialog dialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                      title: Text(items[index], textAlign: TextAlign.center),
                      onTap: () {
                        Navigator.pop(dialogContext);
                        callback(index);
                      },
                    )),
          ],
        ),
      ));
  showDialog(
      context: context,
      builder: (BuildContext context) {
        dialogContext = context;
        return dialog;
      });
}

void showUnsupportedSessionDialog(context, Function callback) {
  showOneButtonDialog(
      context, "ویزیت مجازی در حال حاضر وجود ندارد", "رزرو ویزیت", callback);
}

void showMessageEmptyDialog(context, Function callback) {
  showOneButtonDialog(context, "پیام خالی ارسال نمی‌شود", "باشه", () {});
}

void showPicUploadedDialog(context, text, Function callback) {
  showOneButtonDialog(context, text, "باشه", callback);
}

void showAlertDialog(context, String text, Function callback) {
  showOneButtonDialog(context, text, "باشه", callback);
}

void showNextVersionDialog(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "منتظر ما باشید",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: Text("این امکان در نسخه‌های بعدی اضافه خواهد شد",
              textAlign: TextAlign.right, style: TextStyle(fontSize: 12)),
        );
      });
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
      .buffer
      .asUint8List();
}

void toast(context, String message) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: Duration(seconds: 3),
  ));
}

AlertDialog getLoadingDialog() => AlertDialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    content: Waiting());
