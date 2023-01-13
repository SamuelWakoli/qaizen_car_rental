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

  bool isnotifyON1 = false;
  bool isnotifyON2 = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: const TabBar(
            
            tabs: [
              Tab(text: 'Available Vehicles'),
              Tab(text: 'Returning Vehicles'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: [
                AvailableVehicleCard(
                    id: 'KDA',
                    image: 'assets/cars/teslamodelx.jpg',
                    name: 'Tesla Model X',
                    price: '30,000',
                    isLiked: isLiked0,
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
                AvailableVehicleCard(
                    id: 'KDA',
                    image: 'assets/cars/note.jpg',
                    name: 'Nissan Note',
                    price: '30,000',
                    isLiked: isLiked1,
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
                AvailableVehicleCard(
                    id: 'KDA',
                    image: 'assets/cars/axio.jpeg',
                    name: 'Toyota Axio',
                    price: '0,000',
                    isLiked: isLiked2,
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
                AvailableVehicleCard(
                    id: 'KDA',
                    image: 'assets/cars/crown.jpg',
                    name: 'Toyota Crown',
                    price: '6,000',
                    isLiked: isLiked3,
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
                AvailableVehicleCard(
                    id: 'KDA',
                    image: 'assets/cars/teslamodelx.jpg',
                    name: 'Tesla Model X',
                    price: '30,000',
                    isLiked: isLiked4,
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
                AvailableVehicleCard(
                    id: 'KDA',
                    image: 'assets/cars/note.jpg',
                    name: 'Nissan Note',
                    price: '30,000',
                    isLiked: isLiked5,
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
                AvailableVehicleCard(
                    id: 'KDA',
                    image: 'assets/cars/axio.jpeg',
                    name: 'Toyota Axio',
                    price: '0,000',
                    isLiked: isLiked6,
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
                AvailableVehicleCard(
                    id: 'KDA',
                    image: 'assets/cars/crown.jpg',
                    name: 'Toyota Crown',
                    price: '6,000',
                    isLiked: isLiked7,
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
                AvailableVehicleCard(
                    id: 'KDA',
                    image: 'assets/cars/teslamodelx.jpg',
                    name: 'Tesla Model X',
                    price: '30,000',
                    isLiked: isLiked8,
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
                AvailableVehicleCard(
                    id: 'KDA',
                    image: 'assets/cars/note.jpg',
                    name: 'Nissan Note',
                    price: '30,000',
                    isLiked: isLiked9,
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
                AvailableVehicleCard(
                    id: 'KDA',
                    image: 'assets/cars/axio.jpeg',
                    name: 'Toyota Axio',
                    price: '0,000',
                    isLiked: isLiked10,
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
                AvailableVehicleCard(
                    id: 'KDA',
                    image: 'assets/cars/crown.jpg',
                    name: 'Toyota Crown',
                    price: '6,000',
                    isLiked: isLiked11,
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
                AvailableVehicleCard(
                    id: 'KDA',
                    image: 'assets/cars/teslamodelx.jpg',
                    name: 'Tesla Model X',
                    price: '30,000',
                    isLiked: isLiked12,
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
                AvailableVehicleCard(
                    id: 'KDA',
                    image: 'assets/cars/note.jpg',
                    name: 'Nissan Note',
                    price: '30,000',
                    isLiked: isLiked13,
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
                AvailableVehicleCard(
                    id: 'KDA',
                    image: 'assets/cars/axio.jpeg',
                    name: 'Toyota Axio',
                    price: '0,000',
                    isLiked: isLiked14,
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
                AvailableVehicleCard(
                    id: 'KDA',
                    image: 'assets/cars/crown.jpg',
                    name: 'Toyota Crown',
                    price: '6,000',
                    isLiked: isLiked15,
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
              ],
            ),
            ListView(
              children: [
                ReturningVehicleCard(
                  id: 'KDA',
                  image: 'assets/cars/axio.jpeg',
                  name: 'Toyota Axio',
                  price: '0,000',
                  isLiked: isLiked2,
                  availabilityNotification: isnotifyON1,
                  onClickNotifyMe: () {
                    setState(() {
                      hire(context: context, vehicleID: null);
                    });
                  },
                  onClickDetails: () {
                    setState(() {
                      details(context: context, vehicleID: null);
                    });
                  },
                ),
                ReturningVehicleCard(
                    id: 'KDA',
                    image: 'assets/cars/crown.jpg',
                    name: 'Toyota Crown',
                    price: '6,000',
                    isLiked: isLiked3,
                    availabilityNotification: isnotifyON2,
                    onClickNotifyMe: () {
                      setState(() {
                        hire(context: context, vehicleID: null);
                      });
                    },
                    onClickDetails: () {
                      setState(() {
                        details(context: context, vehicleID: null);
                      });
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
