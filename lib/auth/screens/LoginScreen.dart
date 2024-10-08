// login_screen.dart

import 'package:code/auth/controllers/login_controller.dart';
import 'package:code/auth/screens/ForgetPasswordScreen.dart';
import 'package:code/home/screens/home_screen.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginController _loginController = LoginController();
  late String token;
  bool _isObscured = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void _toggleObscureText() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final loginResponse = await _loginController.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (loginResponse != null && loginResponse.statusCode == 200) {
      token = loginResponse.jwt;
      await _loginController.storeToken(token);


      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: deviceHeight
          ),
          child: IntrinsicHeight(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: deviceHeight * 0.05,
                      horizontal: deviceWidth * 0.05,
                    ),
                    child:
                    // Image.network(HttpImages.docAidTrademark, height: deviceHeight * 0.25, width: double.infinity,),
                    Image(
                      image: const AssetImage('assets/icons/doc_aid.png'),
                      height: deviceHeight * 0.25,
                      width: double.infinity,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColors.loginGrey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 12.0,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: deviceHeight * 0.02),
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: deviceHeight * 0.02),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _isObscured,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: _toggleObscureText,
                                    icon: Icon(
                                      _isObscured
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: deviceHeight * 0.01),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()),
                                    );
                                  },
                                  child: const Text(
                                    'Forgot Password',
                                    style: TextStyle(color: AppColors.vermilion),
                                  ),
                                ),
                              ),
                              SizedBox(height: deviceHeight * 0.02),
                              ElevatedButton.icon(
                                onPressed: _isLoading ? null : _login,
                                icon: const Icon(Icons.person_add_outlined,
                                    color: Colors.white),
                                label:  _isLoading
                                    ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2.0,)
                                    : const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 6.0,
                                  backgroundColor: AppColors.verdigris,
                                  minimumSize: Size(double.infinity, deviceHeight * 0.06),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 8.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
