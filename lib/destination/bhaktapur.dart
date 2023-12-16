import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/button.dart';

class Bhaktapur extends StatefulWidget {
  const Bhaktapur({super.key});

  @override
  State<Bhaktapur> createState() => _BhaktapurState();
}

class _BhaktapurState extends State<Bhaktapur> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bhaktapur"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Rooms")
                  .where("Room Location", isEqualTo: 'bhaktapur')
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
                                nameofbutton: 'Send Message',
                                ontap: () {},
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
