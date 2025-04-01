import 'package:flutter/material.dart';

class MorningRoomPage extends StatelessWidget {
  const MorningRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('모닝방'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 5, // 임시 데이터 개수
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.people, color: Colors.white),
              ),
              title: Text('모닝방 ${index + 1}'),
              subtitle: const Text('함께 아침을 맞이해요!'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // TODO: Implement morning room detail view
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement create new morning room
        },
        child: const Icon(Icons.add),
      ),
    );
  }
} 