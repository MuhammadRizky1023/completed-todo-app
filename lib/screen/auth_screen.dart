import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/Auth/login_or_register.dart';
import 'package:todolist/app/todo_app.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        builder: (context, snaoshot){
          if (snaoshot.hasData) {
            return const ProviderScope(child: TodoApp());
          } else {
            return const LoginOrRegister();
          }
        },
     ),
    );
  }
}