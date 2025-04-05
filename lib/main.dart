import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'auth/login_page.dart';
import 'auth/register_page.dart';
import 'home/home_page.dart';
import 'morning_call/morning_call_request_page.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  int logoStep = 1;
  bool showButtons = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);

    _startSequence();
  }

  void _startSequence() async {
    for (int i = 2; i <= 9; i++) {
      _fadeController.reset();
      setState(() => logoStep = i);
      _fadeController.forward();
      await Future.delayed(const Duration(milliseconds: 300));
    }

    await Future.delayed(const Duration(milliseconds: 200));
    setState(() => showButtons = true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentLogo = 'assets/img/plash$logoStep.svg';
    String previousLogo = 'assets/img/plash${(logoStep - 1).clamp(1, 9)}.svg';

    return Scaffold(
      backgroundColor: showButtons ? const Color(0xFFF7F7F7) : const Color(0xFFFBC15B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: showButtons
              ? Column(
                  children: [
                    const SizedBox(height: 160),
                    const Text(
                      '서로서로 깨워주며\n우리가 함께 만드는 아침, 굿모닝!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 80),
                    SizedBox(
                      width: 180,
                      height: 180,
                      child: Stack(
                        children: [
                          SvgPicture.asset(previousLogo),
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: SvgPicture.asset(currentLogo),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Spacer(),
                    _buildButtons(context),
                  ],
                )
              : Center(
                  child: SizedBox(
                    width: 180,
                    height: 180,
                    child: Stack(
                      children: [
                        SvgPicture.asset(previousLogo),
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: SvgPicture.asset(currentLogo),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
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
    );
  }
}