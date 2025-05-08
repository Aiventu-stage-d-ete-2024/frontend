import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../baseURL.dart';
import '../pages/home_page.dart';
import '../pages/signup_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void _signin() async {
    setState(() {
      isLoading = true;
    });

    var data = {
      'Email': emailController.text,
      'Password': passwordController.text,
    };

    var url = Uri.parse('${baseUrl}users/signin');
    var response = await http.post(
      url,
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Signed In Successfully !',
            style: TextStyle(color: Color(0xFF3665DB)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MyHomePage(title: "Finance & Operations")),
                  (Route<dynamic> route) => false,
                );
              },
              child:
                  const Text('OK', style: TextStyle(color: Color(0xFF3665DB))),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Error',
            style: TextStyle(color: Color(0xFF3665DB)),
          ),
          content: const Text(
            'Failed to sign in. Please try again later.',
            style: TextStyle(color: Color(0xFF3665DB)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:
                  const Text('OK', style: TextStyle(color: Color(0xFF3665DB))),
            ),
          ],
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /*Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                          'assets/images/aiventu.png',
                          height: 50,
                          width: 500,
                        ),
                    ),*/
                    Image.asset(
                      'assets/images/signin.jpg',
                      height: 350,
                      width: 350,
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextFormField(
                      labelText: 'Email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextFormField(
                      labelText: 'Password',
                      controller: passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _signin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF3665DB),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text('Sign in'),
                    ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupPage()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text(
                        "Don't have an account? Sign up now!",
                        style: TextStyle(
                          color: Color(0xFF3665DB),
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        floatingLabelStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF3665DB),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xFF3665DB), width: 2.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }
}
