import 'package:flutter/material.dart';
import 'package:travelapp/features/common/widgets/outlined_cutom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Your image collage and other widgets here...

              const SizedBox(height: 32.0),

              // Login Button
              CustomOutlinedButton(
                label: 'Login',
                onPressed: () {
                  // Add login logic here
                },
                isOutlined: false,
                backgroundColor: Colors.blueAccent,
                textColor: Colors.white,
              ),
              const SizedBox(height: 12.0),

              // Register Button
              CustomOutlinedButton(
                label: 'Register',
                onPressed: () {
                  // Add register logic here
                },
                isOutlined: true,
                textColor: Colors.blueAccent,
                borderColor: Colors.blueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
