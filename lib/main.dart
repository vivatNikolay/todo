import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/tasks_provider.dart';

import 'models/auth_state.dart';
import 'providers/auth_provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: AuthProvider(),
          ),
          ChangeNotifierProvider.value(
            value: TasksProvider(),
          ),
        ],
        builder: (context, _) {
          final authState = Provider.of<AuthProvider>(context).authState;
          return MaterialApp(
            title: 'ToDo',
            home: authState == AuthState.authorized ? const HomeScreen() : const LoginScreen(),
          );
        },
      );
}