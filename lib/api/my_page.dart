import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> fetchMyProfile() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  const backendUrl = 'https://port-0-back-morning-m94ntlcqbc256101.sel4.cloudtype.app/';

  final response = await http.get(
    Uri.parse('${backendUrl}me'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    return jsonDecode(utf8.decode(response.bodyBytes));
  } else {
    throw Exception('마이페이지 정보 가져오기 실패');
  }
}

Future<List<Map<String, dynamic>>> fetchMyWakeSummary() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  const backendUrl = 'https://port-0-back-morning-m94ntlcqbc256101.sel4.cloudtype.app/';

  final response = await http.get(
    Uri.parse('${backendUrl}me/wake-records'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('기상 기록 가져오기 실패');
  }
}
