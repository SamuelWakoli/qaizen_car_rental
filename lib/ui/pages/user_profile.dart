import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/ui/pages/edit_profile.dart';
import 'package:qaizen_car_rental/ui/widgets/widgets.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>
                nextPage(context: context, page: const EditProfile()),
            tooltip: 'Edit Profile',
            icon: const Icon(Icons.edit_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
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
                const Text(
                  'User Name',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                Divider(color: Theme.of(context).primaryColor),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 400, minWidth: 300),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text.rich(
                              TextSpan(
                                text: 'Profile status: ',
                                style: TextStyle(fontSize: 18),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Verified',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: const [
                            Text.rich(
                              TextSpan(
                                text: 'Phone number: ',
                                style: TextStyle(fontSize: 18),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '+254712345678',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: const [
                            Text.rich(
                              TextSpan(
                                text: 'Email address: ',
                                style: TextStyle(fontSize: 18),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'username2023@gmail.com',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
