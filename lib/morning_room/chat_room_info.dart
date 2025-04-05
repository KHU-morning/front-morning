import 'package:flutter/material.dart';

class RoomInfoPage extends StatelessWidget {
  const RoomInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final friends = [
      {"name": "Moondae123", "label": "(방장)", "image": "assets/profile1.png"},
      {"name": "zoozoo08", "label": "(나)", "image": "assets/profile2.png"},
      {"name": "RYO", "label": "", "image": "assets/profile3.png"},
      {"name": "jegalhhh", "label": "", "image": "assets/profile4.png"},
      {"name": "IAMSLEEPY", "label": "", "image": "assets/profile5.png"},
      {"name": "yurimS2", "label": "", "image": "assets/profile6.png"},
    ];

  
  // 친구 초대 팝업
  void _showFriendInviteDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        final dummyFriends = [
          {'name': 'jegalhhh', 'checked': true},
          {'name': '222dohyn', 'checked': true},
          {'name': 'BaekG1', 'checked': true},
          {'name': 'nmlee06', 'checked': false},
          {'name': 'yurimS2', 'checked': false},
        ];

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('친구 초대', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ...dummyFriends.map((friend) {
                    return CheckboxListTile(
                      title: Row(
                        children: [
                          const CircleAvatar(
                            child: Icon(Icons.person, color: Colors.white, size: 20),
                            radius: 12,
                            backgroundColor: Color(0xFFF8EEAC),
                          ),
                          const SizedBox(width: 12),
                          Text(friend['name'] as String),
                        ],
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: friend['checked'] as bool,
                      onChanged: (val) {
                        setState(() => friend['checked'] = val!);
                      },
                    );
                  }),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('취소'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFF0B2),
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('초대하기'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

    return Scaffold(
      backgroundColor: Colors.white, // ✅ 배경 흰색
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          '모닝방 정보',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoCard(
                title: "기상 목표",
                child: Row(
                  children: const [
                    Icon(Icons.star, color: Colors.orange),
                    SizedBox(width: 8),
                    Expanded(child: Text("주말이라고 늦잠 자지 말고 갓생 살자")),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _infoCard(
                title: "기상 일정",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.calendar_today, size: 16, color: Colors.orange),
                        SizedBox(width: 6),
                        Text('2025.04.06 (일)'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Icon(Icons.access_time, size: 16, color: Colors.orange),
                        SizedBox(width: 6),
                        Text('am 09:00'),
                        SizedBox(width: 8),
                        Text('21분 후', style: TextStyle(color: Colors.orange)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _infoCard(
                title: "함께하는 친구들",
                child: Column(
                  children: friends
                      .map(
                        (user) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: AssetImage(user['image']!),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                '${user['name']} ${user['label']}',
                                style: const TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    _showFriendInviteDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFBC15B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text('친구 초대하기'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
