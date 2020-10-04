import 'package:asoude/model/AuthResponseEntity.dart';
import 'package:asoude/model/User.dart';
import 'package:asoude/networking/ApiProvider.dart';

class ProfileRepository {
  ApiProvider _provider = ApiProvider();

  Future<User> getProfile({id}) async {
    final response = await _provider.get("account/profile/${id == null? '': id}");
    return User.fromJson(response);
  }
}
