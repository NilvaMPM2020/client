import 'package:asoude/model/TradeResponseEntity.dart';
import 'package:asoude/repository/TradeRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

class TradeBloc extends Bloc<TradeEvent, TradeState> {
  TradeRepository _repository = TradeRepository();

  @override
  get initialState => GetTradeListLoading();

  Stream<TradeState> _getList() async* {
    yield GetTradeListLoading();
    try {
      final List<TradeResponseEntity> result = await _repository.getTradeList();
      yield GetTradesListLoaded(result: result);
    } catch (e) {
      yield GetTradeListError();
    }
  }

  @override
  Stream<TradeState> mapEventToState(event) async* {
    if (event is GetTradeList) {
      yield* _getList();
    }
  }
}

// events
abstract class TradeEvent {}

class GetTradeList extends TradeEvent {
  GetTradeList();
}

// states
class TradeState {
  List<TradeResponseEntity> result;

  TradeState({this.result});
}

class GetTradeListError extends TradeState {}

class GetTradesListLoaded extends TradeState {
  GetTradesListLoaded({result}) : super(result: result);
}

class GetTradeListLoading extends TradeState {}
