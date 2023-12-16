import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_chha/chatandmessages_room/chatscreen.dart';
import 'package:room_chha/login/loginpage.dart';
import 'package:room_chha/map/map.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Bishal Aryal'),
              accountEmail: Text('aryalbishal9876@gmail.com'),
            ),
            InkWell(
              child: const ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
              ),
              onTap: () {},
            ),
            InkWell(
              child: const ListTile(
                leading: Icon(Icons.map),
                title: Text("Map"),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapPage()));
              },
            ),
            Divider(),
            InkWell(
              child: const ListTile(
                leading: Icon(Icons.settings),
                title: Text("Setting"),
              ),
              onTap: () {},
            ),
            InkWell(
              child: const ListTile(
                leading: Icon(Icons.chat),
                title: Text("chat"),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatMainScreen()));
              },
            ),
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreem()));
                },
                icon: const Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
