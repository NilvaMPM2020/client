
import 'package:asoude/model/AuthResponseEntity.dart';
import 'package:asoude/model/TradeResponseEntity.dart';
import 'package:asoude/networking/ApiProvider.dart';

class TradeRepository {
  ApiProvider _provider = ApiProvider();

  Future<List<TradeResponseEntity>> getTradeList() async {
    final response = await _provider.get("trade/trades");
    return _tradesList(response);
  }

  List<TradeResponseEntity> _tradesList(List<dynamic> list) {
    List<TradeResponseEntity> entities = [];
    list.forEach((element) {
      entities.add(TradeResponseEntity.fromJson(element));
    });
    return entities;
  }


}
