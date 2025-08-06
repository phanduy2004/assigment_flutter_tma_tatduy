import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/feature/layout/login/bloc/auth_bloc.dart';

import '../../core/theme/app_color.dart';
import '../widget/custom_text_field.dart';
import '../widget/customs_button.dart';
import 'login/bloc/auth_event.dart';
import 'login/bloc/auth_state.dart';

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
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Đăng ký thành công!')),
            );
            Navigator.pop(context); // Quay lại login chẳng hạn
          } else if (state.status == AuthStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Đăng ký thất bại')),
            );
          }
        },
        builder: (context,state) {
          return SafeArea(
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
                        controller: _fullNameController,
                      ),
                      SizedBox(height: 20,),
                      CustomTextField(
                        labelText: "Email",
                        keyboardType: TextInputType.emailAddress, // Bàn phím cho email
                        controller: _emailController,
                      ),
                      SizedBox(height: 12),
                      CustomTextField(
                        labelText: "Username",
                        keyboardType: TextInputType.name, // Bàn phím cho email
                        controller:_usernameController,
                      ),
                      SizedBox(height: 12),
                      CustomTextField(
                        labelText: "Password",
                        keyboardType: TextInputType.visiblePassword, // Bàn phím cho email
                        controller: _passwordController,
                      ),
                      SizedBox(height: 12),
                      CustomTextField(
                        labelText: "Confirm Password",
                        keyboardType: TextInputType.visiblePassword, // Bàn phím cho email
                        controller: _confirmPasswordController,
                      ),

                      SizedBox(height: 20),
                      CustomButton(text: "Sign Up", onPressed: (){
                        context.read<AuthBloc>().add(
                          RegisterUserEvent(
                            username: _usernameController.text.trim(),
                            fullname: _fullNameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            confirmPassword: _confirmPasswordController.text.trim(),
                          ),
                        );
                      }),
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
              ));
        }
      ),
    );
  }
}
