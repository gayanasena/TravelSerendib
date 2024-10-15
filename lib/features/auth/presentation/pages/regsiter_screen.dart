import 'package:flutter/material.dart';
import 'package:travelapp/core/resources/colors.dart';
import 'package:travelapp/core/resources/text_styles.dart';
import 'package:travelapp/features/common/widgets/outlined_custom_button.dart';
import 'package:travelapp/features/common/widgets/outlined_text_box.dart';
import 'package:travelapp/utils/assets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets(context).loginBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: ApplicationColors(context).whiteBackgroundTransparent,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Travel Serendib',
                        style: TextStyles(context).loginPageHeaderText,
                      ),
                      Text(
                        'Create a new account',
                        style: TextStyles(context).loginDescriptionText,
                      ),
                      const SizedBox(height: 20),
                      const OutlinedTextBox(labelText: "First Name"),
                      const SizedBox(height: 10),
                      const OutlinedTextBox(labelText: "Last Name"),
                      const SizedBox(height: 10),
                      const OutlinedTextBox(labelText: "Your Country"),
                      const SizedBox(height: 10),
                      const OutlinedTextBox(labelText: "Email"),
                      const SizedBox(height: 10),
                      const OutlinedTextBox(
                        labelText: "Password",
                        isPassword: true,
                      ),
                      const SizedBox(height: 20),
                      CustomOutlinedButton(
                        label: 'Sign Up',
                        onPressed: () {
                          onSignUpClick();
                        },
                        isOutlined: false,
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Already have an account? Sign In'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onSignUpClick() {
    // Handle sign up functionality here
  }
}
