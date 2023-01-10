import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/ui/pages/returning_vehicles.dart';
import 'package:qaizen_car_rental/ui/widgets/vehicle_card.dart';

import '../../helper/vehicle_card_func.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//replace these var by getting vehicle ID to get liked status.
  bool isLiked0 = false;
  bool isLiked1 = false;
  bool isLiked2 = false;
  bool isLiked3 = false;
  bool isLiked4 = false;
  bool isLiked5 = false;
  bool isLiked6 = false;
  bool isLiked7 = false;
  bool isLiked8 = false;
  bool isLiked9 = false;
  bool isLiked10 = false;
  bool isLiked11 = false;
  bool isLiked12 = false;
  bool isLiked13 = false;
  bool isLiked14 = false;
  bool isLiked15 = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 810),
        child: ListView(
          children: [
            const Center(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Available Vehicles',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
            HomeCard(
                id: 'KDA',
                image: 'assets/cars/teslamodelx.jpg',
                name: 'Tesla Model X',
                price: '30,000',
                isLiked: isLiked0,
                onClickFav: () {
                  setState(() {
                    like(
                        context: context,
                        vehicleID: null,
                        likeStatus: isLiked0);
                  });
                },
                onClickHire: () {
                  setState(() {
                    hire(context: context, vehicleID: null);
                  });
                },
                onClickDetails: () {
                  setState(() {
                    details(context: context, vehicleID: null);
                  });
                }),
            HomeCard(
                id: 'KDA',
                image: 'assets/cars/note.jpg',
                name: 'Nissan Note',
                price: '30,000',
                isLiked: isLiked1,
                onClickFav: () {
                  setState(() {
                    like(
                        context: context,
                        vehicleID: null,
                        likeStatus: isLiked1);
                  });
                },
                onClickHire: () {
                  setState(() {
                    hire(context: context, vehicleID: null);
                  });
                },
                onClickDetails: () {
                  setState(() {
                    details(context: context, vehicleID: null);
                  });
                }),
            HomeCard(
                id: 'KDA',
                image: 'assets/cars/axio.jpeg',
                name: 'Toyota Axio',
                price: '0,000',
                isLiked: isLiked2,
                onClickFav: () {
                  setState(() {
                    like(
                        context: context,
                        vehicleID: null,
                        likeStatus: isLiked2);
                  });
                },
                onClickHire: () {
                  setState(() {
                    hire(context: context, vehicleID: null);
                  });
                },
                onClickDetails: () {
                  setState(() {
                    details(context: context, vehicleID: null);
                  });
                }),
            HomeCard(
                id: 'KDA',
                image: 'assets/cars/crown.jpg',
                name: 'Toyota Crown',
                price: '6,000',
                isLiked: isLiked3,
                onClickFav: () {
                  setState(() {
                    like(
                        context: context,
                        vehicleID: null,
                        likeStatus: isLiked3);
                  });
                },
                onClickHire: () {
                  setState(() {
                    hire(context: context, vehicleID: null);
                  });
                },
                onClickDetails: () {
                  setState(() {
                    details(context: context, vehicleID: null);
                  });
                }),
            HomeCard(
                id: 'KDA',
                image: 'assets/cars/teslamodelx.jpg',
                name: 'Tesla Model X',
                price: '30,000',
                isLiked: isLiked4,
                onClickFav: () {
                  setState(() {
                    like(
                        context: context,
                        vehicleID: null,
                        likeStatus: isLiked4);
                  });
                },
                onClickHire: () {
                  setState(() {
                    hire(context: context, vehicleID: null);
                  });
                },
                onClickDetails: () {
                  setState(() {
                    details(context: context, vehicleID: null);
                  });
                }),
            HomeCard(
                id: 'KDA',
                image: 'assets/cars/note.jpg',
                name: 'Nissan Note',
                price: '30,000',
                isLiked: isLiked5,
                onClickFav: () {
                  setState(() {
                    like(
                        context: context,
                        vehicleID: null,
                        likeStatus: isLiked5);
                  });
                },
                onClickHire: () {
                  setState(() {
                    hire(context: context, vehicleID: null);
                  });
                },
                onClickDetails: () {
                  setState(() {
                    details(context: context, vehicleID: null);
                  });
                }),
            HomeCard(
                id: 'KDA',
                image: 'assets/cars/axio.jpeg',
                name: 'Toyota Axio',
                price: '0,000',
                isLiked: isLiked6,
                onClickFav: () {
                  setState(() {
                    like(
                        context: context,
                        vehicleID: null,
                        likeStatus: isLiked6);
                  });
                },
                onClickHire: () {
                  setState(() {
                    hire(context: context, vehicleID: null);
                  });
                },
                onClickDetails: () {
                  setState(() {
                    details(context: context, vehicleID: null);
                  });
                }),
            HomeCard(
                id: 'KDA',
                image: 'assets/cars/crown.jpg',
                name: 'Toyota Crown',
                price: '6,000',
                isLiked: isLiked7,
                onClickFav: () {
                  setState(() {
                    like(
                        context: context,
                        vehicleID: null,
                        likeStatus: isLiked7);
                  });
                },
                onClickHire: () {
                  setState(() {
                    hire(context: context, vehicleID: null);
                  });
                },
                onClickDetails: () {
                  setState(() {
                    details(context: context, vehicleID: null);
                  });
                }),
            HomeCard(
                id: 'KDA',
                image: 'assets/cars/teslamodelx.jpg',
                name: 'Tesla Model X',
                price: '30,000',
                isLiked: isLiked8,
                onClickFav: () {
                  setState(() {
                    like(
                        context: context,
                        vehicleID: null,
                        likeStatus: isLiked8);
                  });
                },
                onClickHire: () {
                  setState(() {
                    hire(context: context, vehicleID: null);
                  });
                },
                onClickDetails: () {
                  setState(() {
                    details(context: context, vehicleID: null);
                  });
                }),
            HomeCard(
                id: 'KDA',
                image: 'assets/cars/note.jpg',
                name: 'Nissan Note',
                price: '30,000',
                isLiked: isLiked9,
                onClickFav: () {
                  setState(() {
                    like(
                        context: context,
                        vehicleID: null,
                        likeStatus: isLiked9);
                  });
                },
                onClickHire: () {
                  setState(() {
                    hire(context: context, vehicleID: null);
                  });
                },
                onClickDetails: () {
                  setState(() {
                    details(context: context, vehicleID: null);
                  });
                }),
            HomeCard(
                id: 'KDA',
                image: 'assets/cars/axio.jpeg',
                name: 'Toyota Axio',
                price: '0,000',
                isLiked: isLiked10,
                onClickFav: () {
                  setState(() {
                    like(
                        context: context,
                        vehicleID: null,
                        likeStatus: isLiked10);
                  });
                },
                onClickHire: () {
                  setState(() {
                    hire(context: context, vehicleID: null);
                  });
                },
                onClickDetails: () {
                  setState(() {
                    details(context: context, vehicleID: null);
                  });
                }),
            HomeCard(
                id: 'KDA',
                image: 'assets/cars/crown.jpg',
                name: 'Toyota Crown',
                price: '6,000',
                isLiked: isLiked11,
                onClickFav: () {
                  setState(() {
                    like(
                        context: context,
                        vehicleID: null,
                        likeStatus: isLiked11);
                  });
                },
                onClickHire: () {
                  setState(() {
                    hire(context: context, vehicleID: null);
                  });
                },
                onClickDetails: () {
                  setState(() {
                    details(context: context, vehicleID: null);
                  });
                }),
            HomeCard(
                id: 'KDA',
                image: 'assets/cars/teslamodelx.jpg',
                name: 'Tesla Model X',
                price: '30,000',
                isLiked: isLiked12,
                onClickFav: () {
                  setState(() {
                    like(
                        context: context,
                        vehicleID: null,
                        likeStatus: isLiked12);
                  });
                },
                onClickHire: () {
                  setState(() {
                    hire(context: context, vehicleID: null);
                  });
                },
                onClickDetails: () {
                  setState(() {
                    details(context: context, vehicleID: null);
                  });
                }),
            HomeCard(
                id: 'KDA',
                image: 'assets/cars/note.jpg',
                name: 'Nissan Note',
                price: '30,000',
                isLiked: isLiked13,
                onClickFav: () {
                  setState(() {
                    like(
                        context: context,
                        vehicleID: null,
                        likeStatus: isLiked13);
                  });
                },
                onClickHire: () {
                  setState(() {
                    hire(context: context, vehicleID: null);
                  });
                },
                onClickDetails: () {
                  setState(() {
                    details(context: context, vehicleID: null);
                  });
                }),
            HomeCard(
                id: 'KDA',
                image: 'assets/cars/axio.jpeg',
                name: 'Toyota Axio',
                price: '0,000',
                isLiked: isLiked14,
                onClickFav: () {
                  setState(() {
                    like(
                        context: context,
                        vehicleID: null,
                        likeStatus: isLiked14);
                  });
                },
                onClickHire: () {
                  setState(() {
                    hire(context: context, vehicleID: null);
                  });
                },
                onClickDetails: () {
                  setState(() {
                    details(context: context, vehicleID: null);
                  });
                }),
            HomeCard(
                id: 'KDA',
                image: 'assets/cars/crown.jpg',
                name: 'Toyota Crown',
                price: '6,000',
                isLiked: isLiked15,
                onClickFav: () {
                  setState(() {
                    like(
                        context: context,
                        vehicleID: null,
                        likeStatus: isLiked15);
                  });
                },
                onClickHire: () {
                  setState(() {
                    hire(context: context, vehicleID: null);
                  });
                },
                onClickDetails: () {
                  setState(() {
                    details(context: context, vehicleID: null);
                  });
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () {
                  nextPage(context: context, page: const ReturningVehicles());
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Show Returning Vehicles'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
