import 'dart:convert';
import '../models/day.dart';
import '../models/dayexercise.dart';
import '../models/daywarmup.dart';
import '../models/month.dart';
import '../models/week.dart';

String monthToJson(Month month) {
  Map<String, dynamic> jsonMap = {
    '_id': month.id,
    'index': month.index,
    'title': month.title,
    'description': month.description,
    'vimeoId': month.vimeoId,
    'thumbnail': month.thumbnail,
    'startDate': month.startDate,
    'endDate': month.endDate,
    'weeks': month.weeks.map((week) => {
      'index': week.index,
      'title': week.title,
      'description': week.description,
      'restdayId': week.restdayId,
      'vimeoId': week.vimeoId,
      'thumbnail': week.thumbnail,
      'days': week.days.map((day) => {
        '_id': day.id,
        'typeId': day.typeId,
        'title': day.title,
        'vimeoId': day.vimeoId,
        'description': day.description,
        'thumbnail': day.thumbnail,
        'formats': day.formats,
        'warmups': day.warmups.map((warmup) => {
          'id': warmup.id,
          'typeId': warmup.typeId,
          'name': warmup.name,
          'guide': warmup.guide,
          'sets': warmup.sets,
          'reps': warmup.reps,
          'weight': warmup.weight,
          'duration': warmup.duration,
          'formats': warmup.formats,
        }).toList(),
        'exercises': day.exercises.map((exercise) => {
          'id': exercise.id,
          'id_': exercise.id_,
          'typeId': exercise.typeId,
          'name': exercise.name,
          'guide': exercise.guide,
          'sets': exercise.sets,
          'reps': exercise.reps,
          'rest': exercise.rest,
          'weight': exercise.weight,
          'duration': exercise.duration,
          'formats': exercise.formats,
        }).toList(),
      }).toList(),
    }).toList(),
  };

  return jsonEncode(jsonMap);
}

Month jsonToMonth(String jsonString) {
  Map<String, dynamic> jsonMap = jsonDecode(jsonString);

  List<Week> weekList = [];
  for (var weekData in jsonMap['weeks']) {
    List<Day> dayList = [];
    for (var dayData in weekData['days']) {
      List<String> formatList = List<String>.from(dayData['formats']);
      List<DayWarmup> warmupList = dayData['warmups'].map<DayWarmup>((warmupData) {
        return DayWarmup(
          id: warmupData['id'],
          typeId: warmupData['typeId'],
          name: warmupData['name'],
          guide: warmupData['guide'],
          sets: warmupData['sets'],
          reps: warmupData['reps'],
          weight: warmupData['weight'],
          duration: warmupData['duration'],
          formats: List<String>.from(warmupData['formats']),
        );
      }).toList();

      List<DayExercise> exerciseList = dayData['exercises'].map<DayExercise>((exerciseData) {
        return DayExercise(
          id: exerciseData['id'],
          id_: exerciseData['id_'],
          typeId: exerciseData['typeId'],
          name: exerciseData['name'],
          guide: exerciseData['guide'],
          sets: exerciseData['sets'],
          reps: exerciseData['reps'],
          rest: exerciseData['rest'],
          weight: exerciseData['weight'],
          duration: exerciseData['duration'],
          formats: List<String>.from(exerciseData['formats']),
        );
      }).toList();

      dayList.add(Day(
        id: dayData['_id'],
        typeId: dayData['typeId'],
        title: dayData['title'],
        vimeoId: dayData['vimeoId'],
        description: dayData['description'],
        thumbnail: dayData['thumbnail'],
        formats: formatList,
        warmups: warmupList,
        exercises: exerciseList,
      ));
    }

    weekList.add(Week(
      index: weekData['index'],
      title: weekData['title'],
      description: weekData['description'],
      restdayId: weekData['restdayId'],
      vimeoId: weekData['vimeoId'],
      thumbnail: weekData['thumbnail'],
      days: dayList,
    ));
  }

  return Month(
    id: jsonMap['_id'],
    index: jsonMap['index'],
    title: jsonMap['title'],
    description: jsonMap['description'],
    vimeoId: jsonMap['vimeoId'],
    thumbnail: jsonMap['thumbnail'],
    weeks: weekList,
    startDate: jsonMap['startDate'],
    endDate: jsonMap['endDate'],
  );
}
