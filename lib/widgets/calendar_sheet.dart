import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarSheet extends StatefulWidget {
  final DateTime selectedDate;
  final void Function(DateTime) onDateSelected;

  const CalendarSheet({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<CalendarSheet> createState() => _CalendarSheetState();
}

class _CalendarSheetState extends State<CalendarSheet> {
  late DateTime _focusedDay;
  late DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.selectedDate;
    _selectedDay = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TableCalendar(
            locale: 'ko_KR',
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: const Color(0xFFFBC15B), // 오늘 날짜 배경
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: const Color(0xFFFFC84E), // 선택한 날짜 배경
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                if (_selectedDay != null) {
                  widget.onDateSelected(_selectedDay!);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF8EEAC),
                foregroundColor: const Color(0xFFCA8916),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '완료',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }
}
