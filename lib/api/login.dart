import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> handleLogin({
  required BuildContext context,
  required String username,
  required String password,
}) async {
  // const backendUrl = 'http://127.0.0.1:8000';
  const backendUrl = 'https://port-0-back-morning-m94ntlcqbc256101.sel4.cloudtype.app/';

  try {
    final response = await http.post(
      Uri.parse('${backendUrl}token'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['access_token'];
      
      // 👉 토큰 저장
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setString('access_token', token);

      Navigator.pushReplacementNamed(context, '/home');
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('로그인 실패'),
          content: Text('아이디 또는 비밀번호가 잘못되었습니다.'),
        ),
      );
    }
  } catch (e) {
    print('로그인 요청 실패: $e');
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text('오류'),
        content: Text('서버에 연결할 수 없습니다.'),
      ),
    );
  }
}
