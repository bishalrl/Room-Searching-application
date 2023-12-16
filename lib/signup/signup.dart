import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:room_chha/components/Textfield.dart';
import 'package:room_chha/login/loginpage.dart';
import 'package:room_chha/signup/signupservice.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var imageUrl;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller =
      TextEditingController(text: '');
  final TextEditingController _occupationcontroller =
      TextEditingController(text: '');
  final TextEditingController _phonecontroller =
      TextEditingController(text: '');
  final TextEditingController _usernamecontroller =
      TextEditingController(text: '');
  User? currentuser = FirebaseAuth.instance.currentUser;

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Please choose an option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    _getFromcamera();
                    //get from camera
                  },
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.camera,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _getFromgallery();
                    //picking image from gallery
                  },
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(
                          8,
                        ),
                        child: Icon(
                          Icons.image,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  dynamic file;

  void _getFromcamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    print(image);

    setState(() {
      file = File(image!.path);
    });
  }

  void _getFromgallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    print(image);

    setState(() {
      file = File(image!.path);
    });
  }

  // void _getFromgallery() async {
  //   ImagePicker pickeimage = await ImagePicker();
  //   XFile? file = await pickeimage.pickImage(source: ImageSource.gallery);
  //   print('${file?.path}');
  //   setState(() {
  //     imageFile = File('${file!.path}');
  //   });
  //   imageFile = image;
  //   Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(" Signup Screen")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              child: const CircleAvatar(
                radius: 100,
              ),
              onTap: () async {
                _showImageDialog();

                final ref = FirebaseStorage.instance
                    .ref()
                    .child('userimage')
                    .child('${DateTime.now()}');
                await ref.putFile(File(file!.path));
                imageUrl = await ref.getDownloadURL();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            MainTextField(
                hinttext: 'email ',
                iconn: Icons.email,
                textEditingController: _emailcontroller),
            const SizedBox(
              height: 20,
            ),
            MainTextField(
                hinttext: 'occupation ',
                iconn: Icons.email,
                textEditingController: _occupationcontroller),
            const SizedBox(
              height: 20,
            ),
            MainTextField(
                hinttext: 'enter your name',
                iconn: Icons.person,
                textEditingController: _usernamecontroller),
            const SizedBox(
              height: 20,
            ),
            MainTextField(
                hinttext: 'enter the password',
                iconn: Icons.password,
                textEditingController: _passwordcontroller),
            const SizedBox(
              height: 20,
            ),
            MainTextField(
                hinttext: 'phonenumber',
                iconn: Icons.phone,
                textEditingController: _phonecontroller),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () async {
                // if (imageFile == null) {
                //   Fluttertoast.showToast(msg: "Please select an image");
                //   return;
                // }
                var userPhone =
                    _phonecontroller.text.toString().trim().toLowerCase();
                var userOccupation =
                    _occupationcontroller.text.toString().trim().toLowerCase();
                var userName =
                    _usernamecontroller.text.toString().trim().toLowerCase();
                var userEmail =
                    _emailcontroller.text.toLowerCase().toString().trim();
                var userPassword =
                    _passwordcontroller.text.toString().trim().toLowerCase();
                try {
                  // final ref = FirebaseStorage.instance
                  //     .ref()
                  //     .child('user Image')
                  //     .child('${DateTime.now()}.jpg');
                  // await ref.putFile(imageFile!);
                  // imageUrl = await ref.getDownloadURL();
                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: userEmail, password: userPassword)
                      .then((value) => {
                            SignUpUser(
                              userName,
                              userEmail,
                              userPassword,
                              userPhone,
                              userOccupation,
                            ),
                            log('user stored'),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreem()))
                          });
                } catch (e) {
                  print("Error:$e");
                }
              },
              child: const Text('signup'),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: const Text("Already have account ? Login"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreem()));
              },
            )
          ],
        ),
      ),
    );
  }
}
//
//
//
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';


// import 'package:room_chha/components/Textfield.dart';
// import 'package:room_chha/components/button.dart';
// import 'package:room_chha/homepage/HomeScree.dart';

// class Information extends StatefulWidget {
//   @override
//   State<Information> createState() => _InformationState();
// }

