import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'auth/login_page.dart';
import 'auth/register_page.dart';
import 'home/home_page.dart';
import 'morning_call/morning_call_request_page.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 비동기 작업 전에 필수!
  await initializeDateFormatting('ko_KR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/morning_call/request': (context) => const MorningCallRequestPage(),
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 160),
              const Text(
                '서로서로 깨워주며\n우리가 함께 만드는 아침, 굿모닝!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF333333), // 진한 회색
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 80),
              SvgPicture.asset(
                'assets/img/logo.svg',
                width: 180,
                height: 180,
              ),
              const SizedBox(height: 10),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFDF0AC),
                  foregroundColor: const Color(0xFFCA8916),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  elevation: 0,
                  ),
                  child: const Text(
                  '로그인',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC84E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    '회원가입',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}