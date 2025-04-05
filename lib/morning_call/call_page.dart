import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  String _profileImage = 'assets/img/default_profile.png'; // 기상 대상 프로필 이미지
  String _nickname = '닉네임'; // 기상 대상 닉네임

  int remainingTime = 30; // 남은 시간 (초 단위)
  bool isWakeSuccess = true; // 기상 성공 여부
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown(); // 타이머 시작
  }

  @override
  void dispose() {
    _timer?.cancel(); // 타이머 종료
    super.dispose();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel(); // 타이머 중지
        setState(() {
          isWakeSuccess = false; // 성공 여부를 실패로 설정
        });
        Navigator.pop(context); // 방 종료 후 모닝룸으로 이동
        _showWakeResultDialog(context); // 결과 다이얼로그 표시
      }
    });
  }

  void _showWakeResultDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(isWakeSuccess?'깨우기 성공':'깨우기 실패', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                isWakeSuccess
                ? '성공적으로 깨우셨군요!\n성공 보상으로 10P을 획득했어요'
                : '상대를 깨우는 데 실패했어요\n아쉽지만 다음 기회를 노려보세요',
                textAlign: TextAlign.center,
              ),
              const SizedBox(width: 300),
              SvgPicture.asset(
                isWakeSuccess
                ? 'assets/img/그래픽_모달_성공햇님.svg'
                : 'assets/img/그래픽_모달_실패달님.svg',
                height: 175,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB74D),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                  child: Text('확인'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3B0),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 세로 방향 중앙 정렬
            crossAxisAlignment: CrossAxisAlignment.center, // 가로 방향 중앙 정렬
            children: [
              const Text(
                '잠에서 깨워줄 시간',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center, // 텍스트 중앙 정렬
              ),
              const SizedBox(height: 12),
              const Text(
                '상대에게 전화를 걸었어요!\n30초 이내에 전화를 받으면 성공이에요',
                textAlign: TextAlign.center, // 텍스트 중앙 정렬
              ),
              const SizedBox(height: 100),
              Container (
                child: CircleAvatar(
                  backgroundImage: AssetImage(_profileImage),
                  radius: 75,
                ),
                alignment: Alignment.center, // 가로 방향 중앙 정렬
              ),
              const SizedBox(height: 20),
              Text(_nickname, textAlign: TextAlign.center),
              const SizedBox(height: 60),
              Text(
                '현재 남은 시간',
                textAlign: TextAlign.center, // 텍스트 중앙 정렬
              ),
              Text(
                '$remainingTime초',
                textAlign: TextAlign.center, // 텍스트 중앙 정렬
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.call_end, size: 36, color: Colors.white),
                  onPressed: () {
                    _timer?.cancel(); // 타이머 종료
                    Navigator.pop(context); // 방 종료 후 모닝룸으로 이동
                    _showWakeResultDialog(context); // 팝업도 띄움
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}