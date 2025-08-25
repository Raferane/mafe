import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffedf2f4), Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                // Header
                _buildHeader(width, height),

                SizedBox(height: 40),

                // Quick Actions
                _buildQuickActions(width, height),

                SizedBox(height: 30),
                AnimatedPadding(
                  padding: EdgeInsets.only(bottom: 20),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  // Contact Form
                  child: _buildContactForm(width, height),
                ),

                SizedBox(height: 30),

                // Info Section
                _buildInfoSection(width, height),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double width, double height) {
    return Column(
      children: [
        // Back Button
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffedf2f4),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(0),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Color(0xff545454)),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),

        SizedBox(height: 30),

        // Title Section
        Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                blurRadius: 20,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff545454).withAlpha(10),
                      Color(0xff545454).withAlpha(5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.contact_support,
                  size: 50,
                  color: Color(0xff545454),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Get in Touch',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff545454),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We\'re here to help you',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff545454).withAlpha(70),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Contact',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff545454),
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.email,
                title: 'Email',
                color: Colors.blue,
                onTap: () {},
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: _buildActionCard(
                icon: Icons.phone,
                title: 'Call',
                color: Colors.green,
                onTap: () {},
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.chat,
                title: 'Chat',
                color: Colors.orange,
                onTap: () {},
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: _buildActionCard(
                icon: Icons.help,
                title: 'FAQ',
                color: Colors.purple,
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withAlpha(20), color.withAlpha(10)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff545454),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm(double width, double height) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 20,
            offset: Offset(0, 5),
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
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff545454).withAlpha(20),
                      Color(0xff545454).withAlpha(10),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.message, color: Color(0xff545454), size: 24),
              ),
              SizedBox(width: 12),
              Text(
                'Send Message',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff545454),
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(
                  controller: _nameController,
                  label: 'Your Name',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                _buildTextField(
                  controller: _emailController,
                  label: 'Email Address',
                  icon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                _buildTextField(
                  controller: _messageController,
                  label: 'Message',
                  icon: Icons.edit,
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your message';
                    }
                    if (value.length < 10) {
                      return 'Message must be at least 10 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff545454),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Send Message',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      scrollPadding: EdgeInsets.only(bottom: 20),
      controller: controller,
      maxLines: maxLines,

      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xff545454).withAlpha(60)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xff545454).withAlpha(20)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xff545454).withAlpha(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xff545454)),
        ),
        filled: true,
        fillColor: Color(0xff545454).withAlpha(5),
      ),
      validator: validator,
    );
  }

  Widget _buildInfoSection(double width, double height) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 20,
            offset: Offset(0, 5),
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
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff545454).withAlpha(20),
                      Color(0xff545454).withAlpha(10),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.info, color: Color(0xff545454), size: 24),
              ),
              SizedBox(width: 12),
              Text(
                'Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff545454),
                ),
              ),
            ],
          ),
          SizedBox(height: 25),

          // Business Hours
          _buildInfoRow('Business Hours', 'Mon-Fri: 9 AM - 6 PM'),
          _buildInfoRow('Response Time', 'Within 24 hours'),
          _buildInfoRow('Support Email', 'support@unityvolunteer.com'),

          SizedBox(height: 25),

          // Social Media
          Text(
            'Follow Us',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff545454),
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSocialButton(Icons.facebook, Colors.blue, ""),
              _buildSocialButton(Icons.flutter_dash, Colors.lightBlue, ""),
              _buildSocialButton(Icons.camera_alt, Colors.purple, ""),
              _buildSocialButton(Icons.work, Colors.blue[700]!, ""),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff545454),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff545454).withAlpha(70),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, Color color, String url) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withAlpha(20), color.withAlpha(10)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }

  // Helper methods

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Get.snackbar(
        'Message Sent!',
        'Thank you for contacting us. We\'ll get back to you soon!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withAlpha(10),
        colorText: Color(0xff545454),
      );

      // Clear form
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
