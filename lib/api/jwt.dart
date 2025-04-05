import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Map<String, dynamic>> fetchAgoraToken(String channelName, int uid, String token) async {
  final url = Uri.parse('${dotenv.env['API_BASE_URL']}/agora/token?channel_name=$channelName&user_id=$uid');

  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to fetch Agora token');
  }
}