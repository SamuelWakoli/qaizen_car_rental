import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qaizen_car_rental/ui/pages/hire_summary.dart';
import 'package:qaizen_car_rental/ui/pages/pick_location.dart';
import 'package:qaizen_car_rental/ui/pages/terms_conditions.dart';
import '../../shared/hire_vehicle_data.dart';
import '../widgets/text_form_field.dart';
import '../widgets/widgets.dart';

class HirePage extends StatefulWidget {
  const HirePage({super.key});

  @override
  State<HirePage> createState() => _HirePageState();
}

///terms and conditions
class _HirePageState extends State<HirePage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _isLoading = false;

  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime.now(), //prevent user from selecting old date
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
        selectedDate =
            '${currentDate.day}/${currentDate.month}/${currentDate.year}';
      });
    }
  }

  TimeOfDay currentTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: currentTime);
    if (pickedTime != null) {
      setState(() {
        //prevent user from picking old time

        currentTime = pickedTime;
        selectedTime = '${pickedTime.hour}:${pickedTime.minute}';
      });
    }
  }

  String formatedTime() {
    if (currentTime.hour < 10) {
      selectedTime = '0${currentTime.hour}:${currentTime.minute}';
      //return '0${currentTime.hour}:${currentTime.minute}';
      return selectedTime;
    } else if (currentTime.minute < 10) {
      selectedTime = '${currentTime.hour}:0${currentTime.minute}';
      //return '${currentTime.hour}:0${currentTime.minute}';
      return selectedTime;
    } else if (currentTime.hour < 10 && currentTime.minute < 10) {
      selectedTime = '0${currentTime.hour}:0${currentTime.minute}';
      // return '0${currentTime.hour}:0${currentTime.minute}';
      return selectedTime;
    } else {
      // return '${currentTime.hour}:${currentTime.minute}';
      return selectedTime;
    }
  }

  bool delivery = false;
  bool acceptedTerms = false;
  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('\$vehicleName'),
          centerTitle: true,
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor),
              )
            : SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 510, minWidth: 300),
                    child: Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Duration',
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                  'I am hiring the selected vehicle starting from :'),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: OutlinedButton(
                                  onPressed: () => _selectTime(context),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.clock,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Select time',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                formatedTime(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: OutlinedButton(
                                  onPressed: () => _selectDate(context),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.calendar_month_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Select date',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                '${currentDate.day}/${currentDate.month}/${currentDate.year}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val!.isNotEmpty) {
                                      return null;
                                    } else {
                                      return "Name cannot be empty";
                                    }
                                  },
                                  onChanged: (value) {
                                    numberOfDays = value;
                                  },
                                  minLines: 1,
                                  cursorHeight: 22,
                                  cursorWidth: 2,
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: InputDecoration(
                                    labelText: "Number of days:",
                                    labelStyle: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(color: Theme.of(context).primaryColor),
                              const SizedBox(height: 10),
                              const Text(
                                'Delivery',
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                  'Do you want the vehicle to be delivered to you? (Delivery fee applied)'),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: RadioListTile(
                                      title: const Text("Yes"),
                                      value: true,
                                      groupValue: delivery,
                                      onChanged: (value) {
                                        setState(() {
                                          delivery = value!;
                                          deliveryService = value;
                                        });
                                      },
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120,
                                    child: RadioListTile(
                                      title: const Text("No"),
                                      value: false,
                                      groupValue: delivery,
                                      onChanged: (value) {
                                        setState(() {
                                          delivery = value!;
                                          deliveryService = value;
                                        });
                                      },
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                  onPressed: () {
                                    delivery
                                        ? nextPage(
                                            context: context,
                                            page: const PickLocation())
                                        : showSnackbar(
                                            context: context,
                                            duration: 5,
                                            message:
                                                'This option is available on selecting "Yes" for vehicle delivery.');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.pin_drop_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          ///use this location in the driver app
                                          'Select delivery location',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Divider(color: Theme.of(context).primaryColor),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    value: acceptedTerms,
                                    onChanged: ((value) {
                                      setState(() {
                                        acceptedTerms = value!;
                                      });
                                    }),
                                  ),
                                  Text.rich(TextSpan(
                                    text: "I accept the ",
                                    style: const TextStyle(fontSize: 14),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "terms and conditions",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 16,
                                              decoration:
                                                  TextDecoration.underline),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              nextPage(
                                                  context: context,
                                                  page:
                                                      const TermsConditionsPage());
                                            }),
                                    ],
                                  )),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                  onPressed: () {
                                    acceptedTerms
                                        ? nextPage(
                                            context: context,
                                            page: const HireSummary())
                                        : showSnackbar(
                                            context: context,
                                            duration: 4,
                                            message:
                                                'Please accept the terms and conditions to continue.');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          ///use this location in the driver app
                                          'Next',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Icon(
                                          Icons.arrow_forward_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ),
      ),
    );
  }
}
