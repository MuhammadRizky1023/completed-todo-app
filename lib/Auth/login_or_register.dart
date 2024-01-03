import 'package:flutter/material.dart';
import 'package:todolist/Auth/login_auth.dart';
import 'package:todolist/Auth/register_auth.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginAuth(
        onTap: togglePages,
      );
    } else {
      return RegisterAuth(
        onTap: togglePages,
      );
    }
  }
}
