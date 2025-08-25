import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Color(0xffedf2f4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xff545454)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'About Us',
          style: TextStyle(
            fontSize: width * 0.05,
            fontWeight: FontWeight.bold,
            color: Color(0xff545454),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Logo and Title Section
            Center(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff545454).withAlpha(30),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/unity_volunteer_logo_noBackground.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    'Unity Volunteer',
                    style: TextStyle(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff545454),
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    'Unite. Volunteer. Impact.',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      color: Color(0xff545454).withAlpha(150),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.04),

            // Mission Section
            _buildSectionCard(
              context,
              title: 'Our Mission',
              content:
                  'Unity Volunteer is a community-driven platform designed to connect passionate individuals with meaningful volunteer opportunities. Our mission is to make volunteering accessible, engaging, and impactful for everyone.',
              icon: Icons.flag,
              width: width,
              height: height,
            ),

            SizedBox(height: height * 0.03),

            // What We Do Section
            _buildSectionCard(
              context,
              title: 'What We Do',
              content:
                  'We bridge the gap between volunteers and organizations, making it easy to discover, join, and track volunteer activities that create real impact in communities.',
              icon: Icons.work,
              width: width,
              height: height,
            ),

            SizedBox(height: height * 0.03),

            // Features Section
            _buildFeaturesSection(context, width, height),

            SizedBox(height: height * 0.03),

            // Values Section
            _buildValuesSection(context, width, height),

            SizedBox(height: height * 0.03),

            // Contact Section
            _buildContactSection(context, width, height),

            SizedBox(height: height * 0.04),

            // Version Info
            Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: width * 0.035,
                  color: Color(0xff545454).withAlpha(100),
                ),
              ),
            ),

            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required String content,
    required IconData icon,
    required double width,
    required double height,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(0xff545454).withAlpha(20),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xff545454).withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Color(0xff545454), size: 24),
              ),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff545454),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: width * 0.04,
              color: Color(0xff545454).withAlpha(180),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(
    BuildContext context,
    double width,
    double height,
  ) {
    final features = [
      {
        'icon': Icons.connect_without_contact,
        'title': 'Connect',
        'desc': 'Find volunteer opportunities near you',
      },
      {
        'icon': Icons.favorite,
        'title': 'Give',
        'desc': 'Contribute your time and skills',
      },
      {
        'icon': Icons.trending_up,
        'title': 'Grow',
        'desc': 'Develop new skills and experiences',
      },
      {
        'icon': Icons.support_agent,
        'title': 'Support',
        'desc': 'Help local organizations and causes',
      },
      {
        'icon': Icons.analytics,
        'title': 'Impact',
        'desc': 'Track your volunteer contributions',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(0xff545454).withAlpha(20),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xff545454).withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.star, color: Color(0xff545454), size: 24),
              ),
              SizedBox(width: 12),
              Text(
                'Key Features',
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff545454),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ...features
              .map(
                (feature) => Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xff545454).withAlpha(20),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          feature['icon'] as IconData,
                          color: Color(0xff545454),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              feature['title'] as String,
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff545454),
                              ),
                            ),
                            Text(
                              feature['desc'] as String,
                              style: TextStyle(
                                fontSize: width * 0.035,
                                color: Color(0xff545454).withAlpha(150),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildValuesSection(
    BuildContext context,
    double width,
    double height,
  ) {
    final values = [
      {
        'icon': Icons.people,
        'title': 'Unity',
        'desc': 'Bringing diverse people together',
      },
      {
        'icon': Icons.volunteer_activism,
        'title': 'Service',
        'desc': 'Promoting selfless contribution',
      },
      {
        'icon': Icons.track_changes,
        'title': 'Impact',
        'desc': 'Creating measurable positive change',
      },
      {
        'icon': Icons.accessibility,
        'title': 'Accessibility',
        'desc': 'Making volunteering easy for everyone',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(0xff545454).withAlpha(20),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xff545454).withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.favorite_border,
                  color: Color(0xff545454),
                  size: 24,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Our Values',
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff545454),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ...values
              .map(
                (value) => Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xff545454).withAlpha(20),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          value['icon'] as IconData,
                          color: Color(0xff545454),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value['title'] as String,
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff545454),
                              ),
                            ),
                            Text(
                              value['desc'] as String,
                              style: TextStyle(
                                fontSize: width * 0.035,
                                color: Color(0xff545454).withAlpha(150),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildContactSection(
    BuildContext context,
    double width,
    double height,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(0xff545454).withAlpha(20),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xff545454).withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.contact_support,
                  color: Color(0xff545454),
                  size: 24,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Get In Touch',
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff545454),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Join thousands of volunteers making a difference in their communities. Download the app, find opportunities that match your interests, and start making an impact today!',
            style: TextStyle(
              fontSize: width * 0.04,
              color: Color(0xff545454).withAlpha(180),
              height: 1.5,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildContactButton(
                  context,
                  icon: Icons.email,
                  label: 'Email Us',
                  onTap: () {
                    // Add email functionality
                  },
                  width: width,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildContactButton(
                  context,
                  icon: Icons.phone,
                  label: 'Call Us',
                  onTap: () {
                    // Add phone functionality
                  },
                  width: width,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required double width,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Color(0xff545454).withAlpha(30),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xff545454).withAlpha(50), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: Color(0xff545454), size: 24),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: width * 0.035,
                color: Color(0xff545454),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
