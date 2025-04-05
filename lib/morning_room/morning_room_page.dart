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
      backgroundColor: const Color(0xFFF7F7F7),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 200, // 원하는 버튼 너비
        height: 48,
        child: ElevatedButton(
          onPressed: () => hasJoinedRoom
              ? _showNoOverlappingRoomDialog(context)
              : _navigateToCreateRoom(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: hasJoinedRoom
                ? const Color(0xFFB0B0B0)
                : const Color(0xFFFBC15B),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: const Text(
            '모닝방 생성',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              '함께 기상',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
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
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/img/default_profile.png'),
                  radius: 15,
                ),
                const SizedBox(width: 8),
                Text('$username (방장)'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 20, color: Color(0xFFFBC15B)),
                const SizedBox(width: 8),
                Text(date),
                const SizedBox(width: 20),
                const Icon(Icons.access_time, size: 20, color: Color(0xFFFBC15B)),
                const SizedBox(width: 8),
                Text(time),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.star, size: 20, color: Color(0xFFFBC15B)),
                const SizedBox(width: 4),
                Text(description,
                  overflow: TextOverflow.ellipsis, // ✅ ... 처리
                  maxLines: 1,                      // ✅ 한 줄까지만 표시)
                ),
              ],
            ),
            const SizedBox(height: 20),

            Align(
              alignment: Alignment.center,
              child: OutlinedButton(
                onPressed: hasJoinedRoom
                    ? () => _showNoOverlappingRoomDialog(context)
                    : null,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 115, vertical: 10), // ✅ 내부 여백으로 너비 조절
                  foregroundColor: const Color(0xFFCA8916),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: const Color(0xFFF8EEAC),
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
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/img/default_profile.png'),
                  radius: 15,
                ),
                const SizedBox(width: 8),
                Text('$username (방장)'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 20, color: Color(0xFFFBC15B)),
                const SizedBox(width: 8),
                Text(date),
                const SizedBox(width: 20),
                const Icon(Icons.access_time, size: 20, color: Color(0xFFFBC15B)),
                const SizedBox(width: 8),
                Text(time),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.star, size: 20, color: Color(0xFFFBC15B)),
                const SizedBox(width: 4),
                Text(
                  description,
                  overflow: TextOverflow.ellipsis, // ✅ ... 처리
                  maxLines: 1,                      // ✅ 한 줄까지만 표시)
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            Align(
              alignment: Alignment.center,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatRoomPage(roomId: 'abc123')), // 더미 ID
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 115-12, vertical: 10), // ✅ 내부 여백으로 너비 조절
                  foregroundColor: Colors.white,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: const Color(0xFFFBC15B),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.chat_bubble_outline, size: 18),
                    SizedBox(width: 6),
                    Text('채팅하기', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
