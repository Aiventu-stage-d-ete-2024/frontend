import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../baseURL.dart';
import '../pages/signin_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  void _signup() async {
    setState(() {
      isLoading = true;
    });

    if (passwordController.text != confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Passwords do not match',
            style: TextStyle(color: Color(0xFF3665DB)),
          ),
          content: const Text(
            'Please re-enter your passwords.',
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
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      var data = {
        'Username': usernameController.text,
        'Email': emailController.text,
        'Password': passwordController.text,
      };

      var url = Uri.parse('${baseUrl}users/signup');
      var response = await http.post(
        url,
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 201) {
        var jsonResponse = json.decode(response.body);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              'Signed Up Successfully !',
              style: TextStyle(color: Color(0xFF3665DB)),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const SigninPage()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text('OK',
                    style: TextStyle(color: Color(0xFF3665DB))),
              ),
            ],
          ),
        );
      } else {
        var errorResponse = json.decode(response.body);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              'Error',
              style: TextStyle(color: Color(0xFF3665DB)),
            ),
            content: Text(
              errorResponse['message'],
              style: const TextStyle(color: Color(0xFF3665DB)),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK',
                    style: TextStyle(color: Color(0xFF3665DB))),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Error',
            style: TextStyle(color: Color(0xFF3665DB)),
          ),
          content: const Text(
            'Failed to sign up. Please try again later.',
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3665DB)),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SigninPage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/signup.jpg',
                      height: 300,
                      width: 300,
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextFormField(
                      labelText: 'Username',
                      controller: usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextFormField(
                      labelText: 'Email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextFormField(
                      labelText: 'Password',
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextFormField(
                      labelText: 'Confirm Password',
                      controller: confirmPasswordController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _signup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF3665DB),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text('Sign up'),
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
  final FormFieldValidator<String>? validator;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
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
