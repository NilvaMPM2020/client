import 'package:asoude/model/AuthResponseEntity.dart';
import 'package:asoude/model/CreateServiceResponseEntity.dart';
import 'package:asoude/model/TradeResponseEntity.dart';
import 'package:asoude/networking/ApiProvider.dart';

class ServiceRepository {
  ApiProvider _provider = ApiProvider();

  Future<CreateServiceResponseEntity> createService(String name,
      String gotStock, int duration, List<Condition> conditions) async {
    final response = await _provider.post("account/services/", body: {
      "name": name,
      "got_stock": gotStock,
      "duration": duration,
      "conditions": conditions
    });
    return CreateServiceResponseEntity.fromJson(response);
  }

}
