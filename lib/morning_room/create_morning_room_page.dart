import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateMorningRoomPage extends StatefulWidget {
  const CreateMorningRoomPage({super.key});

  @override
  State<CreateMorningRoomPage> createState() => _CreateMorningRoomPageState();
}

class _CreateMorningRoomPageState extends State<CreateMorningRoomPage> {
  bool isPublic = true;
  DateTime selectedDate = DateTime.now();
  int selectedHour = 8;
  int selectedMinute = 30;
  bool isAm = true;
  final TextEditingController _goalController = TextEditingController();

  String get formattedDate => DateFormat('yyyy.MM.dd (E)', 'ko_KR').format(selectedDate);

  void _openDatePicker() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: 350,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: CalendarDatePicker(
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  onDateChanged: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFF0B2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('완료'),
              ),
            ],
          ),
        );
      },
    );
  }

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
                            radius: 10,
                            backgroundColor: Colors.yellow,
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

  // 모닝방 생성 확인 팝업
  Future<void> _showCreateConfirmDialog() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('이대로 모닝방을 생성하시겠어요?'),
        content: Text(
          '공개 여부: ${isPublic ? "공개" : "비공개"}\n'
          '날짜 및 시간: ${DateFormat('yyyy.MM.dd (E) HH:mm', 'ko_KR').format(selectedDate)}\n'
          '목표: ${_goalController.text}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('모닝방 생성 완료')),
              );
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  // 모닝방 생성 취소 확인 팝업
  Future<bool> _showExitConfirmDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('모닝방 생성을 그만두시겠어요?'),
        content: const Text('작성 중인 내용은 저장되지 않아요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('확인'),
          ),
        ],
      ),
    ) ?? false;
  }

  Widget _buildTimeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_drop_up),
          onPressed: () => setState(() {
            selectedHour = (selectedHour % 12) + 1;
          }),
        ),
        Text('${selectedHour.toString().padLeft(2, '0')} :',
            style: const TextStyle(fontSize: 18)),
        IconButton(
          icon: const Icon(Icons.arrow_drop_up),
          onPressed: () => setState(() {
            selectedMinute = (selectedMinute + 5) % 60;
          }),
        ),
        Text(selectedMinute.toString().padLeft(2, '0'),
            style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 8),
        ToggleButtons(
          isSelected: [isAm, !isAm],
          onPressed: (index) => setState(() => isAm = index == 0),
          borderRadius: BorderRadius.circular(8),
          selectedColor: Colors.white,
          fillColor: const Color(0xFFFFF0B2),
          children: const [Text('am'), Text('pm')],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // 뒤로가기 방지
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return; // 사용자가 이미 팝된 상태면 아무 것도 안 함

        bool confirm = await _showExitConfirmDialog();
        if (confirm) {
          Navigator.pop(context, result); // 직접 pop 수행
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('모닝방 생성'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('함께할 사람', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildModeButton('공개', isPublic),
                    const SizedBox(width: 8),
                    _buildModeButton('비공개', !isPublic),
                    const Spacer(),
                    IconButton(
                    icon: const Icon(Icons.group_add_rounded, color: Colors.orange),
                    onPressed: _showFriendInviteDialog,
                  ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('날짜', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _openDatePicker,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(formattedDate),
                        const Spacer(),
                        const Icon(Icons.calendar_today_outlined),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('시간', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _buildTimeSelector(),
                ),
                const SizedBox(height: 16),
                const Text('목표', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: _goalController,
                  maxLength: 28,
                  decoration: InputDecoration(
                    hintText: '세모토 우승하기!',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => _goalController.clear(),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    counterText: '',
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _showCreateConfirmDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFB74D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text('완료'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModeButton(String label, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isPublic = label == '공개';
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFFF0B2) : Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.orange : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

