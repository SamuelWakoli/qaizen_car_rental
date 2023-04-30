import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Text(style: TextStyle(fontSize: 16), """
At Qaizen Car Rental, we are committed to providing our customers with the highest level of service and convenience. Our state-of-the-art car rental app offers a seamless experience for browsing and reserving a diverse fleet of vehicles, ranging from economy cars to luxury SUVs.

With a wide range of options to suit any occasion or budget, we are dedicated to meeting the transportation needs of our valued clients. Our team of experts is dedicated to ensuring that every rental experience is smooth and satisfactory.

In addition to our exceptional customer service, our app offers advanced features such as real-time reservation tracking, and the ability to make changes to your booking with ease.

We take pride in our reputation for excellence and strive to consistently exceed the expectations of our clients. Thank you for choosing Qaizen Car Rental for your car rental needs, we look forward to serving you.
"""),
              Text(style: TextStyle(fontSize: 18), "Our Mission"),
              Text(style: TextStyle(fontSize: 16), """
To be the best transportation service provider in the world, to exceed our customers’ expectations for service, quality and value, to provide our employees with a great place of work and to serve our communities as a committed corporate citizen.
"""),
            ],
          ),
        ),
      ),
    );
  }
}
