import 'package:asoude/model/JudgeResponseEntity.dart';
import 'package:asoude/repository/JudgeRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

class JudgeBloc extends Bloc<JudgeEvent, JudgeState> {
  JudgeRepository _repository = JudgeRepository();

  @override
  get initialState => JudgeGetLoading();

  Stream<JudgeState> _getJudge() async* {
    yield JudgeGetLoading();
    try {
      final JudgeResponseEntity result = await _repository.getJudge();
      yield JudgeGetLoaded(judge: result);
    } catch (e) {
      yield JudgeGetError();
    }
  }

  Stream<JudgeState> _makeJudgement(JudgeMake event) async* {
    yield JudgeGetLoading();
    try {
      final JudgeResponseEntity result = await _repository.makeJudgement(
          judgeId: event.judgeId, decision: event.decision);
      yield JudgeGetLoaded(judge: result);
    } catch (e) {
      yield JudgeGetError();
    }
  }

  @override
  Stream<JudgeState> mapEventToState(event) async* {
    if (event is JudgeGet) {
      yield* _getJudge();
    } else if (event is JudgeMake) yield* _makeJudgement(event);
  }
}

// events
abstract class JudgeEvent {}

class JudgeGet extends JudgeEvent {
  JudgeGet();
}

class JudgeMake extends JudgeEvent {
  final int decision;
  final int judgeId;

  JudgeMake({this.decision, this.judgeId});
}

// states
class JudgeState {
  JudgeResponseEntity judge;

  JudgeState({this.judge});
}

class JudgeGetError extends JudgeState {}

class JudgeGetLoaded extends JudgeState {
  JudgeGetLoaded({judge}) : super(judge: judge);
}

class JudgeGetLoading extends JudgeState {}
