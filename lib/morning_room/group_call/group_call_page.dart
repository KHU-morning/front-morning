import 'package:flutter/material.dart';
import 'dart:async';

class GroupCallPage extends StatelessWidget {
  const GroupCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyParticipants = [
      'assets/img1.png',
      'assets/img2.png',
      'assets/img3.png',
      'assets/img4.png',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF3B0),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '모두 일어날 시간',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              '모닝방의 음성 채팅이 활성화되었어요!\n30초 이내에 전원이 참여하면 성공이에요',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 150,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/alarm_clock.png'), // 알람 이미지
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/profile.png'),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text('현재 ${dummyParticipants.length}/6명 참여'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(dummyParticipants.length, (index) {
                  return Positioned(
                    left: index * 24, // 겹침 간격 조절 (작을수록 더 많이 겹침)
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(dummyParticipants[index]),
                    ),
                  );
                }),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const InCallPage(),
                  ),
                );
              },
              icon: const Icon(Icons.call),
              label: const Text('참여하기'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFB74D),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InCallPage extends StatefulWidget {
  const InCallPage({super.key});

  @override
  State<InCallPage> createState() => _InCallPageState();
}

class _InCallPageState extends State<InCallPage> {
  int seconds = 0;
  bool isWakeSuccess = false; // 기상 성공 여부 (true: 성공, false: 실패)
  late Timer _timer;

  final participants = [
    {"name": "Moondae123", "image": "assets/profile1.png"},
    {"name": "yurimS2", "image": "assets/profile2.png"},
    {"name": "jegalhhh", "image": "assets/profile3.png"},
    {"name": "RYO", "image": "assets/profile4.png"},
    {"name": "zoozoo08", "image": "assets/profile5.png"},
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => seconds++);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final mins = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  @override
  Widget build(BuildContext context) {
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
                const Text('함께 기상', style: TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 12),
                Text(isWakeSuccess?'기상 성공':'기상 실패', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  isWakeSuccess
                  ? '모든 멤버가 참여하셨군요!\n저장된 기록은 마이페이지에서 확인해보세요'
                  : '모든 멤버가 참여하지 못했어요\n다음 기회에 도전해보세요',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  children: participants.map((user) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: AssetImage(user['image']!),
                        ),
                        const SizedBox(height: 4),
                        Text(user['name']!, style: const TextStyle(fontSize: 12)),
                      ],
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFB74D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text('확인'),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFF3B0),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            Text(
              '${participants.length}/6명 참여',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              _formatTime(seconds),
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                children: participants
                    .map((user) => Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(user["image"]!),
                            ),
                            const SizedBox(height: 8),
                            Text(user["name"]!, style: const TextStyle(fontSize: 13)),
                          ],
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 12),
            IconButton(
              icon: const Icon(Icons.call_end, size: 36, color: Colors.red),
              onPressed: () {
                Navigator.pushNamed(context, '/home'); // 방 종료 후 모닝룸으로 이동
                _showWakeResultDialog(context); // 팝업도 띄움
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
