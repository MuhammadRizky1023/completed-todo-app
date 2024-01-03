
import 'package:flutter/material.dart';
import 'package:todolist/Auth/login_auth.dart';
import 'package:todolist/utils/acount_services.dart';
import 'package:todolist/utils/auth_service.dart';
import 'package:todolist/widget/input_field.dart';
import 'package:todolist/widget/media_button.dart';
import 'package:todolist/widget/square_tile.dart';

class RegisterAuth extends StatefulWidget {
  final Function()? onTap;
  const RegisterAuth({super.key, this.onTap});

  @override
  State<RegisterAuth> createState() => _RegisterAuthState();
}

class _RegisterAuthState extends State<RegisterAuth> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

   void userSignUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (passwordController.text == confirmPasswordController.text) {
        // Gantilah dengan panggilan fungsi register yang sesuai dengan aplikasi Anda
        await AccountServices().signUpUser(emailController.text, passwordController.text);
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginAuth()),
        );
      
      } else {
        Navigator.pop(context);
        showErrorMesasge("Password don't match");
      }
    } on Exception catch (e) {
      Navigator.pop(context);
      showErrorMesasge(e.toString());
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
                  "Sign Up",
                  style: TextStyle(color: Colors.grey[700], fontSize: 35),
                ),
                const SizedBox(height: 25),
                Text(
                  "Let's create an acount for you!",
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
                       InputFIeld(
                        hintText: " Confirm Password",
                        obscureText: true,
                        controller: confirmPasswordController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                MediaButton(
                  text: 'Sign Up',
                  onTap: userSignUp,
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
                        'Sign in',
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
