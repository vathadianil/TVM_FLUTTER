import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';

class THelperFunctions {
  static const monthToNumberMap = {
    "JAN": '01',
    "FEB": '02',
    "MAR": '03',
    "APR": '04',
    "MAY": '05',
    "JUN": '06',
    "JUL": '07',
    "AUG": '08',
    "SEP": '09',
    "OCT": '10',
    "NOV": '11',
    "DEC": '12'
  };
  static Color? getColor(String value) {
    /// Define your product specific colors here and it will match the attribute colors and show specific 🟠🟡🟢🔵🟣🟤

    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.deepOrange;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Teal') {
      return Colors.teal;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else {
      return null;
    }
  }

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showAlert(String title, String message, Function callbackFun,
      {dismisable = false}) {
    showDialog(
      context: Get.context!,
      barrierDismissible: dismisable,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                callbackFun();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  static String getFormattedDateTime1(DateTime date,
      {String format = 'dd MMM yyyy hh:mm'}) {
    return DateFormat(format).format(date);
  }

  static String getFormattedDateTime(String date,
      {String currentDateFormat = 'yyyy-MM-dd HH:mm:ss',
      String targetDateFormat = 'dd-MM-yyyy HH:mm:ss'}) {
    DateFormat dateFormat = DateFormat(currentDateFormat);
    DateTime dateTime = dateFormat.parse(date);
    return DateFormat(targetDateFormat).format(dateTime);
  }

  static String getFormattedDateTimeString(String dateString) {
    final day = dateString.substring(0, 2);
    final month = dateString.substring(2, 4);
    final year = dateString.substring(4, 8);
    final hours = dateString.substring(8, 10);
    final minutes = dateString.substring(10, 12);
    final seconds = dateString.substring(12, 14);
    return '$day-$month-$year $hours:$minutes:$seconds';
  }

  static String getFormattedDateTimeString1(String dateString) {
    final year = dateString.substring(0, 4);
    final month = dateString.substring(4, 6);
    final day = dateString.substring(6, 8);
    final hours = dateString.substring(8, 10);
    final minutes = dateString.substring(10, 12);
    final seconds = dateString.substring(12, 14);
    return '$day-$month-$year $hours:$minutes:$seconds';
  }

  static String getFormattedDateTimeString2(String dateTimeString) {
    // Original DateTime string
    String convertedDateTimeString = dateTimeString.split('+')[0];
    // Parse the string to a DateTime object
    DateTime dateTime = DateTime.parse(convertedDateTimeString);
    // Format the DateTime object
    String formattedDate = DateFormat('dd-MMM-yyyy hh:mm:ss').format(dateTime);
    return formattedDate;
  }

  static String getFormattedDateString1(String dateString) {
    final year = dateString.substring(2, 4);
    final month = dateString.substring(4, 6);
    final day = dateString.substring(6, 8);
    return '$day/$month/$year';
  }

  static String getFormattedDateString2(String dateString) {
    final year = dateString.substring(0, 4);
    final month = dateString.substring(4, 6);
    final day = dateString.substring(6, 8);
    return '$day/$month/$year';
  }

  static String getFormattedDateString(String dateString) {
    final day = dateString.substring(0, 2);
    final month = monthToNumberMap[dateString.substring(3, 6)];
    final year = dateString.substring(7, 11);
    return '$day-$month-$year';
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

  static StationListModel getStationFromStationId(
      String stationId, List<StationListModel> stationList) {
    final station =
        stationList.firstWhere((station) => station.stationId == stationId);
    return station;
  }

  static StationListModel getStationFromStationName(
      String stationName, List<StationListModel> stationList) {
    final station =
        stationList.firstWhere((station) => station.name == stationName);
    return station;
  }

  static DateTime parsedDateTime(String dateSting, timeString) {
    final dateString = getFormattedDateString(dateSting);
    final timString = timeString;
    return DateFormat('dd-MM-yyyy hh:mm a').parse('$dateString $timString');
  }
}
