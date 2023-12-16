import 'package:flutter/material.dart';
import 'package:room_chha/personalpage/Profiledata.dart';
import 'package:room_chha/personalpage/personal.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Column(
          children: [
            Container(
              height: 150,
              child: PersonalPage(),
            ),
            Card(
              elevation: 4,
              child: Container(
                height: 1,
                color: const Color.fromARGB(255, 235, 117, 117),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "User Content",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Card(
              elevation: 4,
              child: Container(
                height: 1,
                color: const Color.fromARGB(255, 235, 117, 117),
              ),
            ),
            Container(
              height: 600,
              child: ListRoom(),
            )
          ],
        )

        // body: ListView(children: [
        //   PersonalPage(),
        //   Card(
        //     elevation: 4,
        //     child: Container(
        //       height: 1,
        //       color: const Color.fromARGB(255, 235, 117, 117),
        //     ),
        //   ),
        //   const SizedBox(height: 10),
        //   const Text(
        //     "User Content",
        //     textAlign: TextAlign.center,
        //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //   ),
        //   Card(
        //     elevation: 4,
        //     child: Container(
        //       height: 1,
        //       color: const Color.fromARGB(255, 235, 117, 117),
        //     ),
        //   ),
        // ]),
        );
  }
}
