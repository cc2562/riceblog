import 'package:date_format/date_format.dart';
import 'package:url_launcher/url_launcher.dart';

class allFunc{

  String ShowDateTime(String orgTimeStr){
    var timeStr = orgTimeStr+ "000";
    var time = DateTime.fromMillisecondsSinceEpoch(
      int.parse(timeStr),
    );
    String result = formatDate(time, [
      yyyy,
      '-',
      mm,
      '-',
      'dd',
      ' ',
      'HH',
      ":",
      "nn"
    ]);
    return result;
  }

}

Future<void> LaunchUrl(String url) async {
  var thurl = Uri.parse(url);
  if (!await launchUrl(thurl)) {
    throw Exception('Could not launch $thurl');
  }
}