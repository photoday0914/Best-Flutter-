import 'dart:convert';

import 'package:bbb/models/equipment.dart';
import 'package:bbb/models/warmup.dart';
import 'package:bbb/storage/notes_manager.dart';
import 'package:bbb/storage/userdata_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bbb/models/day.dart';
import 'package:bbb/models/dayexercise.dart';
import 'package:bbb/values/app_constants.dart';
import 'package:bbb/models/restday.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/exercise.dart';

class UserDataProvider extends ChangeNotifier {
  String selectedExerciseFormat = "A";
  String selectedExerciseFormatAlternate = "A";
  String selectedDaySplit = "3";
  int currentMonth = 1;
  int currentWeek = 1;
  int currentDay = 1;
  int currentExIndex = 1;

  int showTimerIndex = -1;

  int activeTab = 0;

  int totalCompletedDays = -1;

  late Day currentDayObj;
  WarmUp currentWarmup =
      WarmUp(id: '', title: '', vimeoId: '', description: '', equipments: []);
  RestDay currentRestDay =
      RestDay(id: '', title: '', description: '', vimeoId: '', equipments: []);
  DayExercise currentExercise = DayExercise(
      id: "",
      id_: "",
      typeId: 0,
      name: "",
      guide: "",
      sets: 0,
      reps: 0,
      rest: 0,
      weight: 0,
      duration: "",
      formats: []);

  Exercise currentExerciseObj = Exercise(
      id: "",
      title: "",
      vimeoId: "",
      thumbnail: "",
      description: "",
      guide: "",
      relatedExercises: [],
      categories: [],
      usedEquipments: []);
  late List<Exercise> currentRelatedExercises = [];
  late List<Exercise> allExercises = [];

  List<dynamic> dayHistory = [];
  List<dynamic> exerciseHistory = [];
  List<dynamic> notesData = [];
  List<dynamic> exerciseData = [];
  List<Map<String, dynamic>> dailyExercises = [];


  bool isWeekCompleted = false;
  List<String> completedExerciseIds = [];

  String userName = "";
  String userEmail = "";

  UserDataManager userManager = UserDataManager();
  NotesManager notesDataManager = NotesManager();

  void getDaySplit() async {
    bool daySplitExists = await userManager.daySplitExists();
    if (daySplitExists) {
      selectedDaySplit = await userManager.getDaySplit();
    } else {
      selectedDaySplit = "3";
      userManager.saveDaySplit("3");
    }
  }

  void changeDaySplit(String newValue) async {
    selectedDaySplit = newValue;
    notifyListeners();
    userManager.saveDaySplit(selectedDaySplit);
  }

  void setShowTimerIndex(int index) {
    showTimerIndex = index;
    notifyListeners();
  }

