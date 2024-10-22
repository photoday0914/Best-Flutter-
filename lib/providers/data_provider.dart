import 'dart:convert';

import 'package:bbb/storage/exercise_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bbb/models/day.dart';
import 'package:bbb/models/dayexercise.dart';
import 'package:bbb/models/daywarmup.dart';
import 'package:bbb/models/month.dart';
import 'package:bbb/models/week.dart';
import 'package:bbb/values/app_constants.dart';
import 'package:http/http.dart' as http;

class DataProvider extends ChangeNotifier {
  Month original = Month(
      id: '',
      index: 1,
      title: '',
      description: '',
      vimeoId: '',
      thumbnail: '',
      weeks: [],
      startDate: '',
      endDate: '');
  Month workout = Month(
      id: '',
      index: 1,
      title: '',
      description: '',
      vimeoId: '',
      thumbnail: '',
      weeks: [],
      startDate: '',
      endDate: '');
  bool dataLoaded = false;
  int totalDays = 1;
  MonthWorkoutsManager monthManager = MonthWorkoutsManager();

  loadMonthWorkouts() {}

  Future<void> removeExerciseById(
      int currentWeek, int currentDay, String exerciseID) async {
    original = workout;
    Month newWorkouts = Month(
      id: original.id,
      index: original.index,
      title: original.title,
      description: original.description,
      vimeoId: original.vimeoId,
      thumbnail: original.thumbnail,
      startDate: original.startDate,
      endDate: original.endDate,
      weeks: original.weeks.map((week) {
        if (week.index == currentWeek) {
          return Week(
            index: week.index,
            title: week.title,
            restdayId: week.restdayId,
            description: week.description,
            vimeoId: week.vimeoId,
            thumbnail: week.thumbnail,
            days: week.days.map((dynamic day) {
              if ((day as Day).typeId == currentDay) {
                return Day(
                  id: day.id,
                  typeId: day.typeId,
                  title: day.title,
                  vimeoId: day.vimeoId,
                  description: day.description,
                  thumbnail: day.thumbnail,
                  formats: day.formats,
                  warmups: day.warmups,
                  exercises: day.exercises
                      .where((exercise) =>
                          (exercise as DayExercise).id != exerciseID)
                      .toList(),
                );
              }
              return day;
            }).toList(),
          );
        }
        return week;
      }).toList(),
    );

    await monthManager.saveNewMonth(newWorkouts);
    workout = await monthManager.getMonth(original.index);

    notifyListeners();
  }

  Future<void> swapExerciseById(
      int currentWeek,
      int currentDay,
      int selectedIndex,
      String exerciseID,
      String newName,
      String targetExerciseID) async {
    debugPrint(
        '======== Swap Exercise ID $currentWeek $currentDay $selectedIndex $exerciseID $newName $targetExerciseID');
    original = workout;
    Month newWorkouts = Month(
      id: original.id,
      index: original.index,
      title: original.title,
      description: original.description,
      vimeoId: original.vimeoId,
      thumbnail: original.thumbnail,
      startDate: original.startDate,
      endDate: original.endDate,
      weeks: original.weeks.map((week) {
        if (week.index == currentWeek) {
          return Week(
            index: week.index,
            title: week.title,
            restdayId: week.restdayId,
            description: week.description,
            vimeoId: week.vimeoId,
            thumbnail: week.thumbnail,
            days: week.days.map((dynamic day) {
              if (day is Day && day.typeId == currentDay) {
                List exercises = day.exercises;
                int exerciseIndex = exercises
                    .indexWhere((exercise) => exercise.id == exerciseID);

                if (exerciseIndex != -1) {
                  exercises[exerciseIndex].name = newName;
                  exercises[exerciseIndex].id = targetExerciseID;
                }

                return Day(
                  id: day.id,
                  typeId: day.typeId,
                  title: day.title,
                  vimeoId: day.vimeoId,
                  description: day.description,
                  thumbnail: day.thumbnail,
                  formats: day.formats,
                  warmups: day.warmups,
                  exercises: exercises,
                );
              }
              return day;
            }).toList(),
          );
        }
        return week;
      }).toList(),
    );

    await monthManager.saveNewMonth(newWorkouts);
    workout = await monthManager.getMonth(original.index);

    notifyListeners();
  }

