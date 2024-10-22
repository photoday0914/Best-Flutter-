class Week {
  Week({
    required this.index,
    required this.title,
    required this.description,
    required this.vimeoId,
    required this.thumbnail,
    required this.restdayId,
    required this.days,
  });

  int index;
  String title;
  String description;
  String vimeoId;
  String restdayId;
  String thumbnail;
  List<dynamic> days = [];
}
