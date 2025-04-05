import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'call_page.dart';

class PreparingWakePage extends StatefulWidget {
  const PreparingWakePage({super.key});

  @override
  State<PreparingWakePage> createState() => _PreparingWakePageState();
}

class _PreparingWakePageState extends State<PreparingWakePage> {
  String _selectedDate = '2025.04.07 (월)'; // 기상 일정 날짜
  String _selectedTime = '08:00 am'; // 기상 일정 시간
  String _selectedNickname = '닉네임'; // 기상 대상 닉네임
  String _selectedProfileImage = 'assets/img/default_profile.png'; // 기상 대상 프로필 이미지
  bool _isCallButtonEnabled = true; // 모닝콜 걸기 버튼 활성화 여부
  bool isCallEnded = false; // 모닝콜 종료 여부

  // 하단바 생성용
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7), // 전체 배경색
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text(
                '따로 기상',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 40),
              Text(
                _isCallButtonEnabled
                ? '약속시간이 되었어요'
                : '깨워줄 준비가 되셨나요?',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 12),
              Text(
                _isCallButtonEnabled
                ? '모닝콜을 걸어 상대의 잠을 깨워주세요'
                : '시간이 되면 모닝콜을 걸어 깨워주세요',
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 30),
              SvgPicture.asset(
                _isCallButtonEnabled
                ? 'assets/img/graphic_ready_to_wake.svg'
                : 'assets/img/그래픽_일어날시간.svg',
                height: 250,
              ),
              const SizedBox(height: 30),

              // 📦 기상 일정 카드
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white, // ✅ 흰색 배경
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('기상 일정'),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 20, color: Colors.black87),
                        SizedBox(width: 10),
                        Text(_selectedDate),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.access_time_outlined, size: 20, color: Colors.black87),
                        SizedBox(width: 10),
                        Text(_selectedTime),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Text('기상 대상'),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(_selectedProfileImage),
                          radius: 12,
                        ),
                        SizedBox(width: 10),
                        Text(_selectedNickname),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // 📦 모닝콜 걸기 버튼
              if (!isCallEnded)
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: _isCallButtonEnabled
                    ? () {
                        setState(() => isCallEnded = true); // 모닝콜 종료 상태로 변경
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CallPage(),
                          ),
                        );
                      }
                    : null, // 버튼 비활성화
                    icon: const Icon(Icons.call),
                    label: const Text('모닝콜 걸기'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isCallButtonEnabled
                      ? const Color(0xFFFBC15B)
                      : Color(0xFFBDBDBD), // 회색
                      // disabledBackgroundColor: const Color(0xFFBDBDBD),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFFF7F7F7),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.alarm), label: '모닝콜'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: '모닝방'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFFFBC15B),
          onTap: (index) {
            setState(() => _selectedIndex = index);
            if(index==0){Navigator.pushNamed(context, '/home');}
          }
        ),
      ),
    );
  }
}
