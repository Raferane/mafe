import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:unity_project/Views/Bottom_screens/Favorites/favorites_screen.dart';
import 'package:unity_project/Views/Bottom_screens/profile/profile_screen.dart';
import 'package:unity_project/Views/Bottom_screens/search/search_screen.dart';
import 'package:unity_project/models/services/app_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Current selected index for bottom navigation
  int _currentIndex = 0;

  // List of your asset images for carousel
  final List<String> carouselImages = [
    'assets/connect_carousel_slider.png',
    'assets/give_carousel_slider.png',
    'assets/grow_carousel_slider.png',
    'assets/support_carousel_slider.png',
    'assets/impact_carousel_slider.png',
  ];

  // Add this variable to track carousel position
  int _currentCarouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffedf2f4),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff545454).withAlpha(200),
              ),
              child: Text(
                'Unite.Volunteer. Impact.',
                style: TextStyle(
                  color: Color(0xffedf2f4),
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            SizedBox(height: height * 0.03),
            // Add more ListTiles as needed
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: height * 0.03),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: height * 0.03),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: height * 0.15),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                GoogleSignIn().signOut();
                Get.find<AppService>().clearUser();
                Get.offAllNamed('/welcome');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Unity Volunteer',
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.bold,
                color: Color(0xff545454),
              ),
            ),
            SizedBox(width: 6),
            Image.asset(
              'assets/unity_volunteer_logo_noBackground.png',
              width: 30,
              height: 30,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,

        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.02,
            ),
            child: Column(
              children: [
                // Title and Logo Row
                SizedBox(height: height * 0.02),
                // Search Field
                Container(
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xffedf2f4),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff545454).withAlpha(50),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                      hintText: 'Search for events, activities...',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey[400],
                        size: 24,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                    onChanged: (value) {
                      // Handle search functionality
                      print('Searching for: $value');
                    },
                  ),
                ),

                SizedBox(height: 20),

                // Carousel Slider
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.9,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentCarouselIndex = index;
                        });
                      },
                    ),
                    items:
                        carouselImages.map((String imagePath) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(20),
                                      blurRadius: 10,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                  ),
                ),

                // Carousel Indicator
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      carouselImages.asMap().entries.map((entry) {
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                _currentCarouselIndex == entry.key
                                    ? Color(0xff545454) // Active indicator
                                    : Colors.grey[400], // Inactive indicator
                          ),
                        );
                      }).toList(),
                ),
              ],
            ),
          ),
          SearchScreen(),
          FavoritesScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: Color(0xffedf2f4),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          // Handle navigation based on index
          switch (index) {
            case 0: // Home
              print('Home tab tapped');

              break;
            case 1: // Search
              print('Search tab tapped');

              break;
            case 2: // Favorites
              print('Favorites tab tapped');

              break;
            case 3: // Profile
              print('Profile tab tapped');

              break;
          }
        },
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Color(0xff545454).withAlpha(170),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
            selectedColor: Color(0xff545454).withAlpha(170),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.favorite),
            title: Text("Favorites"),
            selectedColor: Colors.pink,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: Color(0xff545454).withAlpha(170),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
