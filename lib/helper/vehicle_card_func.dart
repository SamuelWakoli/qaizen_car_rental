import 'package:qaizen_car_rental/ui/pages/details.dart';
import '../ui/pages/hire.dart';
import '../ui/widgets/widgets.dart';

dynamic like({
  required context,
  required vehicleID,
  required bool likeStatus,
}) {
  //use id to add vehicle to favorites
  if (likeStatus == false) likeStatus = true;

  showSnackbar(
    context: context,
    message: "\$vehicleName added to favorites",
    duration: 3,
  );
}

dynamic details({required context, required vehicleID}) {
  //use id to load vehicle details
  nextPage(context: context, page: const DetailsPage());
}

dynamic hire({
  required context,
  required vehicleID,
}) {
  //use id to load vehicle details
  nextPage(context: context, page: const HirePage());
}
