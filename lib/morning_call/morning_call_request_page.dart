import 'package:flutter/material.dart';
import '../data/wake_request.dart';
import '../widgets/calendar_sheet.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class MorningCallRequestPage extends StatefulWidget {
  const MorningCallRequestPage({super.key});

  @override
  State<MorningCallRequestPage> createState() => _MorningCallRequestPageState();
}

class _MorningCallRequestPageState extends State<MorningCallRequestPage> {
  DateTime selectedDate = DateTime.now();
  int selectedHour = 8;
  int selectedMinute = 30;
  String period = 'AM';
  final TextEditingController _reasonController = TextEditingController();
  bool isPublic = true;
  int _selectedIndex = 0;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return CalendarSheet(
          selectedDate: selectedDate,
          onDateSelected: (picked) {
            setState(() {
              selectedDate = picked;
            });
            Navigator.pop(context); // 모달 닫기
          },
        );
      },
    );
  }

  TimeOfDay get selectedTime {
    final hour = period == 'AM' ? selectedHour % 12 : (selectedHour % 12) + 12;
    return TimeOfDay(hour: hour, minute: selectedMinute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        title: const Text('모닝콜 요청'),
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('날짜',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color.fromRGBO(0, 0, 0, 0.15)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${selectedDate.year}.${selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.day.toString().padLeft(2, '0')}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.calendar_today,
                                color: Color(0xFF171717)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildTimePicker(),
                  const SizedBox(height: 24),
                  const Text('이유',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: TextField(
                              controller: _reasonController,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                hintText: '설정한 시간에 일어나야 하는 이유를 작성해주세요.',
                                hintStyle:
                                    TextStyle(fontSize: 13, color: Colors.grey),
                                border: InputBorder.none,
                                counterText: '',
                              ),
                              maxLength: 10,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.clear,
                              size: 18, color: Colors.grey),
                          onPressed: () => _reasonController.clear(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('공백 포함 10자 이내',
                          style: TextStyle(
                              color: Color(0xFFB6B6B6), fontSize: 12)),
                      Row(
                        children: [
                          Checkbox(
                            value: isPublic,
                            onChanged: (value) =>
                                setState(() => isPublic = value ?? true),
                            activeColor: const Color(0xFFFBC15B),
                          ),
                          const Text('공개', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  String weekday = [
                    '월',
                    '화',
                    '수',
                    '목',
                    '금',
                    '토',
                    '일'
                  ][selectedDate.weekday - 1];
                  String formattedPeriod = period.toLowerCase();
                  int displayHour = selectedHour == 0 ? 12 : selectedHour;

                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => Dialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                                          const SizedBox(height: 24),
                          const Text(
                            '이대로 모닝콜을 요청하시겠어요?',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '날짜 및 시간: ${selectedDate.year}.${selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.day.toString().padLeft(2, '0')}(${[
                              "월",
                              "화",
                              "수",
                              "목",
                              "금",
                              "토",
                              "일"
                            ][selectedDate.weekday - 1]}) ${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} ${period.toLowerCase()}',
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 4),
                          Text('이유: ${_reasonController.text}',
                              style: const TextStyle(fontSize: 13)),
                          const SizedBox(height: 24),
                          const Divider(height: 1),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    height: 48,
                                    alignment: Alignment.center,
                                    child: Center(
                                      child: Text('취소',
                                          style: TextStyle(color: Colors.grey)),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  width: 1,
                                  height: 48,
                                  color: const Color(0xFFE0E0E0)),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                  Navigator.pop(context); // 다이얼로그 닫기

                                  final wakeDate =
                                      '${selectedDate.year.toString().padLeft(4, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
                                  final wakeTime =
                                      '${(period == 'PM' && selectedHour != 12 ? selectedHour + 12 : selectedHour == 12 && period == 'AM' ? 0 : selectedHour).toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')}';

                                  final success = await createWakeRequest(
                                    wakeDate: wakeDate,
                                    wakeTime: wakeTime,
                                    reason: _reasonController.text,
                                    isPublic: isPublic,
                                  );

                                  if (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('모닝콜 요청이 등록되었습니다.')),
                                    );
                                    Navigator.pop(context); // 이전 페이지로
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('요청에 실패했습니다.')),
                                    );
                                  }},
                                  child: Container(
                                    height: 48,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      '확인',
                                      style: TextStyle(
                                        color: Color(0xFFCA8916),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade300,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('완료', style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFFF7F7F7),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.alarm), label: '모닝콜'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: '모닝방'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFFFBC15B),
          onTap: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('시간',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center, // ✅ 중앙 정렬로 수정
            children: [
              // 시(hour)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_drop_up),
                    onPressed: () {
                      if (selectedHour < 12) setState(() => selectedHour++);
                    },
                  ),
                  Text(selectedHour.toString().padLeft(2, '0'),
                      style: const TextStyle(fontSize: 20)),
                  IconButton(
                    icon: const Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      if (selectedHour > 1) setState(() => selectedHour--);
                    },
                  ),
                ],
              ),

              // 분(minute)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_drop_up),
                    onPressed: () {
                      if (selectedMinute < 59) setState(() => selectedMinute++);
                    },
                  ),
                  Text(selectedMinute.toString().padLeft(2, '0'),
                      style: const TextStyle(fontSize: 20)),
                  IconButton(
                    icon: const Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      if (selectedMinute > 0) setState(() => selectedMinute--);
                    },
                  ),
                ],
              ),

              // AM/PM 선택 (세로 정렬 + 높이 맞춤)
              Column(
                mainAxisAlignment: MainAxisAlignment.center, // ✅ 가운데 정렬
                children: ['AM', 'PM'].map((e) {
                  final isSelected = period == e;
                  return GestureDetector(
                    onTap: () => setState(() => period = e),
                    child: Container(
                      width: 70,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? Colors.yellow[100] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          e.toLowerCase(),
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                isSelected ? Colors.orange : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNumberPicker(
      int min, int max, int current, ValueChanged<int> onChanged) {
    return Column(
      children: [
        IconButton(
            icon: const Icon(Icons.arrow_drop_up),
            onPressed: () {
              if (current < max) onChanged(current + 1);
            }),
        Text(current.toString().padLeft(2, '0'),
            style: const TextStyle(fontSize: 20)),
        IconButton(
            icon: const Icon(Icons.arrow_drop_down),
            onPressed: () {
              if (current > min) onChanged(current - 1);
            }),
      ],
    );
  }
}
