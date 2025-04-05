import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/calendar_sheet.dart';

class StatisticsDetailScreen extends StatelessWidget {
  final DateTime date;

  const StatisticsDetailScreen({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final formatted = DateFormat('yyyy년 M월 d일').format(date);
    final isSuccess = date.day % 2 == 1; // 예시: 홀수일 성공, 짝수일 실패

    void _showDatePicker(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return CalendarSheet(
            selectedDate: date,
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

    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('통계'),
        leading: const BackButton(),
        centerTitle: true,
        backgroundColor: Color(0xFFF7F7F7),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Text(formatted,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
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
                        ? const Color(0xFFFFC84E)
                        : const Color(0xFF9FA8DA), // ✅ 배경색
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
                    color: Color(0xFF666666), // ✅ 텍스트 컬러 (회색톤)
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('정보', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 6),
          _buildInfoCard(),
          const SizedBox(height: 16),
          _buildPeopleList(isSuccess),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '유형\n',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
                TextSpan(
                  text: '따로 기상 (개인 모닝콜)',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '목표 기상 시간\n',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
                TextSpan(
                  text: 'am 07:30',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '기상 이유\n',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
                TextSpan(
                  text: '땅콩물이 걱정돼서',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeopleList(bool isSuccess) {
    final people = isSuccess ? ['ENTJboy'] : ['IAMSLEEPY (방장)', 'meS2cat'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isSuccess ? '깨워준 사람' : '함께한 사람',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        ...people.map(
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
                  backgroundImage:
                      AssetImage('assets/img/default_profile.png'), // ✅ 이미지 적용
                ),
                const SizedBox(width: 12),
                Text(
                  name,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
