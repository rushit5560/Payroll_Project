import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';


class WebUrlLauncher {
  Future<void> launchPdfInBrowser(String url) async {
    log('Download Url : $url');
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}