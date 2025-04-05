import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  bool? _isIdAvailable;
  String? _idErrorMessage;

  @override
  void dispose() {
    _phoneController.dispose();
    _departmentController.dispose();
    _studentIdController.dispose();
    _nameController.dispose();
    _idController.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _phoneController.text.isNotEmpty &&
      _departmentController.text.isNotEmpty &&
      _studentIdController.text.isNotEmpty &&
      _nameController.text.isNotEmpty &&
      _idController.text.isNotEmpty &&
      _isIdAvailable == true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '회원가입',
          style: TextStyle(
            color: Color(0xFF171717),
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 1.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      _buildInputField('휴대폰 번호', '휴대폰 번호를 입력해주세요', _phoneController, TextInputType.phone),
                      const SizedBox(height: 16),
                      _buildInputField('학과', '소속 학과를 입력해주세요', _departmentController),
                      const SizedBox(height: 16),
                      _buildInputField('학번', '학번을 입력해주세요', _studentIdController, TextInputType.number),
                      const SizedBox(height: 16),
                      _buildInputField('이름', '이름을 입력해주세요', _nameController),
                      const SizedBox(height: 16),
                      _buildInputFieldWithButton('아이디', '아이디를 입력해주세요', _idController),
                      if (_idErrorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            _idErrorMessage!,
                            style: const TextStyle(fontSize: 12, color: Color(0xFFFF6262)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isFormValid ? () {
                        Navigator.pushReplacementNamed(context, '/morning_call');
                      } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC84E),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey[300],
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      child: const Text(
                        '가입하기',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        '이미 계정이 있으신가요? 로그인',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, TextEditingController controller, [TextInputType type = TextInputType.text]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 13, color: Color.fromRGBO(182, 182, 182, 1)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            fillColor: const Color.fromRGBO(238, 238, 238, 1),
            filled: true,
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, size: 18),
                    onPressed: () {
                      setState(() {
                        controller.clear();
                      });
                    },
                  )
                : null,
          ),
          onChanged: (value) => setState(() {}),
        ),
      ],
    );
  }

  Widget _buildInputFieldWithButton(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                hintText: hint,
                hintStyle: const TextStyle(fontSize: 13, color: Color.fromRGBO(182, 182, 182, 1)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                fillColor: const Color.fromRGBO(238, 238, 238, 1),
                filled: true,
              ),
              onChanged: (value) => setState(() {
                _isIdAvailable = null;
                _idErrorMessage = null;
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: _isIdAvailable == true
                  ? Container(
                      height: 40,
                      width: 68,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC84E),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 20),
                    )
                  : Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC84E),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                          minimumSize: Size.zero,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_idController.text == "taken") {
                              _isIdAvailable = false;
                              _idErrorMessage = "사용할 수 없는 아이디입니다";
                            } else {
                              _isIdAvailable = true;
                              _idErrorMessage = null;
                            }
                          });
                        },
                        child: const Text(
                          '중복확인',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ),
                    ),
            )
          ],
        )
      ],
    );
  }
}