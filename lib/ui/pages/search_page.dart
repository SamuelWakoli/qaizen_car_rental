import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../db/user.dart';
import '../../helper/vehicle_card_func.dart';
import '../widgets/vehicle_card_available.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    searchController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CircleAvatar(
          radius: 22,
          backgroundColor: Colors.white,
          child: Image.asset('assets/ic_launcher.png'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                autofocus: true,
                autocorrect: true,
                focusNode: focusNode,
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                onSubmitted: (value) {
                  setState(() {});
                },
                onTapOutside: (value) {
                  setState(() {});
                  focusNode.unfocus();
                },
                decoration: InputDecoration(
                  hintText: "Search",
                  suffixIcon: IconButton(
                    tooltip: "Clear",
                    onPressed: () {
                      setState(() {
                        searchController.clear();
                      });
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(48.0),
                  ),
                ),
                textInputAction: TextInputAction.search,
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('vehicles')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  }

                  final searchResults =
                      snapshot.data!.docs.toList().reversed.where((document) {
                    // Filter logic
                    final name = document['name'].toString().toLowerCase();
                    final searchQuery = searchController.text.toLowerCase();
                    return name.contains(searchQuery);
                  }).toList();

                  if (searchResults.isEmpty) {
                    return const Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final document = searchResults[index];

                      return availableVehicleCard(
                        context: context,
                        id: document.id,
                        availability: document['availability'],
                        image: document['displayImageURL'],
                        name: document['name'],
                        price: document['priceDay'],
                        onClickHire: () {
                          currentVehicleDocID = document.id;
                          hire(context: context);
                        },
                        onClickBook: () {
                          currentVehicleDocID = document.id;
                          book(context: context);
                        },
                        onClickDetails: () {
                          setState(() {
                            currentVehicleDocID = document.id;
                            details(context: context);
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
