import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/morning_room_list.dart';
import 'create_morning_room_page.dart';
import 'chat_room_page.dart';

class MorningRoomPage extends StatefulWidget {
  const MorningRoomPage({super.key});

  @override
  State<MorningRoomPage> createState() => _MorningRoomPageState();
}

class _MorningRoomPageState extends State<MorningRoomPage> {
  Map<String, dynamic>? joinedRoom;
  List<Map<String, dynamic>> morningRooms = [];

  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  Future<void> _loadRooms() async {
    try {
      final rooms = await fetchMorningRoomList();
      final prefs = await SharedPreferences.getInstance();
      final username = prefs.getString('username') ?? '';

      // 내가 참여한 방과 아닌 방 나누기
      Map<String, dynamic>? myRoom;
      List<Map<String, dynamic>> otherRooms = [];

      for (final room in rooms) {
        final participants = List<String>.from(room['participants'] ?? []);
        if (participants.contains(username)) {
          myRoom = room;
        } else {
          otherRooms.add(room);
        }
      }

      setState(() {
        joinedRoom = myRoom;
        morningRooms = otherRooms;
      });
    } catch (e) {
      print('에러 발생: $e');
    }
  }

  void _navigateToCreateRoom(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateMorningRoomPage()),
    );
  }

  Future<bool> _showNoOverlappingRoomDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('이미 참여 중인 모닝방이 있어요'),
            content: const Text(
                '한 번에 하나의 모닝방에만 참여할 수 있어요.\n참여 중인 모닝방이 끝난 후 다시 시도해주세요.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('확인'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final hasJoinedRoom = joinedRoom != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 200,
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
          child: const Text('모닝방 생성', style: TextStyle(fontSize: 16)),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text('함께 기상',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  if (hasJoinedRoom) ...[
                    const Text(
                      '참여 중인 모닝방',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    JoinedMorningRoomCard(
                      username: joinedRoom?['created_by'] ?? '',
                      date: joinedRoom?['wake_date'] ?? '',
                      time: joinedRoom?['wake_time'] ?? '',
                      description: joinedRoom?['title'] ?? '',
                    ),
                    const SizedBox(height: 24),
                  ],
                  const Text(
                    '모닝방 리스트',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  ...morningRooms.map((room) {
                    print("rr${room}");
                    return MorningRoomCard(
                      username: room['created_by'],
                      date: room['wake_date'],
                      time: room['wake_time'],
                      description: room['title'],
                      hasJoinedRoom: hasJoinedRoom,
                    );
                  }),
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
  final bool hasJoinedRoom;

  const MorningRoomCard({
    super.key,
    required this.username,
    required this.date,
    required this.time,
    required this.description,
    required this.hasJoinedRoom,
  });

  Future<void> _handleJoin(BuildContext context) async {
    if (hasJoinedRoom) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('이미 참여 중인 모닝방이 있어요'),
          content: const Text('하나의 모닝방에만 참여할 수 있어요.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('확인'),
            ),
          ],
        ),
      );
    } else {
      // 참여 로직 추가 예정
    }
  }

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
                  backgroundImage: AssetImage("assets/img/hgd123.png"),
                  radius: 15,
                ),
                const SizedBox(width: 8),
                Text('$username (방장)'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.calendar_today,
                    size: 20, color: Color(0xFFFBC15B)),
                const SizedBox(width: 8),
                Text(date),
                const SizedBox(width: 20),
                const Icon(Icons.access_time,
                    size: 20, color: Color(0xFFFBC15B)),
                const SizedBox(width: 8),
                Text(time),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.star, size: 20, color: Color(0xFFFBC15B)),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: OutlinedButton(
                onPressed: () => _handleJoin(context),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 115, vertical: 10),
                  foregroundColor: const Color(0xFFCA8916),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
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
                const Icon(Icons.calendar_today,
                    size: 20, color: Color(0xFFFBC15B)),
                const SizedBox(width: 8),
                Text(date),
                const SizedBox(width: 20),
                const Icon(Icons.access_time,
                    size: 20, color: Color(0xFFFBC15B)),
                const SizedBox(width: 8),
                Text(time),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.star, size: 20, color: Color(0xFFFBC15B)),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
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
                    MaterialPageRoute(
                        builder: (context) => ChatRoomPage(roomId: 'abc123')),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 103, vertical: 10),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFFBC15B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  side: BorderSide.none,
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
