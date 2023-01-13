import 'package:flutter/material.dart';

class TermsConditionsPage extends StatefulWidget {
  const TermsConditionsPage({Key? key}) : super(key: key);

  @override
  State<TermsConditionsPage> createState() => _TermsConditionsPageState();
}

class _TermsConditionsPageState extends State<TermsConditionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 810),
          child: ListView(
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("""
1. QAIZEN CAR RENTAL (the company) hereby agrees to let on hire the person named in the overleaf (the hirer) and agrees to issue on hire the motor
vehicle described in the overleaf together with the accessories earned with it or fixed on it hereafter called (the vehicle) upon the terms and conditions
set out in the overleaf and here under.

2. The period of hire shall be as set in the overleaf and the vehicle MUST be returned to the company on the date set out in the overleaf unless the period
of hire is extended by telephone or email during working hours.

These are Monday to Saturday between 8.00am to 5.00pm; also, special arrangements must be made in regards to the vehicle’s collection. Extra charges will be applied if the vehicle is returned after the working hours without prior
arrangements having been made.

It is also an offence to keep the vehicle beyond the contracted days and the company may, at any time after the agreed date of return has passed, repossess the vehicle and pursue further legal action against the hirer at his/her cost. In such an event, the hirer shall be fully responsible for any loss or damages caused by accident or otherwise. The company shall not – under any circumstances – be liable to any damages or indemnification of the hirer.

3. In accepting the vehicle, the hirer shall be deemed to have satisfied himself or herself that the vehicle is roadworthy and in a proper, safe, and working
condition. The company shall not be liable to make any payments to the hirer for any loss, injury, or damages sustained by the hirer or any other party as a result of any defect in the vehicle or any breakdown during the hire period.

4. The hirer's charges shall be based on the number of days that the vehicle is hired as well as the vehicle’s usage including, but not limited to, its destination.

5. The hirer further agrees that:
a) She/he will not (nor will any unauthorized third party) drive the vehicle whilst he or she is under the influence of alcohol or any drugs or narcotics, and
any other substances that could impair the driver's consciousness or ability to drive.
b) The vehicle will be driven in a skillful manner and all traffic laws, rules, and the Highway Code provisions shall at all times be observed and complied with. The vehicle shall not carry more passengers than its carrying capacity as specified on the insurance cover as visible on the windscreen.
c) The vehicle will be driven by the designated driver or any other driver indicated on the overleaf on the condition that they have a current driver’s
license with an experience of not less than 2 years and must be within 23 and 65 years.
d) The vehicle will be kept locked and secured when parked and every precaution will be taken to avoid damage or theft of any of its contents.
e) The vehicle shall be used for social and pleasure purposes and on all-weather roads. The vehicle shall not be used for racing, peacemaking, carnage purposes, or ferrying fare-paying passengers.
f) The vehicle shall not be taken out of Kenyan boundaries unless there exists an agreement between the company and the hirer.
g) The hirer shall promptly pay parking fees failure to which he/she shall be responsible for the payment of any indemnification fees.
h) The hirer shall at all-time check for oil, water, and tyre pressure. In the event that he fails to do so, he is responsible to reimburse the company for any loss, damages, or expenses that may occur from that event.
i) Unless authorized by the company in writing, the hirer will, under no  circumstances, modify, add extra accessories to the vehicle or repair the vehicle.
j) In case of breakdown, accident the damage to the vehicle as a result of gross act or willful negligence of the hirer or authorized driver, the hirer shall pay the company the total cost of towing the vehicle to the company’s premises as well as the full cost of repairing the vehicle.
k) The hirer shall be responsible to pay the repair costs of any damaged parts and accessories of the vehicle on return.
l) In case of any accident (involving the vehicle), the hirer or authorized driver must report to the police and to the company within 24hours no matter
how minimal the accident is and shall supply the company with a duly completed police abstract form detailing the accident. Under no circumstances
shall the hirer accept full liability. The hirer shall make available the driver to give any statement as required by the company.

6. (a) The insurance policy covering the vehicle has been made available to the hirer hereby acknowledging that he/she and the authorized driver shall
at all times comply with the terms and conditions of that particular insurance policy.
(b) he/she shall be liable to pay the amount indicated overleaf for collision damages caused to the vehicle and or theft of the vehicle.
(c) The insurance does not cover;
1. Any loss of items from the vehicle otherwise than by collision of a damage  more than 40% of the car value
2. Any breakdown or damage to the vehicle otherwise than collision.
3. Burst tyres, stolen or lost spare parts, damaged or broken windscreen and windows or damaged rims (including the jerk and handle) tapes recorders
and radio amongst other accessories.
(d) All cars are insured but in cases whereby the damages do not reach the excess limit the hirer remains responsible for all repairs.
Important
The insurance cover (s) aforesaid are available only if the terms and conditions contained herein.
PAYMENT TERMS
I FULLY UNDERSTAND THAT;
1. MY MAXIMUM LIABILITY TO THE COMPANY IS LIMITED TO KSH:……..FOR COLLISION OR THEFT (FOR THEFT) BEING THE EXCESS PREMIUM PAYABLE
2. I SHALL BE WHOLY AND FULLY RESPONSIBLE FOR ANY DAMAGE OCCASIONED TO THE VEHICLE IF USED OR OPERATED IN VIOLATION OR BREACH OF THE TERMS AND CONDITIONS OF THIS CONTRACT AS STIPULATED.
3. I AM THE AUTHORIZED PERSON TO DRIVE THIS VEHICLE UNLESS OTHER DRIVERS ARE SPECIFIED ABOVE IN THE AGREEMENT.
"""),
              )
            ],
          ),
        ),
      ),
    );
  }
}
