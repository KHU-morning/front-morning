import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _collegeController = TextEditingController();
  final _departmentController = TextEditingController();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  bool _isCollegeDropdownOpen = false;
  bool _isDepartmentDropdownOpen = false;
  bool _isIdChecked = false;

  bool get _isFormValid => 
    _collegeController.text.isNotEmpty &&
    _departmentController.text.isNotEmpty &&
    _nameController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _collegeController.addListener(_onFieldChanged);
    _departmentController.addListener(_onFieldChanged);
    _nameController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _collegeController.removeListener(_onFieldChanged);
    _departmentController.removeListener(_onFieldChanged);
    _nameController.removeListener(_onFieldChanged);
    _collegeController.dispose();
    _departmentController.dispose();
    _nameController.dispose();
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('회원가입'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('단과대학'),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _collegeController,
                            readOnly: true,
                            style: TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                                hintText: '소속 단과대학을 선택해주세요',
                                hintStyle: TextStyle(color: Colors.grey[600], fontSize: 11.5),
                              isDense: true,
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffix: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                visualDensity: VisualDensity.compact,
                                onPressed: () {
                                  setState(() {
                                    _isCollegeDropdownOpen = !_isCollegeDropdownOpen;
                                  });
                                },
                                icon: Transform.rotate(
                                  angle: _isCollegeDropdownOpen ? 0 : 3.14159,
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_isCollegeDropdownOpen) ...[
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text('공과대학'),
                                onTap: () {
                                  setState(() {
                                    _collegeController.text = '공과대학';
                                    _isCollegeDropdownOpen = false;
                                  });
                                },
                              ),
                              ListTile(
                                title: Text('자연과학대학'),
                                onTap: () {
                                  setState(() {
                                    _collegeController.text = '자연과학대학';
                                    _isCollegeDropdownOpen = false;
                                  });
                                },
                              ),
                              ListTile(
                                title: Text('인문대학'),
                                onTap: () {
                                  setState(() {
                                    _collegeController.text = '인문대학';
                                    _isCollegeDropdownOpen = false;
                                  });
                                },
                              ),
                              ListTile(
                                title: Text('사회과학대학'),
                                onTap: () {
                                  setState(() {
                                    _collegeController.text = '사회과학대학';
                                    _isCollegeDropdownOpen = false;
                                  });
                                },
                              ),
                              ListTile(
                                title: Text('경영대학'),
                                onTap: () {
                                  setState(() {
                                    _collegeController.text = '경영대학';
                                    _isCollegeDropdownOpen = false;
                                  });
                                },
                              ),
                              ListTile(
                                title: Text('예술체육대학'),
                                onTap: () {
                                  setState(() {
                                    _collegeController.text = '예술체육대학';
                                    _isCollegeDropdownOpen = false;
                                  });
                                },
                              ),
                              ListTile(
                                title: Text('의과대학'),
                                onTap: () {
                                  setState(() {
                                    _collegeController.text = '의과대학';
                                    _isCollegeDropdownOpen = false;
                                  });
                                },
                              ),
                              ListTile(
                                title: Text('치과대학'),
                                onTap: () {
                                  setState(() {
                                    _collegeController.text = '치과대학';
                                    _isCollegeDropdownOpen = false;
                                  });
                                },
                              ),
                              ListTile(
                                title: Text('한의과대학'),
                                onTap: () {
                                  setState(() {
                                    _collegeController.text = '한의과대학';
                                    _isCollegeDropdownOpen = false;
                                  });
                                },
                              ),
                              ListTile(
                                title: Text('약학대학'),
                                onTap: () {
                                  setState(() {
                                    _collegeController.text = '약학대학';
                                    _isCollegeDropdownOpen = false;
                                  });
                                },
                              ),
                              ListTile(
                                title: Text('간호대학'),
                                onTap: () {
                                  setState(() {
                                    _collegeController.text = '간호대학';
                                    _isCollegeDropdownOpen = false;
                                  });
                                },
                              ),
                              ListTile(
                                title: Text('교육대학'),
                                onTap: () {
                                  setState(() {
                                    _collegeController.text = '교육대학';
                                    _isCollegeDropdownOpen = false;
                                  });
                                },
                              ),
                              ListTile(
                                title: Text('융합공학대학'),
                                onTap: () {
                                  setState(() {
                                    _collegeController.text = '융합공학대학';
                                    _isCollegeDropdownOpen = false;
                                  });
                                },
                              ),
                              ListTile(
                                title: Text('소프트웨어융합대학'),
                                onTap: () {
                                  setState(() {
                                    _collegeController.text = '소프트웨어융합대학';
                                    _isCollegeDropdownOpen = false;
                                  });
                                },
                              ),
                              ListTile(
                                title: Text('자유전공학부'),
                                onTap: () {
                                  setState(() {
                                    _collegeController.text = '자유전공학부';
                                    _isCollegeDropdownOpen = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('학과'),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _departmentController,
                            readOnly: true,
                            style: TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              hintText: '소속 학과를 선택해주세요',
                              hintStyle: TextStyle(color: Colors.grey[600], fontSize: 11.5),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffix: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                visualDensity: VisualDensity.compact,
                                onPressed: () {
                                  setState(() {
                                    _isDepartmentDropdownOpen = !_isDepartmentDropdownOpen;
                                  });
                                },
                                icon: Transform.rotate(
                                  angle: _isDepartmentDropdownOpen ? 0 : 3.14159,
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_isDepartmentDropdownOpen) ...[
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text('컴퓨터공학과'),
                                onTap: () {
                                  setState(() {
                                    _departmentController.text = '컴퓨터공학과';
                                    _isDepartmentDropdownOpen = false;
                                  });
                                },
                              ),
                              ListTile(
                                title: Text('전자공학과'),
                                onTap: () {
                                  setState(() {
                                    _departmentController.text = '전자공학과';
                                    _isDepartmentDropdownOpen = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('이름'),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _nameController,
                            style: TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              hintText: '이름을 입력해주세요',
                              hintStyle: TextStyle(color: Color(0xFFB6B6B6), fontSize: 11.5),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                              filled: true,
                              fillColor: Color(0xFFEEEEEE),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              suffix: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                visualDensity: VisualDensity.compact,
                                onPressed: () {
                                  _nameController.clear();
                                },
                                icon: Icon(Icons.cancel, size: 18, color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('아이디'),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _idController,
                            style: TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              hintText: '아이디를 입력해주세요',
                              hintStyle: TextStyle(color: Color(0xFFB6B6B6), fontSize: 11.5),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                              filled: true,
                              fillColor: Color(0xFFEEEEEE),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              suffix: Container(
                                margin: EdgeInsets.zero,
                                child: _isIdChecked
                                  ? Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFB0B0B0),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Center(
                                        child: Icon(Icons.check_circle, size: 18, color: Colors.white),
                                      ),
                                    )
                                  : ElevatedButton(
                                      onPressed: null,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFB0B0B0),
                                        foregroundColor: Colors.white,
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                      child: Text(
                                        '중복확인',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
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
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: Offset(0, -2),
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
                        // TODO: Implement registration logic
                        Navigator.pushReplacementNamed(context, '/home');
                      } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isFormValid ? Color(0xFFB0B0B0) : Color(0xFFEEEEEE),
                        foregroundColor: _isFormValid ? Colors.black : Color(0xFFB6B6B6),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: BorderSide.none,
                        ),
                      ),
                      child: const Text('가입하기'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('이미 계정이 있으신가요? 로그인'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 