import 'package:bbb/models/exercise.dart';

class DayExercise {
  DayExercise({
    required this.id,
    required this.id_,
    required this.typeId,
    required this.name,
    required this.guide,
    required this.sets,
    required this.reps,
    required this.rest,
    required this.weight,
    required this.duration,
    required this.formats,
  });

  String id;
  String id_;
  int typeId;
  String name;
  String guide;
  int sets;
  int reps;
  int rest;
  int weight;
  String duration;
  List<dynamic> formats = [];
  Exercise? execise;
}
