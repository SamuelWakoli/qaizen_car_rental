import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qaizen_car_rental/db/user.dart';

import '../widgets/text_form_field.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({super.key});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userprofileUrl =
      FirebaseAuth.instance.currentUser!.photoURL.toString();
  String userEmail = FirebaseAuth.instance.currentUser!.email.toString();
  String username = FirebaseAuth.instance.currentUser!.displayName.toString();

  File? image;

  Future pickImageGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }

  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }

  Widget _getImage() {
    if (image != null) {
      return SizedBox(
        width: 160,
        height: 160,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.file(
              image!,
              fit: BoxFit.cover,
            )),
      );
    } else {
      // return current image
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            height: 160,
            width: 160,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: userprofileUrl,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              errorWidget: (cx, url, downloadProgress) {
                return const Center(
                    child: Text(
                  "no image selected",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ));
              },
            ),
          ),
        ),
      );
    }
  }

  bool loading = false, showErrorText = false, navigatedToNextPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Details"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(child: _getImage()),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              content: SizedBox(
                                height: 180,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Get image from:',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(height: 20),
                                    OutlinedButton(
                                        onPressed: () async {
                                          Navigator.pop(ctx);
                                          return pickImageGallery();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.image_outlined,
                                              size: 32,
                                            ),
                                            const SizedBox(width: 20),
                                            Text(
                                              "Gallery",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        )),
                                    const SizedBox(width: 12),
                                    OutlinedButton(
                                        onPressed: () async {
                                          Navigator.pop(ctx);
                                          return pickImageCamera();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.camera_outlined,
                                              size: 32,
                                            ),
                                            const SizedBox(width: 20),
                                            Text(
                                              "Camera",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Edit Profile Picture",
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      const Icon(Icons.edit_outlined)
                    ],
                  ),
                ),
                if (image == null) const SizedBox(height: 16),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textFormField(
                    initialValue: userName,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                    context: context,
                    icon: Icons.account_box_outlined,
                    labelText: 'Name',
                    hintText: userName,
                    onChanged: (value) {
                      userName = value;
                    },
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name cannot be empty';
                      }
                    },
                  ),
                  textFormField(
                    initialValue: phoneNumber,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.phone,
                    context: context,
                    icon: Icons.phone_outlined,
                    labelText: 'Phone',
                    hintText: phoneNumber,
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number cannot be empty';
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          if (image != null || userprofileUrl != "null")
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String photoURL = "";

                      setState(() {
                        loading = true;
                      });

                      Future<void> updatePersonalData() async {
                        // setting data to firestore

                        Map<String, dynamic> userDetails = {
                          "profile img url": (userprofileUrl == "null")
                              ? photoURL
                              : userprofileUrl,
                          "name": userName,
                          "phone": phoneNumber,
                        };

                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(userID)
                            .update(userDetails)
                            .whenComplete(() async {
                          setState(() {
                            loading = false;
                          });

                          await FirebaseAuth.instance.currentUser!
                              .updateDisplayName(userName)
                              .whenComplete(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(minutes: 1),
                                content: Text(
                                    "Your account has been updated successfully"),
                              ),
                            );
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            Scaffold.of(context).closeDrawer();
                          });
                        });
                      }

                      if (image != null) {
                        await FirebaseStorage.instance
                            .ref("users/$userEmail")
                            .child("ProfilePhoto.png")
                            .putFile(image!)
                            .then((snapshot) async {
                          photoURL = await snapshot.ref.getDownloadURL();
                        }).whenComplete(() async {
                          if (photoURL != "") {
                            await FirebaseAuth.instance.currentUser!
                                .updatePhotoURL(photoURL)
                                .whenComplete(() => updatePersonalData());
                          } else {
                            setState(() {
                              loading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Please ensure you have a well set internet connection and try again"),
                              ),
                            );
                          }
                        });
                      } else {
                        updatePersonalData();
                      }
                    }
                  },
                  child: loading
                      ? Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.save_outlined,
                              size: 32,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Save",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        )),
            ),
          const SizedBox(
            width: 12,
          )
        ],
      ),
    );
  }
}
