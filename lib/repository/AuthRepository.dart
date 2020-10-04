
import 'package:asoude/model/AuthResponseEntity.dart';
import 'package:asoude/networking/ApiProvider.dart';

class AuthRepository {
  ApiProvider _provider = ApiProvider();

  Future<LoginResponseEntity> login(String phoneNumber) async {
    final response = await _provider.get("account/login/$phoneNumber");
    return LoginResponseEntity.fromJson(response);
  }

  Future<VerifyResponseEntity> verify(String phoneNumber, int code, int type) async {
    final response = await _provider.post("account/verify/$phoneNumber", body: {"code": code, "type": type}, withToken: false);
    return VerifyResponseEntity.fromJson(response);
  }

}
