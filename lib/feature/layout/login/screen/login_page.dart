import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hello/feature/layout/register_screen.dart';
import 'package:hello/feature/layout/home/screen/home_screen.dart';
import 'package:hello/feature/widget/customs_button.dart';
import 'package:hello/core/theme/app_color.dart';

import '../bloc/auth_state.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberPassword = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Đăng Nhập",
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
          padding: const EdgeInsets.all(20),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.success) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomeScreen(username: state.username ?? ''),
                  ),
                );
              } else if (state.status == AuthStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? 'Đăng nhập thất bại'),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chào Mừng Bạn Trở Lại",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.starbucksGreen,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    constraints: const BoxConstraints(maxHeight: 40),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: const TextStyle(
                          fontSize: 14,
                          color: AppColors.starbucksGreen,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: AppColors.starbucksGreen,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: AppColors.starbucksGreen,
                            width: 2,
                          ),
                        ),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    constraints: const BoxConstraints(maxHeight: 40),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: "Mật Khẩu",
                        labelStyle: const TextStyle(
                          fontSize: 14,
                          color: AppColors.starbucksGreen,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: AppColors.starbucksGreen,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: AppColors.starbucksGreen,
                            width: 2,
                          ),
                        ),
                      ),
                      obscureText: true,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: rememberPassword,
                        onChanged: (newValue) {
                          if (newValue != null) {
                            setState(() {
                              rememberPassword = newValue;
                            });
                          }
                        },
                      ),
                      Text(
                        "Ghi Nhớ Mật Khẩu",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.starbucksGreen,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          print("Quên mật khẩu được nhấn!");
                        },
                        child: Text(
                          "Quên mật khẩu",
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  state.status == AuthStatus.loading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          text: "Đăng Nhập",
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              LoginEvent(
                                username: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                          },
                        ),
                  const SizedBox(height: 20),
                  Text(
                    "Đăng nhập bằng tài khoản Google hoặc Facebook",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Image.asset(
                          'assets/images/google.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          print("Nút Apple được nhấn!");
                        },
                        child: Image.asset(
                          'assets/images/apple.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          print("Nút Facebook được nhấn!");
                        },
                        child: Image.asset(
                          'assets/images/facebook.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Chưa có tài khoản? Đăng ký tại đây!",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
