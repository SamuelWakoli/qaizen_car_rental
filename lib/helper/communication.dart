import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall() async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: "+254726371714",
  );
  await launchUrl(launchUri);
}

Future<void> openWhatsApp() async {
  final uri = Uri.parse("https://wa.me/254726371714");
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    // can't launch url
  }
}
