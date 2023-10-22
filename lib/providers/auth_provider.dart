import 'package:flutter/material.dart';

import '../models/auth_state.dart';
import '../services/local_auth_service.dart';
import '../services/crypto_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthState _authState = AuthState.not_authorized;

  AuthState get authState => _authState;

  AuthProvider() {
    initAuthState();
  }

  Future<AuthState> login(String pass) async {
    final encryptPass = CryptoService.encrypt(pass);
    _authState = await LocalAuthService.authenticate(encryptPass) ? AuthState.authorized : AuthState.not_authorized;
    notifyListeners();
    return _authState;
  }

  AuthState logout() {
    _authState = AuthState.not_authorized;
    notifyListeners();
    return _authState;
  }

  Future<AuthState> createPass(String pass) async {
    final encryptPass = CryptoService.encrypt(pass);
    _authState = await LocalAuthService.createPass(encryptPass) ? AuthState.authorized : AuthState.no_pass;
    notifyListeners();
    return _authState;
  }

  Future<AuthState> _isHasPass() async {
    _authState = await LocalAuthService.isHasPass() ? AuthState.not_authorized : AuthState.no_pass;
    notifyListeners();
    return _authState;
  }

  Future<void> initAuthState() async {
    _authState = await _isHasPass();
    notifyListeners();
  }
}
