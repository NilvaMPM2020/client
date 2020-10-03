import 'dart:async';

import 'package:asoude/model/AuthResponseEntity.dart';
import 'package:asoude/networking/Response.dart';
import 'package:asoude/repository/AuthRepository.dart';
import 'package:asoude/screen/start/RoleType.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc {
  AuthRepository _repository;
  StreamController _loginController;
  StreamController _verifyController;

  StreamSink<Response<LoginResponseEntity>> get loginSink =>
      _loginController.sink;

  Stream<Response<LoginResponseEntity>> get loginStream =>
      _loginController.stream;

  StreamSink<Response<VerifyResponseEntity>> get verifySink =>
      _verifyController.sink;

  Stream<Response<VerifyResponseEntity>> get verifyStream =>
      _verifyController.stream;

  AuthBloc() {
    _loginController = StreamController<Response<LoginResponseEntity>>();
    _verifyController = StreamController<Response<VerifyResponseEntity>>();
    _repository = AuthRepository();
  }

  login(String phoneNumber) async {
    loginSink.add(Response.loading());
    try {
      LoginResponseEntity response = await _repository.login(phoneNumber);
      loginSink.add(Response.completed(response));
    } catch (e) {
      loginSink.add(Response.error(e));
      print(e);
    }
  }

  verify(String phoneNumber, RoleType type, int code) async {
    verifySink.add(Response.loading());
    try {
      VerifyResponseEntity response = await _repository.verify(phoneNumber, code, type.index);
      saveUserName(phoneNumber);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response.token);
      prefs.setBool('isUser', response.user.userType == 0);
      verifySink.add(Response.completed(response));
    } catch (e) {
      verifySink.add(Response.error(e));
      print(e);
    }
  }

  saveUserName(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', userName);
  }

  getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  dispose() {
    _loginController?.close();
    _verifyController?.close();
  }
}
