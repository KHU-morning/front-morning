import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/calendar_sheet.dart';

class StatisticsDetailScreen extends StatefulWidget {
  final DateTime date;

  const StatisticsDetailScreen({super.key, required this.date});

  @override
  State<StatisticsDetailScreen> createState() => _StatisticsDetailScreenState();
}

class _StatisticsDetailScreenState extends State<StatisticsDetailScreen> {
  late Future<WakeDetail> _wakeDetailFuture;

  @override
  void initState() {
    super.initState();
    _wakeDetailFuture = fetchWakeDetail(widget.date);
  }

  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return CalendarSheet(
          selectedDate: widget.date,
          onDateSelected: (selectedDate) {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => StatisticsDetailScreen(date: selectedDate),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final formatted = DateFormat('yyyy년 M월 d일').format(widget.date);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('통계'),
        leading: const BackButton(),
        centerTitle: true,
        backgroundColor: const Color(0xFFF7F7F7),
      ),
      body: FutureBuilder<WakeDetail>(
        future: _wakeDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('불러오기 실패: ${snapshot.error}'));
          }

          final detail = snapshot.data!;
          final isSuccess = detail.success;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Text(
                    formatted,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 6),
                  IconButton(
                    icon: const Icon(Icons.calendar_today_outlined, size: 20),
                    onPressed: () => _showDatePicker(context),
                  ),
                ],
              ),
              const SizedBox(height: 23),
              const Text('성공 여부', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isSuccess
                            ? const Color(0xFFFFC84E) // 노랑
                            : const Color(0xFF9FA8DA), // 보라
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isSuccess ? Icons.wb_sunny : Icons.nights_stay,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      isSuccess ? '기상 성공' : '기상 실패',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF666666),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('정보', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 6),
              _buildInfoCard(detail),
              const SizedBox(height: 16),
              _buildPeopleList(isSuccess, detail.participants),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(WakeDetail detail) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoItem('유형', detail.type),
          const SizedBox(height: 15),
          _infoItem('목표 기상 시간', detail.wakeTime),
          const SizedBox(height: 15),
          _infoItem('기상 이유', detail.reason),
        ],
      ),
    );
  }

  Widget _infoItem(String label, String value) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label\n',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              height: 1.3,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              fontSize: 14,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeopleList(bool isSuccess, List<String> participants) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isSuccess ? '함께한 사람' : '참여자',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        ...participants.map(
          (name) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage('assets/img/default_profile.png'),
                ),
                const SizedBox(width: 12),
                Text(name, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ----------------------- API 연동 -----------------------

class WakeDetail {
  final bool success;
  final String type;
  final String wakeTime;
  final String reason;
  final List<String> participants;

  WakeDetail({
    required this.success,
    required this.type,
    required this.wakeTime,
    required this.reason,
    required this.participants,
  });

  factory WakeDetail.fromJson(Map<String, dynamic> json) {
    return WakeDetail(
      success: json['success'],
      type: json['type'],
      wakeTime: json['wake_time'],
      reason: json['reason'],
      participants: List<String>.from(json['participants']),
    );
  }
}

Future<WakeDetail> fetchWakeDetail(DateTime date) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  final dateString = DateFormat('yyyy-MM-dd').format(date);
  const backendUrl = 'https://port-0-back-morning-m94ntlcqbc256101.sel4.cloudtype.app';

  final response = await http.get(
    Uri.parse('$backendUrl/me/wake-record/$dateString'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    return WakeDetail.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('기상 상세 정보 불러오기 실패');
  }
}
