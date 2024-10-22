class WarmUp {
  WarmUp({
    required this.id,
    required this.title,
    required this.vimeoId,
    required this.description,
    required this.equipments,
  });

  String id;
  String title;
  String vimeoId;
  String description;
  List<dynamic> equipments = [];
}
