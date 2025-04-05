import 'package:flutter/material.dart';
import 'morning_call_request_page.dart';

class MorningCallListPage extends StatelessWidget {
  const MorningCallListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  '따로 기상',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '모닝콜 리스트',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 80.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 6,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // border-radius: 12px
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.blue,
                                  child: Icon(Icons.person, color: Colors.white, size: 20),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '닉네임',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: Color(0xFFEEEEEE),
                              thickness: 1,
                            ),
                            const SizedBox(height: 1),
                            const Row(
                              children: [
                                Icon(Icons.calendar_today, size: 18, color: Color(0xFFFBC15B)),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '2024.04.02',
                                    style: TextStyle(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Row(
                              children: [
                                Icon(Icons.access_time, size: 18, color: Color(0xFFFBC15B)),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '07:00 AM',
                                    style: TextStyle(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Row(
                              children: [
                                Icon(Icons.star, size: 18, color: Color(0xFFFBC15B)),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '아침 수업이 있어요',
                                    style: TextStyle(fontSize: 14),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            SizedBox(
                              width: double.infinity,
                              height: 36,
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('모닝콜 수락'),
                                      content: const Text('이 친구의 모닝콜을 수락하시겠습니까?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('취소'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('수락'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFF8EEAC),
                                  foregroundColor: Color.fromRGBO(202, 137, 22, 1),
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  '깨워주기',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(0.8),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SizedBox(
                  width: 232,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/morning_call/request');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFBC15B),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: BorderSide.none,
                      ),
                    ),
                    child: const Text('모닝콜 요청'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 