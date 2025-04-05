import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Map<String, dynamic>>> fetchWakeRequests() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  const backendUrl = 'http://172.21.2.130:8000';

  if (token == null) {
    throw Exception("로그인 토큰이 없습니다.");
  }

  final response = await http.get(
    Uri.parse('http://172.21.2.130:8000/wake-requests'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception("모닝콜 요청 정보를 불러오지 못했습니다.");
  }
}
