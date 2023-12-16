import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_chha/components/button.dart';

class BrowseRooms extends StatefulWidget {
  const BrowseRooms({super.key});

  @override
  State<BrowseRooms> createState() => _BrowseRoomsState();
}

class _BrowseRoomsState extends State<BrowseRooms> {
  //function to get email and name of user
  String userreqName = ''; // Declare these variables at a higher scope
  String userreqEmail = '';

  Future<void> fetchUserData() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('user')
              .where("uid", isEqualTo: useriid) // Use the actual useriid
              .get();

      // Check if any documents were found
      if (querySnapshot.docs.isNotEmpty) {
        final userData =
            querySnapshot.docs[0].data(); // Assuming only one document

        userreqName = userData['userName'] ?? '';
        userreqEmail = userData['userEmail'] ?? '';

        // Add user to chat here (use userreqName and userreqEmail)

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User added for chat'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User not found'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

//requerid user id to have querry
  var userreq;

  var useriid;

  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Rooms'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Rooms").snapshots(),
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

                if (snapshot.data != null) {
                  final data = snapshot.data!.docs;

                  log('Data:${jsonEncode(data[0].data())}');
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        var Discription =
                            snapshot.data!.docs[index]['Discription'];
                        var roomPrice =
                            snapshot.data!.docs[index]['Room Price'];
                        var roomLocation =
                            snapshot.data!.docs[index]['Room Location'];
                        var Image1 = snapshot.data!.docs[index]['Image1'];
                        var Image2 = snapshot.data!.docs[index]['Image2'];
                        var totalRoom =
                            snapshot.data!.docs[index]['Total Room'];
                        useriid = snapshot.data!.docs[index]['userId'];

                        return Card(
                            //     child: ListTile(
                            //   title: Text(Discription),
                            //   subtitle: Text(Room_Location),
                            // ),
                            child: Column(
                          children: [
                            SizedBox(
                              height: 300,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  SizedBox(
                                    height: 300,
                                    width: 250,
                                    child: Image.network(
                                      Image1,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  SizedBox(
                                    height: 300,
                                    width: 250,
                                    child: Image.network(
                                      Image2,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text('Room Location $roomLocation')),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text('Rent:$roomPrice')),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text('Total Room:$totalRoom')),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text('Discription:$Discription')),
                            const SizedBox(
                              height: 10,
                            ),
                            ButtonB(
                                nameofbutton: 'Add user for chat',
                                ontap: () async {
                                  await fetchUserData();
                                  //feature for add peopele for chat

                                  try {
                                    FirebaseFirestore.instance
                                        .collection('chatuser')
                                        .doc()
                                        .set({
                                      "friend_uid": useriid,
                                      "name": userreqName,
                                      "Email": userreqEmail,
                                      "userId": userId!.uid,
                                    }).then(
                                      (value) => SnackBar(
                                        content: Text('useradded'),
                                        duration: Duration(
                                            seconds:
                                                3), // Adjust the duration as needed
                                      ),
                                    );
                                  } catch (e) {
                                    print("$e error occured over here ");
                                  }

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => Messenger(

                                  //             )));
                                },
                                colorofbutton: Colors.blueAccent,
                                heightofbutton: 30,
                                widthofbutton: double.infinity),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ));
                      }));
                }
                return (Container());
              })),
        ),
      ),
    );
  }
}
