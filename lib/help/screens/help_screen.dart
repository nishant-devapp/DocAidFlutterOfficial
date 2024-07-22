import 'package:code/utils/constants/colors.dart';
import 'package:code/utils/widgets/AppButton.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _feedbackMsgController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _sendFeedback() async{
    if (!_formKey.currentState!.validate()) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.02,
            horizontal: deviceWidth * 0.03,),
          child: Column(
            children: [
              RichText(
                text: const TextSpan(
                  text: 'Get in ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor, fontSize: 26.0),
                  children: <TextSpan>[
                    TextSpan(text: 'Touch', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.ultraViolet, fontSize: 26.0)),
                  ],
                ),
              ),
              SizedBox(height: deviceHeight * 0.03),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: deviceHeight * 0.02,
                    horizontal: deviceWidth * 0.03,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: deviceHeight * 0.001),
                          TextFormField(
                            controller: _firstNameController,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: 'First Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your fist name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: deviceHeight * 0.02),
                          TextFormField(
                            controller: _lastNameController,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: 'Last Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: deviceHeight * 0.02),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email_rounded),
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
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              prefixIcon: const Icon(Icons.phone),
                              labelText: 'Phone',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: deviceHeight * 0.02),
                          TextFormField(
                            controller: _feedbackMsgController,
                            keyboardType: TextInputType.text,
                            maxLines: 10,
                            decoration: const InputDecoration(
                              labelText: 'Feedback Message',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your feedback';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: deviceHeight * 0.02),
                          AppButton(buttonColor: AppColors.ultraViolet, buttonPressedColor: AppColors.jet, buttonText: "Send Message", onPressed: _sendFeedback),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: deviceHeight * 0.03),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.ultraViolet,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reshita Address: \nPatliputra Colony Patna, Bihar, Pin-800013',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Email: enquiry@doc-aid.in',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Call: 0612-4061095',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
