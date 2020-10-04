import 'package:asoude/model/CreateServiceResponseEntity.dart';
import 'package:asoude/model/TradeResponseEntity.dart';
import 'package:asoude/repository/ServiceRepository.dart';
import 'package:asoude/repository/TradeRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceRepository _repository = ServiceRepository();

  @override
  get initialState => CreateServiceLoading();

  Stream<ServiceState> _getList(String name, String gotStock, int duration, List<Condition> conditions) async* {
    yield CreateServiceLoading();
    try {
      final CreateServiceResponseEntity result = await _repository.createService(name, gotStock, duration, conditions);
      yield CreateServiceLoaded(result: result);
    } catch (e) {
      yield CreateServiceError();
    }
  }

  @override
  Stream<ServiceState> mapEventToState(event) async* {
    if (event is CreateService) {
      yield* _getList(event.name, event.gotStock, event.duration, event.conditions);
    }
  }
}

// events
abstract class ServiceEvent {}

class CreateService extends ServiceEvent {
  final String name;
  final String gotStock;
  final int duration;
  final List<Condition> conditions;

  CreateService({this.name, this.gotStock, this.duration, this.conditions});
}

// states
class ServiceState {
  CreateServiceResponseEntity result;

  ServiceState({this.result});
}

class CreateServiceError extends ServiceState {}

class CreateServiceLoaded extends ServiceState {
  CreateServiceLoaded({result}) : super(result: result);
}

class CreateServiceLoading extends ServiceState {}
