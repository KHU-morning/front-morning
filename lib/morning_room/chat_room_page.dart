import 'package:flutter/material.dart';
import './group_call/group_call_page.dart';

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

  void _showWakeSuccessDialog(BuildContext context) {
    final participants = [
      {"name": "Moondae123", "image": "assets/profile1.png"},
      {"name": "yurimS2", "image": "assets/profile2.png"},
      {"name": "jegalhhh", "image": "assets/profile3.png"},
      {"name": "RYO", "image": "assets/profile4.png"},
      {"name": "zoozoo08", "image": "assets/profile5.png"},
      {"name": "IAMSLEEPY", "image": "assets/profile6.png"},
    ];

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
              const Text('기상 성공', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                '모든 멤버가 참여하셨군요!\n저장된 기록은 마이페이지에서 확인해보세요',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
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
                  showUserInfo: !isSameUserAndTime,
                );
              },
            ),
          ),
          const Divider(height: 1),
          _buildInputArea(context),
        ],
      ),
      // ✅ 디버깅용 플로팅 버튼
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.phone),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const InCallPage()),
          );

          if (result == true) {
            _showWakeSuccessDialog(context); // ✅ 성공 팝업 호출
          }
        },
      ),
    );
  }

  Widget _buildChatBubble({
    required bool isMine,
    required String username,
    required String message,
    required String time,
    required bool showUserInfo,
  }) {
    final bubbleColor = isMine ? const Color(0xFFFFF0B2) : Colors.white;
    final alignment = isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    // final radius = isMine
    //   ? const BorderRadius.only(
    //       topLeft: Radius.circular(16),
    //       topRight: Radius.circular(4),
    //       bottomLeft: Radius.circular(16),
    //       bottomRight: Radius.circular(16),
    //     )
    //   : const BorderRadius.only(
    //       topLeft: Radius.circular(4),
    //       topRight: Radius.circular(16),
    //       bottomLeft: Radius.circular(16),
    //       bottomRight: Radius.circular(16),
    //     );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMine && showUserInfo)
            const CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
          if (!isMine && showUserInfo) const SizedBox(width: 8),

          Flexible(
            child: Column(
              crossAxisAlignment: alignment,
              children: [
                if (!isMine && showUserInfo)
                  Text(username, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: bubbleColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(message),
                ),
                const SizedBox(height: 4),
                Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),

          if (isMine && showUserInfo) const SizedBox(width: 8),
          if (isMine && showUserInfo)
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  hintText: '메시지를 입력해주세요',
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
            )
          ],
        ),
      ),
    );
  }
}
