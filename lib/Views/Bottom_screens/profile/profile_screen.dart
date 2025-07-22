import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 32),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(5),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundImage: AssetImage(
                        'assets/unity_volunteer_logo_noBackground.png',
                      ), // Placeholder
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.green,
                        child: Icon(Icons.edit, size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'John Doe',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'john@example.com',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 24),
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(label: Text('Top Volunteer')),
                    Chip(label: Text('10+ Events')),
                    // ...more badges
                  ],
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Stats',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStat('Events', '12'),
                    _buildStat('Hours', '34'),
                    _buildStat('Badges', '3'),
                  ],
                ),
                SizedBox(height: 24),
                ElevatedButton(onPressed: () {}, child: Text('Edit Profile')),
                SizedBox(height: 24),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {},
                ),
                SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.delete_outline),
                  title: Text('Delete Account'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
