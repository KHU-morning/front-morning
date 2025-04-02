import 'package:flutter/material.dart';

class MorningCallRequestPage extends StatefulWidget {
  const MorningCallRequestPage({super.key});

  @override
  State<MorningCallRequestPage> createState() => _MorningCallRequestPageState();
}

class _MorningCallRequestPageState extends State<MorningCallRequestPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final TextEditingController _reasonController = TextEditingController();
  bool isPublic = true;
  int _selectedIndex = 0;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('모닝콜 요청'),
        backgroundColor: Colors.white,
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
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('날짜', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
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
                            child: const Icon(Icons.calendar_today, color: Color.fromRGBO(23, 23, 23, 1)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('시간', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${selectedTime.hour.toString().padLeft(2, '0')} : ${selectedTime.minute.toString().padLeft(2, '0')}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTime = TimeOfDay(hour: selectedTime.hourOfPeriod, minute: selectedTime.minute);
                                });
                              },
                                child: Container(
                                width: 80,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: selectedTime.period == DayPeriod.am ? const Color(0xFFF8EEAC) : const Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'am',
                                  style: TextStyle(
                                  fontSize: 14,
                                  color: selectedTime.period == DayPeriod.am ? const Color(0xFFCA8916) : const Color(0xFF171717),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTime = TimeOfDay(hour: selectedTime.hourOfPeriod + 12, minute: selectedTime.minute);
                                });
                              },
                              child: Container(
                                width: 80,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: selectedTime.period == DayPeriod.pm ? const Color(0xFFF8EEAC) : const Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'pm',
                                  style: TextStyle(
                                  fontSize: 14,
                                  color: selectedTime.period == DayPeriod.pm ? const Color(0xFFCA8916) : const Color(0xFF171717),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('이유', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                                hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                                border: InputBorder.none,
                                counterText: '',
                              ),
                              maxLength: 10,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.clear, size: 18, color: Colors.grey),
                          onPressed: () => _reasonController.clear(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('공백 포함 10자 이내', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                      Row(
                        children: [
                            Checkbox(
                            value: isPublic,
                            onChanged: (value) => setState(() => isPublic = value ?? true),
                            activeColor: const Color.fromRGBO(251, 193, 91, 1),
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
                  String weekday = ['월', '화', '수', '목', '금', '토', '일'][selectedDate.weekday - 1];
                  String period = selectedTime.period == DayPeriod.am ? 'am' : 'pm';
                  int displayHour = selectedTime.hourOfPeriod == 0 ? 12 : selectedTime.hourOfPeriod;

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('이대로 모닝콜을 요청하시겠어요?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('날짜&시간 : ${selectedDate.year}.${selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.day.toString().padLeft(2, '0')}($weekday) ${displayHour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}$period'),
                          const SizedBox(height: 8),
                          Text('이유: ${_reasonController.text}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('취소'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text('확인'),
                        ),
                      ],
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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: '모닝콜'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '모닝방'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}