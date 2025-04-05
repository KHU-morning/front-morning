import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Map<String, dynamic>>> fetchMorningRoomList() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');

  if (token == null) {
    throw Exception('토큰이 없습니다.');
  }

  final response = await http.get(
    Uri.parse('http://127.0.0.1:8000/rooms'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('모닝방 리스트 불러오기 실패: ${response.statusCode}');
  }
}

Future<Map<String, dynamic>> fetchRoomDetail(String roomId) async {
  final response = await http.get(Uri.parse('http://localhost:8000/rooms/$roomId'));

  if (response.statusCode == 200) {
    return jsonDecode(utf8.decode(response.bodyBytes));
  } else {
    throw Exception('모닝방 정보를 불러오지 못했습니다.');
  }
}

