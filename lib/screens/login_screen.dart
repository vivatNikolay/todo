import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth_state.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthState? authState;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                authState = await authProvider.tryDeviceAuth();
                setState(() {});
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Authenticate'),
                  Icon(Icons.login),
                ],
              ),
            ),
            Text(authState?.name ?? ''),
          ],
        ),
      ),
    );
  }
}