// class _InformationState extends State<Information> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController _fullNamecontroller =
//       TextEditingController(text: '');
//   final TextEditingController _emailcontroller =
//       TextEditingController(text: '');
//   final TextEditingController _passwordcontroller =
//       TextEditingController(text: '');
//   final TextEditingController _phoneNumcontroller =
//       TextEditingController(text: '');
//   File? imageFile;
//   String? imageUrl;
//   void _showImageDialog() {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Please choose an option'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     _getFromcamera();
//                     //get from camera
//                   },
//                   child: Row(
//                     children: const [
//                       Padding(
//                         padding: EdgeInsets.all(4),
//                         child: Icon(
//                           Icons.camera,
//                           color: Colors.red,
//                         ),
//                       ),
//                       Text(
//                         'Camera',
//                         style: TextStyle(color: Colors.red),
//                       )
//                     ],
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     _getFromgallery();
//                     //picking image from gallery
//                   },
//                   child: Row(
//                     children: const [
//                       Padding(
//                         padding: EdgeInsets.all(
//                           8,
//                         ),
//                         child: Icon(
//                           Icons.image,
//                           color: Colors.red,
//                         ),
//                       ),
//                       Text(
//                         'Gallery',
//                         style: TextStyle(color: Colors.red),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           );
//         });
//   }

//   void _getFromcamera() async {
//     XFile? pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.camera);
//     _cropImage(pickedFile!.path);
//     Navigator.pop(context);
//   }

//   void _getFromgallery() async {
//     XFile? PickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     _cropImage(PickedFile!.path);
//     Navigator.pop(context);
//   }

//   void _cropImage(filePath) async {
//     CroppedFile? croppedImage = await ImageCropper().cropImage(
//       sourcePath: filePath,
//       maxHeight: 1080,
//       maxWidth: 1080,
//     );
//     if (croppedImage != null) {
//       setState(() {
//         imageFile = File(croppedImage.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(50),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           GestureDetector(
//             onTap: () {
//               _showImageDialog();
//               //create show image dialogue
//             },
//             child: CircleAvatar(
//               backgroundImage: imageFile == null
//                   ? const NetworkImage(
//                       'https://imgs.search.brave.com/sSUhxZErbj4ES1E0Ld6DfJ1svu5JKSFpC8nl-EuXkZ8/rs:fit:518:225:1/g:ce/aHR0cHM6Ly90c2Ux/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5D/aWxJZDM3NGVTRl9u/T2kwbzB0TWNRSGFH/eCZwaWQ9QXBp')
//                   : Image.file(imageFile!).image,
//               radius: 100,
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           MainTextField(
//             textEditingController: _fullNamecontroller,
//             hinttext: 'Enter your Full Name',
//             iconn: Icons.person,
//           ),
//           MainTextField(
//             textEditingController: _phoneNumcontroller,
//             hinttext: 'Enter your Phone.No',
//             iconn: Icons.numbers,
//           ),
//           MainTextField(
//             textEditingController: _emailcontroller,
//             hinttext: '',
//             iconn: Icons.email,
//           ),
//           MainTextField(
//             textEditingController: _passwordcontroller,
//             hinttext: 'Enter passwordyou',
//             iconn: Icons.password,
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           ButtonB(
//             colorofbutton: Colors.blueAccent,
//             ontap: () async {
//               if (imageFile == null) {
//                 Fluttertoast.showToast(msg: "Please select an image");
//                 return;
//               }
//               try {
//                 final ref = FirebaseStorage.instance
//                     .ref()
//                     .child('user Image')
//                     .child('${DateTime.now()}.jpg');
//                 await ref.putFile(imageFile!);
//                 imageUrl = await ref.getDownloadURL();
//                 await _auth.createUserWithEmailAndPassword(
//                     email: _emailcontroller.text.trim().toLowerCase(),
//                     password: _passwordcontroller.text.trim());
//                 final User? user = _auth.currentUser;
//                 final _uid = user!.uid;
//                 FirebaseFirestore.instance.collection('users').doc(_uid).set({
//                   'id': _uid,
//                   'userImage': imageUrl,
//                   'name': _fullNamecontroller.text,
//                   'email': _emailcontroller.text,
//                   'phoneNumber': _phoneNumcontroller.text,
//                   'createAt': Timestamp.now(),
//                 });
//                 Navigator.canPop(context) ? Navigator.pop(context) : null;
//               } catch (error) {
//                 Fluttertoast.showToast(msg: 'something went wrong');
//               }
//               //home page
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => HomeScreen()));
//             },
//             widthofbutton: 160,
//             heightofbutton: 70,
//             nameofbutton: 'Sign_Up',
//           )
//         ],
//       ),
//     );
//   }
// }
