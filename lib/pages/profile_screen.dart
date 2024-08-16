import 'package:flutter/material.dart';

import '../utils/custom_storage.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Logout"),
            trailing: Icon(Icons.logout),
            iconColor: Colors.red,
            tileColor: Colors.grey.withOpacity(0.1),
            onTap: () async {
              await deleteTokenAccess();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
