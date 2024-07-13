import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _isObscured = true;

  void _toggleObscureText() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Image(
              image: AssetImage(
                'assets/icons/doc_aid.png',
              ),
              height: 250,
              width: double.infinity,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 50.0),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(237, 231, 242, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(12))),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      obscureText: _isObscured,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(12))),
                        suffixIcon: IconButton(
                            onPressed: _toggleObscureText,
                            icon: Icon(_isObscured
                                ? Icons.visibility
                                : Icons.visibility_off)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Text("Forget Password",
                    // style: TextStyle(
                    //
                    // ),),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const DashboardScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor:
                          const Color.fromRGBO(7, 160, 165, 1)),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
