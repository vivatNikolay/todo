import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import '../models/auth_state.dart';

class DeviceAuthService {
  static final _auth = LocalAuthentication();

  static Future<bool> _isDeviceSupported() => _auth.isDeviceSupported();

  static Future<List> _listAvailableAuth() => _auth.getAvailableBiometrics();

  static Future<AuthState> authenticate() async {
    if (!await _isDeviceSupported()) {
      // return AuthState.unsupported_device;
      return AuthState.authorized;
    }
    if ((await _listAvailableAuth()).isEmpty) {
      return AuthState.no_pass;
    }
    try {
      final isSuccess = await _auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      return isSuccess ? AuthState.authorized : AuthState.not_authorized;
    } on PlatformException catch (e) {
      debugPrint(e.message);
      return AuthState.error;
    }
  }
}