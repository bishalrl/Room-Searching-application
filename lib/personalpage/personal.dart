import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("user")
            .where("uid", isEqualTo: userId!.uid)
            .snapshots(),
        builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return (const Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            return (const Text('No data found'));
          }

          // ignore: unnecessary_null_comparison
          if (snapshot != null && snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  var note = snapshot.data!.docs[index]['userName'];
                  var occupation = snapshot.data!.docs[index]['userOccupation'];
                  var phone = snapshot.data!.docs[index]['userPhone'];
                  return Card(
                    elevation: 7,
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        Text(
                          'Name: $note',
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Occupation: $occupation',
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Phone no: $phone',
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                }));
          }
          return Container();
        }),
      ),
    );
  }
}
