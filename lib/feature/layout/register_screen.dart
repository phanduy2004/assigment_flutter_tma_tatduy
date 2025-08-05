import 'package:flutter/material.dart';

import '../../core/theme/app_color.dart';
import '../widget/custom_text_field.dart';
import '../widget/customs_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: AppColors.starbucksGreen,
          ),
        ),
        backgroundColor: AppColors.onSurface,
      ),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Register Account", style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF006241), // Màu xanh Starbucks
                  ),
                    textAlign: TextAlign.center,),
                  SizedBox(height: 20,),
                  CustomTextField(
                    labelText: "FullName",
                    keyboardType: TextInputType.name, // Bàn phím cho email
                  ),
                  SizedBox(height: 20,),
                  CustomTextField(
                    labelText: "Email",
                    keyboardType: TextInputType.emailAddress, // Bàn phím cho email
                  ),
                  SizedBox(height: 12),
                  CustomTextField(
                    labelText: "Username",
                    keyboardType: TextInputType.name, // Bàn phím cho email
                  ),
                  SizedBox(height: 12),
                  CustomTextField(
                    labelText: "Password",
                    keyboardType: TextInputType.visiblePassword, // Bàn phím cho email
                  ),
                  SizedBox(height: 12),
                  CustomTextField(
                    labelText: "Confirm Password",
                    keyboardType: TextInputType.visiblePassword, // Bàn phím cho email
                  ),

                  SizedBox(height: 20),
                  CustomButton(text: "Sign Up", onPressed: (){}),
                  SizedBox(height: 20),
                  Text("Log in with your Google or Facebook account", style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w300,
                  )),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          // Thêm hành động khi nhấn vào logo Google (ví dụ: đăng nhập Google)
                          print("Google button tapped!");
                        },
                        child: Image.asset('images/google.png'),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          // Thêm hành động khi nhấn vào logo Google (ví dụ: đăng nhập Google)
                          print("Apple button tapped!");
                        },
                        child: Image.asset('images/apple.png'),
                      ),
                      SizedBox(width: 20),// Khoảng cách giữa logo
                      InkWell(
                        onTap: () {
                          // Thêm hành động khi nhấn vào logo Facebook (ví dụ: đăng nhập Facebook)
                          print("Facebook button tapped!");
                        },
                        child: Image.asset('images/facebook.png'),
                      ),
                    ],
                  ),
                ],
              ),
          )),
    );
  }
}
