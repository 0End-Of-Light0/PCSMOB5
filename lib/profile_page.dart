import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/user_avatar.png'),
            ),
            SizedBox(height: 16),
            Text('Test User', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('tsur@example.com', style: TextStyle(fontSize: 16, color: Colors.grey)),
            Text('+123 456 7890', style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
