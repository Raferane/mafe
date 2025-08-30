import 'package:flutter/material.dart';
import 'package:unity_project/Views/Admin_panel/admin_components/admin_tab_bar_view.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xffedf2f4),
        appBar: AppBar(
          backgroundColor: Color(0xffedf2f4),
          surfaceTintColor: Color(0xffedf2f4),
          elevation: 0,

          title: Text(
            'Admin Panel',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.grey[800],
            unselectedLabelColor: Colors.grey[500],
            indicatorColor: Color(0xff545454),
            tabs: [
              Tab(icon: Icon(Icons.people), text: 'Users'),
              Tab(icon: Icon(Icons.event), text: 'Events'),
            ],
          ),
        ),
        body: FutureBuilder(
          future: Future.delayed(Duration(seconds: 1)),
          builder: (context, asyncSnapshot) {
            return AdminTabBarView();
          },
        ),
      ),
    );
  }
}
