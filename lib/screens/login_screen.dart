import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/tasks_provider.dart';

import '../models/auth_state.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passController = TextEditingController();
  AuthState? _authState;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    _authState = authProvider.authState;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: TextField(
                controller: _passController,
                obscureText: true,
                maxLength: 20,
                decoration: const InputDecoration(
                  counterText: '',
                ),
              ),
            ),
            SizedBox(height: 10),
            _authState != null
                ? ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            setState(() {
                              _isLoading = true;
                            });
                            if (_authState == AuthState.no_pass) {
                              _authState = await authProvider.createPass(_passController.text);
                            } else {
                              _authState = await authProvider.login(_passController.text);
                            }
                            setState(() {
                              _isLoading = false;
                            });
                          },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_authState == AuthState.no_pass ? 'Create password' : 'Authenticate'),
                        const Icon(Icons.login),
                      ],
                    ),
                  )
                : const CircularProgressIndicator(),
            Text(_authState?.name ?? ''),
          ],
        ),
      ),
    );
  }
}
