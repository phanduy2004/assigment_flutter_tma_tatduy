import 'package:flutter/material.dart';

import '../widget/customs_button.dart';
import 'login/screen/login_page.dart';

class Onboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Image.asset('assets/images/starbucks.png')),
              SizedBox(height: 10),
              Text(
                "STARBUCKS",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF006241), // Màu xanh của Starbucks
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 7),
              Text(
                "One person, one cup, one neighborhood",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Spacer(),
              CustomButton(
                text: "Get Started",
                onPressed: () {
                  // Điều hướng đến màn hình đăng nhập
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}