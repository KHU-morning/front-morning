import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Map<String, dynamic>>> fetchMorningRoomList() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  const backendUrl = 'https://port-0-back-morning-m94ntlcqbc256101.sel4.cloudtype.app/';

  if (token == null) {
    throw Exception('토큰이 없습니다.');
  }

  final response = await http.get(
    Uri.parse('${backendUrl}rooms'),
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
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  const backendUrl = 'https://port-0-back-morning-m94ntlcqbc256101.sel4.cloudtype.app/';

  if (token == null) {
    throw Exception('토큰이 없습니다.');
  }

  final response = await http.get(
    Uri.parse('${backendUrl}rooms/$roomId'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(utf8.decode(response.bodyBytes));
  } else {
    throw Exception('모닝방 정보를 불러오지 못했습니다.');
  }
}

