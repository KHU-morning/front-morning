import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> createWakeRequest({
  required String wakeDate,
  required String wakeTime,
  required String reason,
  required bool isPublic,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  const backendUrl = 'https://port-0-back-morning-m94ntlcqbc256101.sel4.cloudtype.app/';

  if (token == null) return false;

  final response = await http.post(
    Uri.parse('$backendUrl/wake-requests'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'wake_date': wakeDate,
      'wake_time': wakeTime,
      'reason': reason,
      'is_public': isPublic,
    }),
  );
  print(response.body);

  return response.statusCode == 200;
}
