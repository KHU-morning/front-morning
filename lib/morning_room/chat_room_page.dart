import 'package:flutter/material.dart';
import './group_call/group_call_page.dart';
import './chat_room_info.dart';

class ChatRoomPage extends StatelessWidget {
  final String roomId;

  ChatRoomPage({super.key, required this.roomId});

  final List<Map<String, dynamic>> messages = [
    {'type': 'date', 'date': '2025년 4월 5일'},
    {
      'type': 'message',
      'username': '윤유림',
      'message': '아 벌써 1시인데 잠이 안 와 어떡하지ㅠㅠ',
      'time': 'am 00:58',
      'isMine': false,
      'user': 'yunoel22'
    },
    {'type': 'date', 'date': '2025년 4월 6일'},
    {
      'type': 'message',
      'username': '나',
      'message': '하 나도',
      'time': 'am 01:00',
      'isMine': true,
      'user': 'qorjiwon'
    },
    {
      'type': 'message',
      'username': '나',
      'message': '내일 9시에 일어나야 하는데\n이대로 가면 우리 미션 실패하면 어쩌지...',
      'time': 'am 01:01',
      'isMine': true,
      'user': 'qorjiwon'
    },
    {
      'type': 'message',
      'username': '민혁',
      'message': '안 돼',
      'time': 'am 01:02',
      'isMine': false,
      'user': 'jegalhhh',
    },
    {
      'type': 'message',
      'username': '민혁',
      'message': '그럴 순 없어',
      'time': 'am 01:02',
      'isMine': false,
      'user': 'jegalhhh',
    },
    {
      'type': 'message',
      'username': '도현',
      'message': '얼른 자자 그래야 내일 후회 안 하지...',
      'time': 'am 01:0',
      'isMine': false,
      'user': 'lrynizz',
    },
    {
      'type': 'message',
      'username': '나',
      'message': '그래 이제 자야지 내일 9시에 보자~~!',
      'time': 'am 01:04',
      'isMine': true,
      'user': 'qorjiwon',
    },
    {
      'type': 'message',
      'username': '민혁',
      'message': '잘 자',
      'time': 'am 01:05',
      'isMine': false,
      'user': 'jegalhhh',
    },
    {
      'type': 'message',
      'username': '나민',
      'message': '배고파서 잠이 안 와요..',
      'time': 'am 01:06',
      'isMine': false,
      'user': 'inamin419',
    },
  ];

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () async {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const GroupCallPage()),
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Column(
        children: [
          Container(
            height: 40, // 40px 여백
            color: const Color(0xFFF7F7F7), // 흰색 배경
          ),
          AppBar(
            elevation: 0,
            backgroundColor: const Color(0xFFF7F7F7),
            title: const Text(
              '주말이라고 늦잠 자...',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        );
                      }

                      // 👇 이전 메시지 비교
                      final prevMsg = index > 0 ? messages[index - 1] : null;
                      final nextMsg = index < messages.length - 1
                          ? messages[index + 1]
                          : null;

                      final isSameUserAndTime = prevMsg != null &&
                          prevMsg['type'] == 'message' &&
                          prevMsg['username'] == msg['username'] &&
                          prevMsg['time'] == msg['time'];

                      bool showTime = nextMsg != null &&
                          nextMsg['type'] == 'message' &&
                          (nextMsg['username'] != msg['username'] ||
                              nextMsg['time'] != msg['time']);
                      if (index == messages.length - 1) {
                        showTime = true; // 마지막 메시지는 항상 시간 표시
                      }

                      return _buildChatBubble(
                        isMine: msg['isMine'],
                        username: msg['username'],
                        message: msg['message'],
                        time: msg['time'],
                        showUserNick: !isSameUserAndTime,
                        showTime: showTime,
                        user: msg['user'], // ✅ 여기 추가
                      );
                    },
                  ),
                ),
                const Divider(height: 1),
                _buildInputArea(context),
              ],
            ),
          ),
        ],
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
    required String user, // ✅ 여기에 user 추가
  }) {
    final bubbleColor = isMine ? const Color(0xFFFFF0B2) : Colors.white;
    final alignment =
        isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMine && showUserNick)
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/img/$user.png'), // ✅ 동적 경로
            )
          else if (!isMine)
            const SizedBox(width: 40)
          else
            const SizedBox(width: 20),
          if (!isMine) const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: alignment,
              children: [
                if (!isMine && showUserNick)
                  Text(username,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500)),
                Container(
                  margin: const EdgeInsets.only(top: 1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: bubbleColor,
                    borderRadius: isMine
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(4),
                          )
                        : const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(16),
                          ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(100, 128, 128, 128),
                        blurRadius: 1,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Text(message),
                ),
                if (showTime)
                  Text(
                    time,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
              ],
            ),
          ),
          if (isMine) const SizedBox(width: 8),
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
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    hintText: '메시지를 입력해주세요',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFFF2F2F2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Container(
                      margin: const EdgeInsets.only(right: 4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFB74D),
                      ),
                      child: IconButton(
                        icon:
                            const Icon(Icons.arrow_upward, color: Colors.white),
                        onPressed: () {
                          // TODO: 보내기 기능
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