  void addNewNote(String newNote) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    notesData.add({
      'exercise_id': currentExercise.id,
      'date': formattedDate,
      'content': newNote,
    });
    saveNotesData();
  }

  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve the authToken from SharedPreferences
    String? authToken = prefs.getString('authToken');
    return authToken;
  }

  Future<void> loadNotesData() async {
    bool notesExists = await notesDataManager.notesDataExists();
    debugPrint("===============notesExists===============");
    debugPrint(notesExists.toString());
    if (notesExists) {
      notesData = await notesDataManager.getNotesData();
      notifyListeners();
    }
  }

  void saveNotesData() {
    notesDataManager.saveNotesData(notesData);
    notifyListeners();
  }

  void updateCurrentExercise(DayExercise newExercise) {
    currentExercise = newExercise;
    notifyListeners();
  }

  void completeExercise(String exerciseID) {
    completedExerciseIds.add(exerciseID);
    notifyListeners();
  }

  void completeCurrentExercise() {
    completedExerciseIds.add(currentExercise?.id ?? "");
    notifyListeners();
  }

  String getCurrentDayState() {
    for (dynamic history in dayHistory) {
      if (int.parse((history['monthIndex']).toString()) == currentMonth &&
          int.parse((history['weekIndex']).toString()) == currentWeek &&
          history['daySplit'] == selectedDaySplit &&
          history['dayIndex'] == currentDay.toString()) {
        return history['state'];
      }
    }
    return AppConstants.STATE_NOT_STARTED;
  }

  void updateOrAddDayHistory(String stateString) {
    if (dayHistory.any((history) =>
        int.parse((history['monthIndex']).toString()) == currentMonth &&
        int.parse((history['weekIndex']).toString()) == currentWeek &&
        history['daySplit'] == selectedDaySplit &&
        history['dayIndex'] == currentDay.toString())) {
      dayHistory = dayHistory.map((history) {
        if (int.parse((history['monthIndex']).toString()) == currentMonth &&
            int.parse((history['weekIndex']).toString()) == currentWeek &&
            history['daySplit'] == selectedDaySplit &&
            history['dayIndex'] == currentDay.toString()) {
          history['state'] = stateString;
        }
        return history;
      }).toList();
    } else {
      final Map<String, String> queryParams = {
        'monthIndex': currentMonth.toString(),
        'weekIndex': currentWeek.toString(),
        'daySplit': selectedDaySplit,
        'dayIndex': currentDay.toString(),
        'state': stateString,
      };

      dayHistory.add(queryParams);
    }

    userManager.saveDayHistory(dayHistory);
    notifyListeners();
  }

  void updateOrAddExerciseData(int exerciseIndex, int setIndex, int weight,
      int reps, int repsInReverse) {
    debugPrint(
        "Exercise Save ============== ${exerciseIndex} ${setIndex} ${weight} ${reps} ${repsInReverse}");
    if (exerciseData.any((data) =>
        int.parse((data['monthIndex']).toString()) == currentMonth &&
        int.parse((data['weekIndex']).toString()) == currentWeek &&
        data['daySplit'].toString() == selectedDaySplit &&
        data['gymAccess'].toString() == selectedExerciseFormatAlternate &&
        data['exerciseIndex'].toString() == exerciseIndex.toString() &&
        data['setIndex'].toString() == setIndex.toString() &&
        data['dayIndex'].toString() == currentDay.toString())) {
      exerciseData = exerciseData.map((data) {
        if (int.parse((data['monthIndex']).toString()) == currentMonth &&
            int.parse((data['weekIndex']).toString()) == currentWeek &&
            data['daySplit'].toString() == selectedDaySplit &&
            data['gymAccess'].toString() == selectedExerciseFormatAlternate &&
            data['dayIndex'].toString() == currentDay.toString() &&
            data['exerciseIndex'].toString() == exerciseIndex.toString() &&
            data['setIndex'].toString() == setIndex.toString()) {
          data['weight'] = weight.toString();
          data['reps'] = reps.toString();
          data['repsInReverse'] = repsInReverse.toString();
        }
        return data;
      }).toList();
    } else {
      final Map<String, String> queryParams = {
        'monthIndex': currentMonth.toString(),
        'weekIndex': currentWeek.toString(),
        'daySplit': selectedDaySplit,
        'gymAccess': selectedExerciseFormatAlternate,
        'dayIndex': currentDay.toString(),
        'exerciseIndex': exerciseIndex.toString(),
        'setIndex': setIndex.toString(),
        'weight': weight.toString(),
        'reps': reps.toString(),
        'repsInReverse': repsInReverse.toString(),
      };

      exerciseData.add(queryParams);
    }

    userManager.saveExerciseData(exerciseData);
    notifyListeners();
  }

  Future<int> calculateTotalWeightForDay() async {
    List<dynamic> exerciseData = [];  

    bool exerciseDataExists = await userManager.exerciseDataExists();
    
    if (exerciseDataExists) {
      exerciseData = await userManager.getExerciseData();
    }

    int totalWeight = 0;
    debugPrint("============calcul${exerciseData}============");
    debugPrint("============calcul$exerciseData============");
    // Filter exercise data for the given day, week, and month
    dailyExercises = exerciseData.where((data) =>
      int.parse(data['dayIndex'].toString()) == currentDay &&
      int.parse(data['monthIndex'].toString()) == currentMonth &&
      int.parse(data['weekIndex'].toString()) == currentWeek &&
      data['daySplit'].toString() == selectedDaySplit &&
      data['gymAccess'].toString() == selectedExerciseFormatAlternate
    )    
    .cast<Map<String, dynamic>>()
    .toList();
    debugPrint("============calcul${dailyExercises}============");
    debugPrint("============calcul$dailyExercises============");
    // Iterate over the filtered data and calculate total weight
    for (var exercise in dailyExercises) {
      int weight = int.parse(exercise['weight']);
      int reps = int.parse(exercise['reps']);
      int sets = 1; // Each entry represents a set, so set multiplier is 1
      
      totalWeight += weight * reps * sets;
    }
    debugPrint("============calcul${totalWeight}============");
    debugPrint("============calcul$totalWeight============");
    return totalWeight;
    // return 30;
  }


  void removeExerciseDataById(int exerciseIndexToRemove) {
    debugPrint(
        "Removing exercise data for exerciseIndex: $exerciseIndexToRemove");

    exerciseData.removeWhere((data) =>
        int.parse(data['exerciseIndex'].toString()) == exerciseIndexToRemove &&
        int.parse(data['monthIndex'].toString()) == currentMonth &&
        int.parse(data['weekIndex'].toString()) == currentWeek &&
        data['daySplit'].toString() == selectedDaySplit &&
        data['gymAccess'].toString() == selectedExerciseFormatAlternate &&
        data['dayIndex'].toString() == currentDay.toString());

    userManager.saveExerciseData(exerciseData);

    notifyListeners();
  }

  loadUserInfo() {
    getDaySplit();
    loadNotesData();
    fetchUserInfo();
  }

  Future<Map<String, dynamic>> fetchUserInfo() async {
    Uri url = Uri.parse('${AppConstants.serverUrl}/api/users/get_user');
    String? token = await getAuthToken();
    print('XXXXXXurl $url $token');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'AUTH_TOKEN': token ?? "",
    });

    print('XXXXXX############# success');
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      getUserDataFromJson(jsonDecode(response.body));
      notifyListeners();
      return jsonDecode(response.body);
    } else {
      print('XXXXXX############# false');

      throw Exception('Failed to load user data');
    }
  }

  Future<void> updateUserInfo(
      String? id, Map<String, dynamic> userDetails) async {
    Uri url = Uri.parse('${AppConstants.serverUrl}/api/users/$id');
    String? userIdToken = await getAuthToken();
    final response = await http.put(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'AUTH_TOKEN': userIdToken ?? "",
        },
        body: jsonEncode(userDetails));

    if (response.statusCode == 200) {
      print('User data updated successfully');
    } else {
      throw Exception('Failed to update user data: ${response.body}');
    }
  }

  void fetchWarmUp(String warmUpId) async {
    debugPrint('=========${warmUpId}===========');
    Uri url = Uri.parse('${AppConstants.serverUrl}/api/warmups/get/$warmUpId');
    url = Uri.http(url.authority, url.path);
    String? userIdToken = await FirebaseAuth.instance.currentUser?.getIdToken();

    debugPrint("fetch Current WarmUp");
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'FIREBASE_AUTH_TOKEN': userIdToken ?? "",
      },
    );

    if (response.statusCode == 200) {
      debugPrint('========Fetch Warm Up Result ============ ${response.body}');
      dynamic responseData = jsonDecode(response.body);

      currentWarmup = WarmUp(
        id: responseData["_id"],
        title: responseData["title"],
        vimeoId: responseData["vimeoId"],
        description: responseData["description"],
        equipments: responseData["equipments"],
      );

      notifyListeners();
    } else {
      throw Exception('Failed to load exercise info');
    }
  }

  void fetchRestDay(String restDayId) async {
    Uri url =
        Uri.parse('${AppConstants.serverUrl}/api/restdays/get/$restDayId');
    url = Uri.http(url.authority, url.path);
    String? userIdToken = await FirebaseAuth.instance.currentUser?.getIdToken();

    debugPrint("fetch Current RestDay");
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'FIREBASE_AUTH_TOKEN': userIdToken ?? "",
      },
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      dynamic responseData = jsonDecode(response.body);
      currentRestDay = RestDay(
        id: responseData["id"],
        title: responseData["title"],
        description: responseData["description"],
        vimeoId: responseData["vimeoId"],
        equipments: responseData["equipments"],
      );

      notifyListeners();
    } else {
      throw Exception('Failed to load exercise info');
    }
  }

  Future fetchAllExercise() async {
    final Map<String, String> queryParams = {
      'page': '1',
      'perPage': '10',
      'search': '',
      'sortBy': '',
    };

    Uri url = Uri.parse('${AppConstants.serverUrl}/api/exercises/get');
    url = Uri.http(url.authority, url.path, queryParams);
    String? userIdToken = await getAuthToken();

    debugPrint("fetch All Exercise");
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'AUTH_TOKEN': userIdToken ?? "",
      },
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      getExercisesFromJson(jsonDecode(response.body));
      notifyListeners();
    } else {
      throw Exception('Failed to load exercise info');
    }
  }

  Future fetchCurrentEx(String id) async {
    Uri url = Uri.parse('${AppConstants.serverUrl}/api/exercises/get/$id');
    debugPrint(url.toString());
    url = Uri.http(url.authority, url.path);
    String? userIdToken = await getAuthToken();

    debugPrint("fetch Current Exercise");
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'AUTH_TOKEN': userIdToken ?? "",
      },
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      getExerciseFromJson(jsonDecode(response.body));
      setShowTimerIndex(-1);
      notifyListeners();
    } else {
      throw Exception('Failed to load exercise info');
    }
  }

  void getExercisesFromJson(responseData) {
    allExercises.clear();

    for (var singleItem in responseData["exercises"]) {
      Exercise newExercise = Exercise(
        id: singleItem["_id"] ?? "",
        title: singleItem["title"] ?? "",
        vimeoId: singleItem["vimeoId"] ?? "",
        thumbnail: singleItem["thumbnail"] ?? "",
        description: singleItem["description"] ?? "",
        guide: singleItem["guide"] ?? "",
        relatedExercises: singleItem["relatedExercises"] ?? [],
        categories: singleItem["categories"] ?? [],
        usedEquipments: singleItem["usedEquipments"] ?? [],
      );

      allExercises.add(newExercise);
    }

    notifyListeners();
  }

  void getExerciseFromJson(responseData) {
    currentRelatedExercises.clear();
    List<Equipment> equipments = [];

    debugPrint(
        '=============response for related Exercises ${responseData.toString()}');

    for (var singleItem in responseData["relatedExercises"]) {
      Exercise newExercise = Exercise(
        id: singleItem["id"] ?? "",
        title: singleItem["title"] ?? "",
        vimeoId: singleItem["vimeoId"] ?? "",
        thumbnail: singleItem["thumbnail"] ?? "",
        description: singleItem["description"] ?? "",
        guide: singleItem["guide"] ?? "",
        relatedExercises: singleItem["relatedExercises"] ?? [],
        categories: singleItem["categories"] ?? [],
        usedEquipments: singleItem["usedEquipments"] ?? [],
      );

      currentRelatedExercises.add(newExercise);
    }

    for (var singleItem in responseData["usedEquipments"]) {
      Equipment newEquipment = Equipment(
        id: singleItem["id"] ?? "",
        title: singleItem["title"] ?? "",
        thumbnail: singleItem["thumbnail"] ?? "",
        description: singleItem["description"] ?? "",
        link: singleItem["link"] ?? "",
      );
      equipments.add(newEquipment);
    }

    Exercise exerciseObj = Exercise(
      id: responseData["id"] ?? "",
      title: responseData["title"] ?? "",
      vimeoId: responseData["vimeoId"] ?? "",
      thumbnail: responseData["thumbnail"] ?? "",
      description: responseData["description"] ?? "",
      guide: responseData["guide"] ?? "",
      relatedExercises: currentRelatedExercises,
      categories: responseData["categories"] ?? [],
      usedEquipments: equipments,
    );

    currentExerciseObj = exerciseObj;

    notifyListeners();
  }

  Future<void> getUserDataFromJson(responseData) async {
    userName = responseData["name"];
    userEmail = responseData["email"];
    // dayHistory = responseData["dayHistory"];
    // exerciseHistory = responseData["workoutsHistory"];

    notifyListeners();

    debugPrint("totalCompletedDays: $totalCompletedDays");
    debugPrint("name: $userName");
    debugPrint("email: $userEmail");

    bool dayHistoryExists = await userManager.dayHistoryExists();
    bool exerciseHistoryExists = await userManager.exerciseHistoryExists();
    bool exerciseDataExists = await userManager.exerciseDataExists();
    if (dayHistoryExists) {
      dayHistory = await userManager.getDayHistory();
    }
    if (exerciseHistoryExists) {
      exerciseHistory = await userManager.getExerciseHistory();
    }
    if (exerciseDataExists) {
      exerciseData = await userManager.getExerciseData();
    }

    totalCompletedDays = dayHistory
        .where((day) =>
            day['monthIndex'].toString() == currentMonth.toString() &&
            day['state'].toString() == AppConstants.STATE_FINISHED &&
            day['daySplit'].toString() == selectedDaySplit)
        .length;

    debugPrint("exerciseHistory: $exerciseHistory");
  }

  void finishCurrentWarmUp() async {
    debugPrint("=============  exerciseDone  ============");

    final Map<String, String> queryParams = {
      'monthIndex': currentMonth.toString(),
      'weekIndex': currentWeek.toString(),
      // 'dayId': currentDayObj.id ?? "",
      // 'exerciseId': currentExercise.id ?? "",
      'dayIndex': currentDay.toString(),
      'daySplit': selectedDaySplit,
      'gymAccess': selectedExerciseFormatAlternate,
      'exerciseIndex': "warmup",
      'state': AppConstants.STATE_FINISHED,
    };

    if (exerciseHistory.any((history) =>
        int.parse((history['monthIndex']).toString()) == currentMonth &&
        int.parse((history['weekIndex']).toString()) == currentWeek &&
        history['daySplit'].toString() == selectedDaySplit &&
        history['gymAccess'].toString() == selectedExerciseFormatAlternate &&
        history['dayIndex'].toString() == currentDay.toString() &&
        (history['exerciseIndex'].toString() == currentExIndex.toString() ||
            history['exerciseIndex'].toString() == "warmup"))) {
      return;
    }

    exerciseHistory.add(queryParams);
    userManager.saveExerciseHistory(exerciseHistory);
    notifyListeners();
  }

  void finishCurrentExercise() async {
    debugPrint("=============  exerciseDone  ============");

    final Map<String, String> queryParams = {
      'monthIndex': currentMonth.toString(),
      'weekIndex': currentWeek.toString(),
      'dayIndex': currentDay.toString(),
      'daySplit': selectedDaySplit,
      'gymAccess': selectedExerciseFormatAlternate,
      'exerciseIndex': currentExIndex.toString(),
      'state': AppConstants.STATE_FINISHED,
    };

    if (exerciseHistory.any((history) =>
        int.parse((history['monthIndex']).toString()) == currentMonth &&
        int.parse((history['weekIndex']).toString()) == currentWeek &&
        history['daySplit'].toString() == selectedDaySplit &&
        history['gymAccess'].toString() == selectedExerciseFormatAlternate &&
        history['dayIndex'].toString() == currentDay.toString() &&
        history['exerciseIndex'].toString() == currentExIndex.toString())) {
      return;
    }

    exerciseHistory.add(queryParams);
    userManager.saveExerciseHistory(exerciseHistory);
    notifyListeners();

    // Uri url = Uri.parse('${AppConstants.serverUrl}/api/users/exercise_done');
    // url = Uri.http(url.authority, url.path, queryParams);
    //
    // String? userIdToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    // final response = await http.post(
    //   url,
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //     'FIREBASE_AUTH_TOKEN': userIdToken ?? "",
    //   },
    //   body: jsonEncode(queryParams),
    // );
    //
    // if (response.statusCode == 200) {
    //   debugPrint(queryParams.toString());
    //
    //   exerciseHistory.add(queryParams);
    //
    //   if (jsonDecode(response.body)["result"] == true) {
    //     // completeCurrentExercise();
    //   }
    //   notifyListeners();
    // } else {
    //   throw Exception('Failed to load exercise info');
    // }
  }

  void updateOrAddExerciseHistory(String stateString) async {
    if (exerciseHistory.any((history) =>
        int.parse((history['monthIndex']).toString()) == currentMonth &&
        int.parse((history['weekIndex']).toString()) == currentWeek &&
        history['daySplit'].toString() == selectedDaySplit &&
        history['gymAccess'].toString() == selectedExerciseFormatAlternate &&
        history['dayIndex'].toString() == currentDay.toString() &&
        history['exerciseIndex'].toString() == currentExIndex.toString())) {
      exerciseHistory = exerciseHistory.map((history) {
        if (int.parse((history['monthIndex']).toString()) == currentMonth &&
            int.parse((history['weekIndex']).toString()) == currentWeek &&
            history['daySplit'].toString() == selectedDaySplit &&
            history['gymAccess'].toString() ==
                selectedExerciseFormatAlternate &&
            history['dayIndex'].toString() == currentDay.toString() &&
            history['exerciseIndex'].toString() == currentExIndex.toString()) {
          history['state'] = stateString;
        }
        return history;
      }).toList();
    } else {
      final Map<String, String> queryParams = {
        'monthIndex': currentMonth.toString(),
        'weekIndex': currentWeek.toString(),
        'dayIndex': currentDay.toString(),
        'daySplit': selectedDaySplit,
        'gymAccess': selectedExerciseFormatAlternate,
        'exerciseIndex': currentExIndex.toString(),
        'state': stateString,
      };

      exerciseHistory.add(queryParams);
    }

    userManager.saveExerciseHistory(exerciseHistory);
    notifyListeners();
  }

  Future finishCurrentDay() async {
    debugPrint("=============  dayDone  ============");

    updateOrAddDayHistory(AppConstants.STATE_FINISHED);

    final Map<String, String> queryParams = {
      'monthIndex': currentMonth.toString(),
      'weekIndex': currentWeek.toString(),
      'daySplit': selectedDaySplit,
      'dayIndex': currentDay.toString(),
    };

    debugPrint('======== to Save ${queryParams.toString()}');

    if (dayHistory.any((history) =>
        int.parse((history['monthIndex']).toString()) == currentMonth &&
        int.parse((history['weekIndex']).toString()) == currentWeek &&
        history['daySplit'] == selectedDaySplit &&
        history['dayIndex'] == currentDay.toString())) {
      return;
    }

    debugPrint(queryParams.toString());

    Uri url = Uri.parse('${AppConstants.serverUrl}/api/users/day_done');
    url = Uri.http(url.authority, url.path, queryParams);

    String? userIdToken = await getAuthToken();
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'AUTH_TOKEN': userIdToken ?? "",
      },
      body: jsonEncode(queryParams),
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      if (jsonDecode(response.body)["result"] == true) {
        // completeCurrentExercise();
      }
      notifyListeners();
    } else {
      throw Exception('Failed to load exercise info');
    }
  }
}
