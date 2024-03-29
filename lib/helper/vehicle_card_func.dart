import 'package:qaizen_car_rental/shared/hire_vehicle_data.dart';
import 'package:qaizen_car_rental/ui/pages/book_vehicle.dart';
import 'package:qaizen_car_rental/ui/pages/details.dart';

import '../ui/pages/hire.dart';
import '../ui/widgets/widgets.dart';

dynamic details({required context}) {
  nextPage(context: context, page: const VehicleDetailsPage());
}

dynamic hire({required context}) async {
  totalCost = 0;
  numberOfDays = '';
  driversNames = [];
  selectedVehicles = [];
  selectedVehicleNames = [];
  deliveryAddress = '';

  serviceType = "Self Drive";
  nextPage(context: context, page: const HirePage());
}

dynamic book({required context}) async {
  totalCost = 0;
  numberOfDays = '';
  driversNames = [];
  selectedVehicles = [];
  selectedVehicleNames = [];
  deliveryAddress = '';

  serviceType = "Self Drive";
  nextPage(context: context, page: const BookVehicle());
}
