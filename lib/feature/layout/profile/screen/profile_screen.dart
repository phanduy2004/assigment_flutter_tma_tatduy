import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/get_it/get_it.dart';
import '../../../../core/theme/app_color.dart';
import '../../../widget/custom_bottom_navigavation_bar.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  final String username;

  const ProfileScreen({super.key, required this.username});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 2;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(
      LoadProfileEvent(username: widget.username),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/cart');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hồ sơ'),
        backgroundColor: AppColors.starbucksGreen,
      ),
      body: BlocProvider(
        create: (context) => getIt<ProfileBloc>(),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state.status == ProfileStatus.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status == ProfileStatus.error) {
              return Center(
                child: Text(state.errorMessage ?? 'Lỗi khi tải hồ sơ'),
              );
            } else if (state.status == ProfileStatus.success &&
                state.userProfile != null) {
              _emailController.text = state.userProfile!['email'] ?? '';
              _fullNameController.text = state.userProfile!['fullName'] ?? '';
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Tên người dùng: ${state.userProfile!['username']}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Họ tên',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProfileBloc>().add(
                          UpdateProfileEvent(
                            username: widget.username,
                            email: _emailController.text,
                            fullName: _fullNameController.text,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Cập nhật hồ sơ thành công!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.starbucksGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Text('Cập nhật'),
                    ),
                  ],
                ),
              );
            }
            return Center(child: Text('Không có dữ liệu hồ sơ'));
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }
}
