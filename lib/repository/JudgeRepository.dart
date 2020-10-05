import 'package:asoude/model/JudgeResponseEntity.dart';
import 'package:asoude/networking/ApiProvider.dart';

class JudgeRepository {
  ApiProvider _provider = ApiProvider();

  Future<JudgeResponseEntity> getJudge() async {
    final response = await _provider.get("trade/judge", utf8Support: true);
    return JudgeResponseEntity.fromJson(response);
  }

  Future<JudgeResponseEntity> makeJudgement({judgeId, decision}) async {
    final response = await _provider.post("trade/judge/${judgeId}",
        body: {"decision": decision}, utf8Support: true);
    return JudgeResponseEntity.fromJson(response);
  }
}