  Future<void> addExerciseById(
      int currentWeek, int currentDay, DayExercise newExercise) async {
    original = workout;
    Month newWorkouts = Month(
      id: original.id,
      index: original.index,
      title: original.title,
      description: original.description,
      vimeoId: original.vimeoId,
      thumbnail: original.thumbnail,
      startDate: original.startDate,
      endDate: original.endDate,
      weeks: original.weeks.map((week) {
        if (week.index == currentWeek) {
          return Week(
            index: week.index,
            title: week.title,
            restdayId: week.restdayId,
            description: week.description,
            vimeoId: week.vimeoId,
            thumbnail: week.thumbnail,
            days: week.days.map((dynamic day) {
              if ((day as Day).typeId == currentDay) {
                List exercises = day.exercises;
                exercises.add(newExercise);

                debugPrint('length ======= ${exercises.length.toString()}');

                return Day(
                  id: day.id,
                  typeId: day.typeId,
                  title: day.title,
                  vimeoId: day.vimeoId,
                  description: day.description,
                  thumbnail: day.thumbnail,
                  formats: day.formats,
                  warmups: day.warmups,
                  exercises: exercises,
                );
              }
              return day;
            }).toList(),
          );
        }
        return week;
      }).toList(),
    );

    await monthManager.saveNewMonth(newWorkouts);
    workout = await monthManager.getMonth(original.index);

    notifyListeners();
  }

  void filter(String gymAccess, String daySplit) {
    workout = Month(
      id: original.id,
      index: original.index,
      title: original.title,
      description: original.description,
      vimeoId: original.vimeoId,
      thumbnail: original.thumbnail,
      startDate: original.startDate,
      endDate: original.endDate,
      weeks: original.weeks.map((week) {
        return Week(
          index: week.index,
          title: week.title,
          restdayId: week.restdayId,
          description: week.description,
          vimeoId: week.vimeoId,
          thumbnail: week.thumbnail,
          days: week.days
              // .where((dynamic day) =>
              // (day as Day).formats.contains(daySplit)) // Cast to Day
              .map((dynamic day) {
            return Day(
              id: day.id,
              typeId: (day as Day).typeId,
              title: day.title,
              vimeoId: day.vimeoId,
              description: day.description,
              thumbnail: day.thumbnail,
              formats: day.formats,
              warmups: day.warmups,
              exercises: day.exercises
                  .where((dynamic exercise) => (exercise as DayExercise)
                      .formats
                      .contains(gymAccess)) // Cast to DayExercise
                  .toList(),
              // exerciseTypeCnt: day.exerciseTypeCnt,
            );
          }).toList(),
        );
      }).toList(),
    );

    notifyListeners();
  }

