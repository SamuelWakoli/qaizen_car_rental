import 'package:flutter/material.dart';

class ManageFavoritesPage extends StatefulWidget {
  const ManageFavoritesPage({super.key});

  @override
  State<ManageFavoritesPage> createState() => _ManageFavoritesPageState();
}

class _ManageFavoritesPageState extends State<ManageFavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage Favorites'),
          centerTitle: true,
        ),
      ),
    );
  }
}
