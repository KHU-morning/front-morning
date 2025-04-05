import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

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
      _idController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          '로그인',
          style: TextStyle(
            color: const Color(0xFF171717),
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
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      buildTextField('휴대폰 번호', _phoneController, '휴대폰 번호를 입력해주세요.', TextInputType.phone),
                      const SizedBox(height: 16),
                      buildTextField('학과', _departmentController, '소속 학과를 입력해주세요.'),
                      const SizedBox(height: 16),
                      buildTextField('학번', _studentIdController, '학번을 입력해주세요.', TextInputType.number),
                      const SizedBox(height: 16),
                      buildTextField('이름', _nameController, '이름을 입력해주세요.'),
                      const SizedBox(height: 16),
                      buildTextField('아이디', _idController, '아이디를 입력해주세요.'),
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
                      onPressed: _isFormValid
                          ? () async {
                              final response = await http.post(
                                Uri.parse('http://127.0.0.1:8000/token'),
                                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                                body: {
                                  'username': _idController.text,
                                  'password': _nameController.text,
                                },
                              );

                              if (response.statusCode == 200) {
                                final token = jsonDecode(response.body)['access_token'];
                                print('로그인 성공! 토큰: $token');
                                Navigator.pushReplacementNamed(context, '/home');
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('로그인 실패'),
                                    content: const Text('아이디 또는 이름(비밀번호)이 잘못되었습니다.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('확인'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFBC15B),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey[300],
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(200),
                        ),
                      ),
                      child: const Text(
                        '로그인',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.grey),
                      child: const Text(
                        '회원가입',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, String hint, [TextInputType type = TextInputType.text]) {
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
}
