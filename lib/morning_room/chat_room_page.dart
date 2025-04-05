import 'package:flutter/material.dart';
import './group_call/group_call_page.dart';
import './chat_room_info.dart';

class ChatRoomPage extends StatelessWidget {
  final String roomId;

  ChatRoomPage({super.key, required this.roomId});

  final List<Map<String, dynamic>> messages = [
    { 'type': 'date', 'date': '2025년 4월 6일' },
    {
      'type': 'message',
      'username': 'yurimS2',
      'message': '아 벌써 1시인데 잠이 안 와 어떡하지ㅠㅠ',
      'time': 'am 00:58',
      'isMine': false
    },
    { 'type': 'date', 'date': '2025년 4월 7일' },
    { 
      'type': 'message','username': '나', 'message': '하 나도', 'time': 'am 01:00', 'isMine': true
    },
    {
      'type': 'message',
      'username': '나',
      'message': '내일 9시에 일어나야 하는데\n이대로 가면 우리 미션 실패하면 어쩌지...',
      'time': 'am 01:01',
      'isMine': true
    },
    {
      'type': 'message',
      'username': '나',
      'message': '야호~',
      'time': 'am 01:01',
      'isMine': true
    },
    {
      'type': 'message','username': 'Moondae123', 'message': '안 돼', 'time': 'am 01:02', 'isMine': false},
    {
      'type': 'message','username': 'Moondae123', 'message': '그럴 순 없어', 'time': 'am 01:02', 'isMine': false},
    {
      'type': 'message',
      'username': 'Moondae123',
      'message': '얼른 자자 그래야 내일 후회 안 하지...',
      'time': 'am 01:03',
      'isMine': false
    },
    {
      'type': 'message',
      'username': '나',
      'message': '그래 이제 자야지 내일 9시에 보자~~!',
      'time': 'am 01:04',
      'isMine': true
    },
    {
      'type': 'message','username': 'Moondae123', 'message': '잘 자', 'time': 'am 01:05', 'isMine': false},
    {
      'type': 'message','username': 'RYO', 'message': '배고파서 잠이 안 와요..', 'time': 'am 01:06', 'isMine': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('주말이라고 늦잠 자...', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 300),
                  pageBuilder: (_, __, ___) => const RoomInfoPage(),
                  transitionsBuilder: (_, animation, __, child) {
                    final offsetAnimation = Tween<Offset>(
                      begin: const Offset(1.0, 0.0), // 👉 오른쪽에서 시작
                      end: Offset.zero,
                    ).animate(animation);

                    return SlideTransition(position: offsetAnimation, child: child);
                  },
                ),
              );
            },
            icon: const Icon(Icons.menu)
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final bool isDate = msg['type'] == 'date';

                if (isDate) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        msg['date'],
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  );
                }

                // 👇 이전 메시지 비교
                final prevMsg = index > 0 ? messages[index - 1] : null;
                final isSameUserAndTime = prevMsg != null &&
                    prevMsg['type'] == 'message' &&
                    prevMsg['username'] == msg['username'] &&
                    prevMsg['time'] == msg['time'];

                return _buildChatBubble(
                  isMine: msg['isMine'],
                  username: msg['username'],
                  message: msg['message'],
                  time: msg['time'],
                  showUserNick: !isSameUserAndTime,
                  showTime: !isSameUserAndTime,
                );
              },
            ),
          ),
          const Divider(height: 1),
          _buildInputArea(context),
        ],
      ),
      // ✅ 디버깅용 플로팅 버튼
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          backgroundColor: Colors.orange,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.phone),
              SizedBox(height: 4),
              Text('디버깅용', style: TextStyle(fontSize: 10)),
              ],
            ),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const GroupCallPage()),
            );
          },
        )
      ),
    );
  }

  Widget _buildChatBubble({
    required bool isMine,
    required String username,
    required String message,
    required String time,
    required bool showUserNick,
    required bool showTime,
  }) {
    final bubbleColor = isMine ? const Color(0xFFFFF0B2) : Colors.white;
    final alignment = isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // 아래쪽 정렬
        mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          // 상대방 메시지일 때 프로필 사진 왼쪽에 배치
          if (!isMine)
            const CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            )
          else
            const SizedBox(width: 32), // 내 메시지일 때 여백 추가

          if (!isMine) const SizedBox(width: 8),

          Flexible(
            child: Column(
              crossAxisAlignment: alignment,
              children: [
                if (!isMine && showUserNick)
                  Text(username, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: bubbleColor,
                    borderRadius: isMine
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(4), // 내 말풍선 오른쪽 살짝 각짐
                          )
                        : const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(4), // 상대 말풍선 왼쪽 살짝 각짐
                            bottomRight: Radius.circular(16),
                          ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(100, 128, 128, 128), // 그림자 색상
                        blurRadius: 1, // 그림자 번짐
                        offset: const Offset(0, 0), // x축, y축 방향
                      ),
                    ],
                  ),
                  child: Text(message),
                ),
                const SizedBox(height: 4),
                if (showTime)
                  Text(
                    time,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
              ],
            ),
          ),

          if (isMine) const SizedBox(width: 8),

          // 내 메시지일 때 프로필 사진 오른쪽에 배치
          if (isMine)
            const CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
        ],
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    hintText: '메시지를 입력해주세요',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFFF2F2F2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFB74D),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_upward, color: Colors.white),
                  onPressed: () {
                    // TODO: 보내기 기능
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
