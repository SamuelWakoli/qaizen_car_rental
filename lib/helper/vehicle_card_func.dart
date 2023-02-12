import 'package:qaizen_car_rental/ui/pages/details.dart';

import '../ui/pages/hire.dart';
import '../ui/widgets/widgets.dart';

dynamic details({required context, required vehicleID}) {
  //use id to load vehicle details
  nextPage(context: context, page: const DetailsPage());
}

String VehicleDocID = '';
String VehicleName = '';

dynamic hire({
  required context,
  required vehicleID,
}) {
  ///if user profile is verified,
  VehicleDocID = vehicleID;
  //use id to load vehicle details
  nextPage(context: context, page: const HirePage());
}
