import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/feature/layout/practice_design/travel_booking.dart';
import 'package:hello/core/get_it/get_it.dart';
import 'package:hello/feature/layout/cart/bloc/cart_bloc.dart';
import 'package:hello/feature/layout/cart/bloc/cart_event.dart';
import 'package:hello/feature/layout/home/bloc/product_bloc.dart';
import 'package:hello/feature/layout/home/bloc/product_event.dart';
import 'package:hello/feature/layout/cart/screen/cart_screen.dart';
import 'package:hello/feature/layout/home/screen/home_screen.dart';
import 'package:hello/feature/layout/Onboard.dart';
import 'package:hello/feature/layout/login/bloc/auth_bloc.dart';
import 'package:hello/feature/layout/login/screen/login_page.dart';
import 'package:hello/feature/layout/profile/screen/profile_screen.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Dùng sqflite mặc định cho iOS & Android
  final dbPath = await getDatabasesPath();
  print("Database path: $dbPath"); // để debug khi cần

  // Đăng ký các dependencies bằng GetIt
  setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthBloc>()),
        BlocProvider(create: (_) => getIt<ProductBloc>()..add(GetProductEvent())),
        BlocProvider(create: (_) => getIt<CartBloc>()..add(LoadCartEvent())),
      ],
      child: MaterialApp(
        title: 'Ứng Dụng Starbucks',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/onboard',
        onGenerateRoute: _generateRoute,
      ),
    );
  }

  Route<dynamic> _generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/onboard':
        return MaterialPageRoute(builder: (_) => Onboard());

      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case '/home':
        final username = (args is String) ? args : '';
        return MaterialPageRoute(builder: (_) => HomeScreen(username: username));

      case '/cart':
        final username = (args is String) ? args : '';
        return MaterialPageRoute(builder: (_) => CartScreen(username: username));

      case '/profile':
        final username = (args is String) ? args : '';
        return MaterialPageRoute(builder: (_) => ProfileScreen(username: username));

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Không tìm thấy trang')),
          ),
        );
    }
  }
}
