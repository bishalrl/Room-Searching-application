import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_chha/add_room/addroom.dart';
import 'package:room_chha/components/drawer.dart';
import 'package:room_chha/destination/bhaktapur.dart';
import 'package:room_chha/destination/butwal.dart';
import 'package:room_chha/destination/kathmandu.dart';
import 'package:room_chha/destination/pokhara.dart';
import 'package:room_chha/homepage/broweroom.dart';

import 'package:room_chha/personalpage/profilepage.dart';
import 'package:room_chha/signup/signup.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddRooms()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          'Home Rental App',
          style: TextStyle(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              if (user == null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupScreen()));
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ProfilePage(), // Replace with your profile page widged
                  ),
                );
              }
              // Action to navigate to profile page
            },
          ),
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(16.0), children: [
        const SearchBar(),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Explore Available Homes',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 200.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              // Replace this with your home card widget
              return GestureDetector(
                onTap: () {},
                child: Container(
                  width: 150.0,
                  margin: const EdgeInsets.only(right: 16.0),
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Home ${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            // Action to browse more homes
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const BrowseRooms(), // Replace with the screen that displays more homes
              ),
            );
          },
          child: const Text('Browse All Homes'),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'Popular Destinations',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                height: 180,
                width: 180,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Kathmandu()));
                  },
                  child: Container(
                    color: Colors.green,
                    child: const Center(
                      child: Text(
                        'Kathmandu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              SizedBox(
                height: 180,
                width: 180,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Pokhara()));
                  },
                  child: Container(
                    color: Colors.green,
                    child: const Center(
                      child: Text(
                        'Pokhara',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                height: 180,
                width: 180,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Butwal()));
                  },
                  child: Container(
                    color: Colors.green,
                    child: const Center(
                      child: Text(
                        'Butwal',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              SizedBox(
                height: 180,
                width: 180,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Bhaktapur()));
                  },
                  child: Container(
                    color: Colors.green,
                    child: const Center(
                      child: Text(
                        'Bhaktapur',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
      drawer: MainDrawer(),
    );
  }
}

class BrowseHomesScreen extends StatelessWidget {
  const BrowseHomesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Implement the screen that displays more homes
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse All Homes'),
      ),
      body: const Center(
        child: Text('More Homes'),
      ),
    );
  }
}
