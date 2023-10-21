import 'package:flutter/material.dart';

import '../models/auth_state.dart';
import '../services/device_auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthState _authState = AuthState.not_authorized;

  AuthState get authState => _authState;

  Future<AuthState> tryDeviceAuth() async {
    _authState = await DeviceAuthService.authenticate();
    notifyListeners();
    return _authState;
  }

/*  Future<void> createPass() async {

    notifyListeners();
  }*/
}
