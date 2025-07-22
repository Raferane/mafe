import 'package:flutter/material.dart';

class AdminTabBarView extends StatelessWidget {
  const AdminTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        // Users Tab
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green[100],
                    child: Icon(Icons.person, color: Colors.green[700]),
                  ),
                  title: Text('John Doe'),
                  subtitle: Text('john@example.com'),
                  trailing: TextButton.icon(
                    icon: Icon(Icons.block, color: Colors.red[400]),
                    label: Text(
                      'Ban',
                      style: TextStyle(color: Colors.red[400]),
                    ),
                    onPressed: () {
                      // Ban logic here
                    },
                  ),
                  children: [
                    ListTile(
                      title: Text('Created At: 2024-07-01'),
                      // Add more info here
                    ),
                    // Add ban/unban buttons or other actions here
                  ],
                ),
              ),
              // ... more user cards
            ],
          ),
        ),
        // Events Tab
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: ListTile(
                      leading: Icon(Icons.event, color: Colors.green[700]),
                      title: Text('Beach Cleanup'),
                      subtitle: Text('2024-07-01'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red[400]),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  // ... more event cards
                ],
              ),
            ),
            Positioned(
              bottom: 24,
              right: 24,
              child: FloatingActionButton(
                backgroundColor: Colors.green[700],
                onPressed: () {
                  // Show add event dialog
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
