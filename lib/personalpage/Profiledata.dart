import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListRoom extends StatefulWidget {
  const ListRoom({super.key});

  @override
  State<ListRoom> createState() => _ListRoomState();
}

class _ListRoomState extends State<ListRoom> {
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Rooms")
            .where("userId", isEqualTo: userId!.uid)
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

          if (snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  var Discription = snapshot.data!.docs[index]['Discription'];
                  var roomPrice = snapshot.data!.docs[index]['Room Price'];
                  var roomLocation =
                      snapshot.data!.docs[index]['Room Location'];
                  var Image1 = snapshot.data!.docs[index]['Image1'];
                  var Image2 = snapshot.data!.docs[index]['Image2'];
                  var totalRoom = snapshot.data!.docs[index]['Total Room'];

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
                      Text('Room Location $roomLocation'),
                      Text('Rent:$roomPrice'),
                      Text('Total Room:$totalRoom'),
                      Text("Discription:$Discription"),
                    ],
                  ));
                }));
          }
          return (Container());
        }));
   
  }
}
