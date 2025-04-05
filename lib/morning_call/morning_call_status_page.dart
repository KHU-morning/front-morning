import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

enum WakeupStatus { finding, matched }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MorningCallStatusPage(status: WakeupStatus.finding), // ← 여기 상태 바꾸면 됨!
    );
  }
}

class MorningCallStatusPage extends StatelessWidget {
  final WakeupStatus status;

  const MorningCallStatusPage({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      WakeupStatus.finding => const _FindingView(),
      WakeupStatus.matched => const _MatchedView(),
    };
  }
}

// ------------------------------
// 찾는 중 화면
// ------------------------------
class _FindingView extends StatelessWidget {
  const _FindingView({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final wakeupTime = DateTime(now.year, now.month, now.day, 8, 30);
    final remaining = wakeupTime.difference(now);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text('따로 기상', style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 8),
              const Text(
                '깨워줄 사람을 찾고 있어요',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text('깨워줄 사람을 찾고 있어요', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 40),
              Center(
                child: Image.asset(
                  'img/finding.png', // 여기에 이미지 경로 설정
                  width: 160,
                  height: 160,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('기상 일정', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16, color: Colors.orange),
                        const SizedBox(width: 6),
                        Text(
                          DateFormat('yyyy.MM.dd(E)', 'ko_KR').format(now),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 16, color: Colors.orange),
                        const SizedBox(width: 6),
                        const Text('am 08:30', style: TextStyle(fontSize: 14)),
                        const SizedBox(width: 6),
                        Text(
                          '${remaining.inSeconds}초 후',
                          style: const TextStyle(color: Colors.orange, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('기상 도우미', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('아직 수락한 이용자가 없어요', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _BottomBar(currentIndex: 0),
    );
  }
}

// ------------------------------
// 매칭 완료 화면
// ------------------------------
class _MatchedView extends StatelessWidget {
  const _MatchedView({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final wakeupTime = DateTime(now.year, now.month, now.day, 8, 30);
    final remaining = wakeupTime.difference(now);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text('따로 기상', style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 8),
              const Text(
                '기상 도우미가 정해졌어요!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text('시간이 되면 도우미가 전화할 거예요.', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 40),
              Center(
                child: Image.asset(
                  'assets/img/matched.png', // 매칭된 상태의 일러스트
                  width: 160,
                  height: 160,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('기상 일정', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16, color: Colors.orange),
                        const SizedBox(width: 6),
                        Text(
                          DateFormat('yyyy.MM.dd(E)', 'ko_KR').format(now),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 16, color: Colors.orange),
                        const SizedBox(width: 6),
                        const Text('am 08:30', style: TextStyle(fontSize: 14)),
                        const SizedBox(width: 6),
                        Text(
                          '${remaining.inSeconds}초 후',
                          style: const TextStyle(color: Colors.orange, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('기상 도우미', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/img/profile.png'),
                          radius: 16,
                        ),
                        const SizedBox(width: 8),
                        const Text('홍길동'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _BottomBar(currentIndex: 0),
    );
  }
}

// ------------------------------
// 공통 BottomNavigationBar
// ------------------------------
class _BottomBar extends StatelessWidget {
  final int currentIndex;
  const _BottomBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFFFBC15B),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.alarm), label: '모닝콜'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: '모닝방'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
      ],
    );
  }
}
