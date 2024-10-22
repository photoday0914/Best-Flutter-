import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bbb/models/month.dart';

import '../utils/convert_util.dart';

class MonthWorkoutsManager {
  final List<Month> workoutMonths = [];
  int currentMonthIndex = -1;
  bool monthExisting = false;

  // Future<bool> isMonthExisting(dynamic newMonth) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.getString('notes_data') == null || prefs.getString('notes_data')!.isEmpty) {
  //     return false;
  //   }
  //   return true;
  // }

  Future<void> saveMonth(dynamic newMonth) async {
    debugPrint('Save Month ============ ${newMonth.index}');
    currentMonthIndex = newMonth.index;

    String monthString = monthToJson(newMonth);
    debugPrint(monthString);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('month${newMonth.index}') == null || prefs.getString('month${newMonth.index}')!.isEmpty) {
      debugPrint("No Month is here.");
      prefs.setString('month${newMonth.index}', monthString);
      monthExisting = false;
    }
    else {
      debugPrint("Month is existing.");
      monthExisting = true;
    }
  }

  Future<void> saveNewMonth(dynamic newMonth) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String monthString = monthToJson(newMonth);
    debugPrint("==============Save Month: $monthString");
    prefs.setString('month${newMonth.index}', monthString);
  }

  Future<Month> getMonth(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Month newMonth = Month(id: '', index: 1, title: '', description: '', vimeoId: '', thumbnail: '', weeks: [], startDate: '', endDate: '');

    if (!(prefs.getString('month${newMonth.index}') == null || prefs.getString('month${newMonth.index}')!.isEmpty)) {
      String monthString = prefs.getString('month${newMonth.index}')!;
      newMonth = jsonToMonth(monthString);
    }

    String monthString = monthToJson(newMonth);
    debugPrint("==============Load String: $monthString");
    return newMonth;
  }
}