  void clearAll() {
    original = workout;
    workout = Month(
        id: '',
        index: 1,
        title: '',
        description: '',
        vimeoId: '',
        thumbnail: '',
        weeks: [],
        startDate: '',
        endDate: '');
    notifyListeners();
  }

  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve the authToken from SharedPreferences
    String? authToken = prefs.getString('authToken');
    return authToken;
  }

  Future fetchMonthWorkouts(int month) async {
    // dataLoaded = false;
    debugPrint("=============${monthManager.currentMonthIndex}===============");
    if (monthManager.currentMonthIndex != -1) {
      workout = await monthManager.getMonth(monthManager.currentMonthIndex);
      return;
    }

    Month monthInfo;
    print("fetch Current Month");
    final Map<String, String> queryParams = {
      'month': month.toString(),
      'equipment': '0',
      'split': '5',
    };
    Uri url = Uri.parse('${AppConstants.serverUrl}/api/workouts/current');
    url = Uri.http(url.authority, url.path, queryParams);

    String? userIdToken = await getAuthToken();
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'AUTH_TOKEN': userIdToken ?? "",
      },
    );
    if (response.statusCode == 200) {
      await getMonthInfoFromJson(jsonDecode(response.body));
      notifyListeners();
    } else {
      throw Exception('Failed to load exercise info');
    }
  }

  Future<void> getMonthInfoFromJson(Map<String, dynamic> responseData) async {
    totalDays = 0;

    List<Week> weekList = [];
    for (var singleinfo in responseData["weeks"]) {
      List<Day> dayList = [];
      for (var singleDayinfo in singleinfo["days"]) {
        List<String> formatList = [];
        List<DayWarmup> warmupList = [];
        List<DayExercise> exerciseList = [];

        // Default to empty string if singleFormatInfo is null
        for (var singleFormatInfo in singleDayinfo["formats"]) {
          String formatInfo =
              singleFormatInfo ?? ""; // CHANGE: Improved null handling
          formatList.add(formatInfo);
        }

        // Improved null handling for warmups
        for (var singleWarmUpInfo in singleDayinfo["warmups"]) {
          DayWarmup warmupInfo = DayWarmup(
            id: singleWarmUpInfo["warmupId"] ??
                "1", // CHANGE: Set default to "1" for warmupId
            typeId: singleWarmUpInfo["typeId"] ?? 1,
            name: singleWarmUpInfo["name"] ?? "",
            guide: singleWarmUpInfo["guide"] ?? "",
            sets: singleWarmUpInfo["sets"] ?? 0,
            reps: singleWarmUpInfo["reps"] ?? 0,
            weight: singleWarmUpInfo["weight"] ??
                "", // CHANGE: Retained the original type, but consider using an int
            duration: singleWarmUpInfo["duration"] ?? "",
            formats: singleWarmUpInfo["formats"] ?? [],
          );
                warmupList.add(warmupInfo);
            }
        int index = 1; // Changed to int for better readability
        // Improved null handling for exercises
        for (var singleExerciseInfo in singleDayinfo["exercises"]) {
          DayExercise exerciseInfo = DayExercise(
            id: singleExerciseInfo["exerciseId"] ??
                "", // CHANGE: Default to empty string if null
            id_: singleExerciseInfo["id_"] ??
                "", // CHANGE: Default to empty string if null
            typeId: singleExerciseInfo["typeId"] ?? 1,
            name: singleExerciseInfo["name"] ??
                "Exercise $index", // CHANGE: Default name if null
            guide: singleExerciseInfo["guide"] ?? "",
            sets: singleExerciseInfo["sets"] ?? 0,
            reps: singleExerciseInfo["reps"] ?? 0,
            rest: singleExerciseInfo["rest"] ?? 0,
            weight: singleExerciseInfo["weight"] ??
                0, // CHANGE: Set default to 0 for numeric type
            duration: singleExerciseInfo["duration"] ?? "",
            formats: singleExerciseInfo["formats"] ?? [],
          );

          exerciseList.add(exerciseInfo);
          index++; // Changed to increment within the loop for clarity
        }

        Day dayInfo = Day(
          id: singleDayinfo["_id"] ??
              "", // CHANGE: Default to empty string if null
          typeId: singleDayinfo["typeId"] ?? 1,
          title: singleDayinfo["title"] ?? "",
          vimeoId: singleDayinfo["vimeoId"] ?? "",
          description: singleDayinfo["description"] ?? "",
          thumbnail: singleDayinfo["thumbnail"] ?? "",
          formats: formatList,
          warmups: warmupList,
          exercises: exerciseList,
        );

        dayList.add(dayInfo);
        totalDays++; // Increment total days
      }

      Week weekInfo = Week(
        index: singleinfo["index"] ?? 0, // CHANGE: Default to 0 if null
        title: singleinfo["title"] ?? "",
        description: singleinfo["description"] ?? "",
        restdayId: singleinfo["restdayId"] ?? "",
        vimeoId: singleinfo["vimeoId"] ?? "",
        thumbnail: singleinfo["thumbnail"] ?? "",
        days: dayList,
      );

      weekList.add(weekInfo);
    }

    Month newMonth = Month(
      id: responseData["_id"] ?? "", // CHANGE: Default to empty string if null
      index: responseData["index"] ?? 1,
      title: responseData["title"] ?? "",
      description: responseData["description"] ?? "",
      vimeoId: responseData["vimeoId"] ?? "",
      thumbnail: responseData["thumbnail"] ?? "",
      weeks: weekList,
      startDate: responseData["startDate"] ??
          "", // CHANGE: Default to empty string if null
      endDate: responseData["endDate"] ??
          "", // CHANGE: Default to empty string if null
    );

    if (!monthManager.monthExisting) {
      await monthManager
          .saveMonth(newMonth); // Save new month only if it doesn't exist
    }

    // Change in workout assignment logic
    if (monthManager.monthExisting) {
      debugPrint('============ Month Index True ${newMonth.index.toString()}');
      workout = await monthManager
          .getMonth(newMonth.index); // Retrieve existing month
    } else {
      debugPrint('============ Month Index False ${newMonth.index.toString()}');
      workout = newMonth; // Use the new month if it doesn't exist
    }

    notifyListeners(); // Notify listeners of changes
  }
}