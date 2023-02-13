import 'package:qaizen_car_rental/ui/pages/details.dart';

import '../ui/pages/hire.dart';
import '../ui/widgets/widgets.dart';

dynamic details({required context}) {
  nextPage(context: context, page: const VehicleDetailsPage());
}

dynamic hire({required context}) {
  nextPage(context: context, page: const HirePage());
}
