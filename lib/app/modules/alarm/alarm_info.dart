class AlarmInfo {
  int id;
  String title;
  DateTime alarmDateTime;
  int isPending;
  String dayTime;
  String music;
  AlarmInfo(
      {this.id,
        this.title,
        this.alarmDateTime,
        this.isPending,
        this.dayTime,
        this.music
      });

  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
    id: json["id"],
    title: json["title"],
    alarmDateTime: DateTime.parse(json["alarmDateTime"]),
    isPending: json["isPending"],
    dayTime: json["dayTime"],
    music: json["music"]
  );
  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "alarmDateTime": alarmDateTime.toIso8601String(),
    "isPending": isPending,
    "dayTime": dayTime,
    "music": music
  };
}