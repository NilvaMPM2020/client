import 'package:asoude/screen/client/judge/JudgeItem.dart';
import 'package:flutter/material.dart';

class JudgePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: JudgeItem(),
      ),
    );
  }
}
