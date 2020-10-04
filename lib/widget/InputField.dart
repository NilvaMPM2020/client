// ignore: must_be_immutable

import 'package:asoude/constants/colors.dart';
import 'package:asoude/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InputField extends StatefulWidget {
  String inputHint;
  TextEditingController controller;
  TextInputType textInputType;
  Function(String) validationCallback;
  bool needToHideKeyboard;
  String errorMessage;
  bool obscureText;
  ValueChanged<String> onChanged;
  bool withUnderline;

  InputField(
      {this.inputHint,
      this.controller,
      this.textInputType,
      this.needToHideKeyboard = true,
      this.validationCallback,
      this.errorMessage,
      this.onChanged,
      this.obscureText = false,
      this.withUnderline = true});

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isValid = false;

  @override
  void initState() {
    setState(() {
      this.isValid = false;
    });
    super.initState();
    if(widget.controller != null) {
      widget.controller.addListener(() {
        setState(() {
          isValid = widget.validationCallback(widget.controller.text);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      controller: widget.controller,
      textAlign: TextAlign.right,
      keyboardType: widget.textInputType,
      validator: (value) {
        if (widget.validationCallback(value)) {
          return null;
        } else {
          return widget.errorMessage;
        }
      },
      onChanged: (text) {
        widget.onChanged(text);
        setState(() {
          isValid = widget.validationCallback(text);
        });
        if (isValid && widget.needToHideKeyboard) {
          hideKeyboard(context);
        }
      },
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: widget.withUnderline ? BorderSide(color: IColors.themeColor, width: 2) : BorderSide(color: Colors.transparent, width: 2),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: widget.withUnderline ? BorderSide(color: IColors.themeColor, width: 2) : BorderSide(color: Colors.transparent, width: 2),
          ),
          border: UnderlineInputBorder(
            borderSide: widget.withUnderline ? BorderSide(color: IColors.themeColor, width: 2) : BorderSide(color: Colors.transparent, width: 2),
          ),
          prefixIcon: Visibility(
              visible: isValid,
              child: Icon(
                Icons.check,
                color: IColors.themeColor,
              )),
          hintText: widget.inputHint,
          hintStyle: TextStyle(color: Colors.black, fontSize: 14.0),
          labelStyle: TextStyle(color: Colors.black)),
    );
  }
}
