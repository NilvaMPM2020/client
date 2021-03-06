import 'package:asoude/bloc/timer/TimerBloc.dart';
import 'package:asoude/constants/colors.dart';
import 'package:asoude/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Timer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final TimerBloc _timerBloc = BlocProvider.of<TimerBloc>(context);
    return BlocBuilder(
      bloc: _timerBloc,
      builder: (context, state) {
        final String minutesStr =
            ((state.duration / 60) % 60).floor().toString().padLeft(2, '0');
        final String secondsStr =
            (state.duration % 60).floor().toString().padLeft(2, '0');
        return Text(
          replaceFarsiNumber(' $minutesStr:$secondsStr '),
          style: TextStyle(
            fontSize: 14,
            color: IColors.themeColor,
            fontFamily: 'iransans',
          ),
        );
      },
    );
  }

}
