import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/Auth/forgot_password_auth.dart';
import 'package:todolist/app/todo_app.dart';
import 'package:todolist/screen/home_screen.dart';
import 'package:todolist/utils/acount_services.dart';
import 'package:todolist/utils/auth_service.dart';
import 'package:todolist/widget/input_field.dart';
import 'package:todolist/widget/media_button.dart';
import 'package:todolist/widget/square_tile.dart';

class LoginAuth extends StatefulWidget {
  final Function()? onTap;
  const LoginAuth({super.key, this.onTap});

  @override
  State<LoginAuth> createState() => _LoginAuthState();
}

class _LoginAuthState extends State<LoginAuth> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void userSignIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await AccountServices()
          .loginUserWithLink(emailController.text, passwordController.text);
      Navigator.pop(context);
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProviderScope(child: TodoApp())),
        );
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      showErrorMesasge(e.code);
    }
  }

  void showErrorMesasge(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "Sign In",
                  style: TextStyle(color: Colors.grey[700], fontSize: 35),
                ),
                const SizedBox(height: 25),
                Text(
                  'Welcome back, you\'ve been missed!',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      InputFIeld(
                        hintText: "email",
                        obscureText: false,
                        controller: emailController,
                      ),
                      const SizedBox(height: 10),
                      InputFIeld(
                        hintText: "Password",
                        obscureText: true,
                        controller: passwordController,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassword()));
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                MediaButton(
                  text: 'Sign In',
                  onTap: userSignIn,
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Or continue with",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      onTap: () => AuthService().userSignInGoogle(),
                      imagePath: 'asset/img/google.png',
                    ),
                    const SizedBox(width: 25),
                    SquareTile(
                      onTap: () => AuthService().userSignInFacebook(),
                      imagePath: 'asset/img/facebook.png',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
