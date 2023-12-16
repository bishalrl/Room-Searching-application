import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("User").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return (const Text("Something went wrong"));
            }
            if (snapshot.data!.docs.isEmpty) {
              return (const Text("No data found"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(radius: 20),
              );
            }
            if (snapshot.hasData) {
              return Container(
                child: const CircleAvatar(),
              );
            }
            return Container();
          }),
    );
  }
}
