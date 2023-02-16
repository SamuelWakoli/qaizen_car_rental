import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../db/user.dart';
import '../widgets/widgets.dart';
import 'acc_verification_page2.dart';

class AccVerificationPage1b extends StatefulWidget {
  const AccVerificationPage1b({super.key});

  @override
  State<AccVerificationPage1b> createState() => _AccVerificationPage1bState();
}

class _AccVerificationPage1bState extends State<AccVerificationPage1b> {
  File? image;
  Future pickImageGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Widget _getImage() {
    if (image != null) {
      return SizedBox(
        width: double.infinity,
        height: 360,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.file(
              image!,
              fit: BoxFit.fill,
            )),
      );
    } else {
      return const SizedBox(height: 30);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [Text('Page 2 out of 5')],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            const Text(
              'provide with a high-resolution, passport-compliant image of your face for your profile purposes.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Card(
              child: Column(children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Get image from:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () => pickImageGallery(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 10),
                            Text('Gallery',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).primaryColor)),
                          ],
                        )),
                    ElevatedButton(
                        onPressed: () => pickImageCamera(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 10),
                            Text('Camera',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).primaryColor)),
                          ],
                        )),
                  ],
                ),
                const SizedBox(height: 8),
                _getImage(),
              ]),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () async {
                  if (image != null) {

                    Map<String, String> passportURL = {
                      'passport URL': await UserStorageFolder.child(
                              '${getUserName()}\'s passport.png')
                          .putFile(image!)
                          .snapshot
                          .ref
                          .getDownloadURL()
                    };

                    await UserData.update(passportURL).whenComplete(() => nextPage(
                          context: context, page: const AccVerificationPage2()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Passport image cannot be empty')),
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Next',
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor)),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.arrow_forward,
                      size: 32,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                )),
          ]),
        ),
      ),
    );
  }
}
