import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:room_chha/components/button.dart';
import 'package:room_chha/homepage/HomeScree.dart';

import '../components/Textfield.dart';

class AddRooms extends StatefulWidget {
  const AddRooms({super.key});

  @override
  State<AddRooms> createState() => _AddRoomsState();
}

class _AddRoomsState extends State<AddRooms> {
  final TextEditingController _priceController =
      TextEditingController(text: '');
  final TextEditingController _roomcontroller = TextEditingController(text: '');
  final TextEditingController _locationcontroller =
      TextEditingController(text: '');
  final TextEditingController _discriptioncontroller =
      TextEditingController(text: '');
  final picker = ImagePicker();
  File? _image1;
  File? _image2;
  File? _image3;
  String? url1;
  String? url2;
  String? url3;

  Future imagepicker() async {
    try {
      final pick = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        _image1 = File(pick!.path);
      });
    } catch (e) {
      print('$e error');
    }
    return _image1;
  }

  Future imagepicker1() async {
    try {
      final pick = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        _image2 = File(pick!.path);
      });
    } catch (e) {
      print('$e error');
    }
    return _image2;
  }

  Future imagepicker2() async {
    try {
      final pick = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        _image3 = File(pick!.path);
      });
    } catch (e) {
      print('$e error');
    }
    return _image3;
  }

  uploadImage1(File image1) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('images of rooms')
        .child('${DateTime.now()}');
    await reference.putFile(image1);
    url1 = await reference.getDownloadURL();
    return url1;
  }

  uploadImage2(File image2) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('images of rooms')
        .child('${DateTime.now()}');
    await reference.putFile(image2);
    url2 = await reference.getDownloadURL();
    return url2;
  }

  uploadImage3(File image3) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('images of rooms')
        .child('${DateTime.now()}');
    await reference.putFile(image3);
    url3 = await reference.getDownloadURL();
    return url3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add rooms"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            const SizedBox(
              height: 15,
            ),
            MainTextField(
                hinttext: 'Location',
                iconn: Icons.location_city,
                textEditingController: _locationcontroller),
            const SizedBox(
              height: 15,
            ),
            MainTextField(
                hinttext: 'No.of Rooms',
                iconn: Icons.countertops,
                textEditingController: _roomcontroller),
            const SizedBox(
              height: 15,
            ),
            Card(
              elevation: 2,
              child: MainTextField(
                  hinttext: 'Price',
                  iconn: Icons.money,
                  textEditingController: _priceController),
            ),
            const SizedBox(
              height: 15,
            ),
            MainTextField(
                hinttext: 'Discription',
                iconn: Icons.pause_presentation,
                textEditingController: _discriptioncontroller),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              child: Expanded(
                  child: _image1 == null
                      ? const Center(
                          child: Text('no image captured'),
                        )
                      : Image.file(_image1!)),
              onTap: () {
                imagepicker().whenComplete(() => uploadImage1(_image1!));
              },
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              child: Expanded(
                  child: _image2 == null
                      ? const Center(
                          child: Text('no image captured'),
                        )
                      : Image.file(_image2!)),
              onTap: () {
                imagepicker1().whenComplete(() => uploadImage2(_image2!));
              },
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              // ref = await FirebaseStorage.instance
              //     .ref()
              //     .child('Rooms')
              //     .child('${DateTime.now()}')
              //     .putFile();

              child: Expanded(
                  child: _image3 == null
                      ? const Center(
                          child: Text('no image captured'),
                        )
                      : Image.file(_image3!)),
              onTap: () async {
                imagepicker2().whenComplete(() => uploadImage3(_image3!));
              },

              // child: Container(
              //   // child: Expanded(
              //   //     child: _image1 == null
              //   //         ? Center(
              //   //             child: Text('no image captured'),
              //   //           )
              //   //         : Image.file(_image1!)),
              //   height: 200,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(15),
              //     color: Color.fromARGB(255, 200, 224, 244),
              //     // image:FileImage(_image1!);
              //   ),
              // )),
            ),
            const SizedBox(
              height: 15,
            ),
            ButtonB(
                nameofbutton: 'Add room',
                ontap: () {
                  var TotalRoom =
                      _roomcontroller.text.toString().trim().toLowerCase();
                  var RoomLocation =
                      _locationcontroller.text.toString().trim().toLowerCase();
                  var Discription = _discriptioncontroller.text
                      .toString()
                      .trim()
                      .toLowerCase();
                  var RoomPrice =
                      _priceController.text.toLowerCase().toString().trim();

                  User? user = FirebaseAuth.instance.currentUser;
                  try {
                    FirebaseFirestore.instance.collection('Rooms').doc().set({
                      "Total Room": TotalRoom,
                      "Image1": url1,
                      "Image2": url2,
                      "Image3": url3,
                      "Room Location": RoomLocation,
                      "Discription": Discription,
                      "Room Price": RoomPrice,
                      "userId": user!.uid,
                    }).then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen())));
                  } catch (e) {
                    print("$e error occured over here ");
                  }
                },
                colorofbutton: Colors.blueAccent,
                heightofbutton: 60,
                widthofbutton: 160)
          ]),
        ),
      ),
    );
  }
}
