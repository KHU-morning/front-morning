import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/morning_call_list.dart';
import 'morning_call_request_page.dart';

class MorningCallListPage extends StatefulWidget {
  const MorningCallListPage({super.key});

  @override
  State<MorningCallListPage> createState() => _MorningCallListPageState();
}

class _MorningCallListPageState extends State<MorningCallListPage> {
  late Future<List<Map<String, dynamic>>> _wakeRequests;

  @override
  void initState() {
    super.initState();
    _wakeRequests = fetchWakeRequests();
  }

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
                child: Text('따로 기상', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '모닝콜 리스트',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: FutureBuilder(
                  future: _wakeRequests,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text("에러 발생: ${snapshot.error}"));
                    }
                    final requests = snapshot.data!;
                    if (requests.isEmpty) {
                      return const Center(child: Text("모닝콜 요청이 없습니다."));
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 80.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 6,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        final req = requests[index];
                        final requester = req['requester'];
                        final date = req['wake_date'];
                        final time = req['wake_time'];
                        final reason = req['reason'];
                        final is_public = req['is_public'];

                        return Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Colors.blue,
                                      child: Icon(Icons.person, color: Colors.white, size: 20),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        requester ?? '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(color: Color(0xFFEEEEEE), thickness: 1),
                                const SizedBox(height: 1),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today, size: 18, color: Color(0xFFFBC15B)),
                                    const SizedBox(width: 8),
                                    Expanded(child: Text(date, style: const TextStyle(fontSize: 14))),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time, size: 18, color: Color(0xFFFBC15B)),
                                    const SizedBox(width: 8),
                                    Expanded(child: Text(time, style: const TextStyle(fontSize: 14))),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 18, color: Color(0xFFFBC15B)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        is_public? reason : '비공개입니다',
                                        style: const TextStyle(fontSize: 14),
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
                                        builder: (context) => Dialog(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                          insetPadding: const EdgeInsets.symmetric(horizontal: 40),
                                          backgroundColor: const Color(0xFFFCFCFC),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(height: 24),
                                              Text(
                                                '$requester님을 깨워주시겠어요?',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                              ),
                                              const SizedBox(height: 12),
                                              Text(
                                                '날짜 및 시간: $date $time\n이유: $reason',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(fontSize: 13, color: Color(0xFF888888), height: 1.4),
                                              ),
                                              const SizedBox(height: 20),
                                              const Divider(height: 1, color: Color(0xFFE0E0E0)),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () => Navigator.pop(context),
                                                      child: const SizedBox(
                                                        height: 48,
                                                        child: Center(child: Text('취소', style: TextStyle(fontSize: 15))),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(width: 1, height: 48, color: const Color(0xFFE0E0E0)),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        // TODO: 수락 처리 API 호출
                                                      },
                                                      child: const SizedBox(
                                                        height: 48,
                                                        child: Center(
                                                          child: Text('확인', style: TextStyle(fontSize: 15, color: Color(0xFFCA8916))),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFF8EEAC),
                                      foregroundColor: const Color(0xFFCA8916),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: const Text('깨워주기', style: TextStyle(fontSize: 14)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
                      backgroundColor: const Color(0xFFFBC15B),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
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
