import 'package:flutter/material.dart';
import 'create_morning_room_page.dart';
import 'chat_room_page.dart';

class MorningRoomPage extends StatelessWidget {
  const MorningRoomPage({super.key});

  final bool hasJoinedRoom = true; // 참여 중인 모닝방 여부 (테스트 시 true/false 바꿔보면 됨)

  void _navigateToCreateRoom(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateMorningRoomPage()),
    );
  }

  // 참여 중인 모닝방 있을 때 생성 불가 안내
  Future<bool> _showNoOverlappingRoomDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('이미 참여 중인 모닝방이 있어요'),
        content: const Text('한 번에 하나의 모닝방에만 참여할 수 있어요.\n참여 중인 모닝방이 끝난 후 다시 시도해주세요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('확인'),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              '함께 기상',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  if (hasJoinedRoom) ...[
                    const Text(
                      '참여 중인 모닝방',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    JoinedMorningRoomCard(
                      username: 'Moondae123',
                      date: '2025.04.08 (화)',
                      time: 'am 09:00',
                      description: '주말이라고 늦잠 자지 말고 갓생 살자',
                    ),
                    const SizedBox(height: 24),
                  ],
                  const Text(
                    '모닝방 리스트',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  MorningRoomCard(
                    username: '13istheBest',
                    date: '2025.04.07 (화)',
                    time: 'am 07:30',
                    description: '아침밥 먹고 1교시 수업 들으러 가기!',
                    hasJoinedRoom: hasJoinedRoom,
                  ),
                  MorningRoomCard(
                    username: 'meS2cat',
                    date: '2025.04.08 (수)',
                    time: 'am 07:00',
                    description: '학원에서 천원의 아침밥 먹고 전공 갈 예대생 구함',
                    hasJoinedRoom: hasJoinedRoom,
                  ),
                  MorningRoomCard(
                    username: 'Moondae123',
                    date: '2025.04.12 (토)',
                    time: 'am 09:00',
                    description: '주말이라고 늦잠 자지 말고 갓생 살자',
                    hasJoinedRoom: hasJoinedRoom,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => hasJoinedRoom
                      ? _showNoOverlappingRoomDialog(context) // 참여 중인 모닝방이 있으면 버튼 비활성화
                      : _navigateToCreateRoom(context), // 참여 중인 모닝방이 없으면 버튼 활성화
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hasJoinedRoom
                            ? const Color(0xFFBDBDBD) // 회색 (참여 중이면 비활성화)
                            : const Color(0xFFFFB74D), // 오렌지
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        '모닝방 생성',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MorningRoomCard extends StatelessWidget {
  final String username;
  final String date;
  final String time;
  final String description;
  final bool hasJoinedRoom; // 참여 중인 모닝방 여부 (테스트 시 true/false 바꿔보면 됨)

  // 참여 중인 모닝방 있을 때 생성 불가 안내
  Future<bool> _showNoOverlappingRoomDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('이미 참여 중인 모닝방이 있어요'),
        content: const Text('한 번에 하나의 모닝방에만 참여할 수 있어요.\n참여 중인 모닝방이 끝난 후 다시 시도해주세요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('확인'),
          ),
        ],
      ),
    ) ?? false;
  }

  const MorningRoomCard({
    super.key,
    required this.username,
    required this.date,
    required this.time,
    required this.description,
    required this.hasJoinedRoom,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                  radius: 20,
                ),
                const SizedBox(width: 8),
                Text('$username (방장)', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.orange),
                const SizedBox(width: 4),
                Text(date),
                const SizedBox(width: 12),
                const Icon(Icons.access_time, size: 16, color: Colors.orange),
                const SizedBox(width: 4),
                Text(time),
              ],
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 36,
              child: OutlinedButton(
                onPressed: () => hasJoinedRoom
                      ? _showNoOverlappingRoomDialog(context) // 참여 중인 모닝방이 있으면 버튼 비활성화
                      : null, // 참여 중인 모닝방이 없으면 버튼 활성화
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.orange,
                  side: const BorderSide(color: Colors.orange),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: const Color(0xFFFFF8E1),
                ),
                child: const Text('참여하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JoinedMorningRoomCard extends StatelessWidget {
  final String username;
  final String date;
  final String time;
  final String description;

  const JoinedMorningRoomCard({
    super.key,
    required this.username,
    required this.date,
    required this.time,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                  radius: 20,
                ),
                const SizedBox(width: 8),
                Text('$username (방장)', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.orange),
                const SizedBox(width: 4),
                Text(date),
                const SizedBox(width: 12),
                const Icon(Icons.access_time, size: 16, color: Colors.orange),
                const SizedBox(width: 4),
                Text(time),
              ],
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 36,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatRoomPage(roomId: 'abc123')), // 더미 ID
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFF0B2),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('채팅하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
