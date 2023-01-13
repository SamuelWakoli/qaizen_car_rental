import 'package:flutter/material.dart';

import '../widgets/material_button.dart';
import '../widgets/text_form_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}
//the hint shows current username.

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400, minWidth: 300),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(
                      "assets/cars/teslamodelx.jpg",
                    ),
                  ),
                  const SizedBox(height: 20),
                  materialButton(
                      context: context,
                      icon: Icons.image_outlined,
                      text: 'Change Profile Photo',
                      onPressed: () {}),
                  const SizedBox(height: 20),
                  textFormField(
                    textInputType: TextInputType.name,
                    context: context,
                    icon: Icons.person_outline,
                    labelText: 'Name: ',
                    hintText: 'User Name',
                    onChanged: (val) {
                      setState(() {
                        //fullName = val;
                      });
                    },
                    validator: (val) {
                      // if (val!.isNotEmpty) {
                      //   return null;
                      // } else {
                      //   return "Name cannot be empty";
                      // }
                    },
                  ),
                  textFormField(
                    textInputType: TextInputType.phone,
                    context: context,
                    icon: Icons.phone_outlined,
                    labelText: 'Phone: ',
                    hintText: '+254712345678',
                    onChanged: (val) {
                      setState(() {
                        //fullName = val;
                      });
                    },
                    validator: (val) {
                      // if (val!.isNotEmpty) {
                      //   return null;
                      // } else {
                      //   return "Name cannot be empty";
                      // }
                    },
                  ),
                  textFormField(
                    textInputType: TextInputType.emailAddress,
                    context: context,
                    icon: Icons.email_outlined,
                    labelText: 'Email: ',
                    hintText: 'username2023@gmail.com',
                    onChanged: (val) {
                      setState(() {
                        //fullName = val;
                      });
                    },
                    validator: (val) {
                      // if (val!.isNotEmpty) {
                      //   return null;
                      // } else {
                      //   return "Name cannot be empty";
                      // }
                    },
                  ),
                  materialButton(
                      context: context,
                      icon: Icons.save_outlined,
                      text: 'Save',
                      onPressed: () {}),
                ]),
          ),
        ),
      ),
    );
  }
}
