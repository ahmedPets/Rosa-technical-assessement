import 'dart:convert';

String toJson(List<Slot> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson)));

class Slot {
  Slot({
    required this.id,
    // required this.eventIds,
    required this.motiveIds,
    // required this.calendarId,
    // required this.nextAvailabilityId,
    // required this.previousAvailabilityId,
    required this.appointmentSlotId,
    required this.meridiem,
    required this.state,
    required this.duration,
    required this.endAt,
    required this.startAt,
    // required this.dayOfTheWeek,
    // required this.year,
    // required this.month,
    // required this.day,
    // required this.createdAt,
    // required this.updatedAt,
  });

  String id;
  // String calendarId;
  // String nextAvailabilityId;
  // String previousAvailabilityId;
  String appointmentSlotId;
  String meridiem;
  String state;
  int duration;
  // int dayOfTheWeek;
  // int year;
  // int month;
  // int day;
  DateTime startAt;
  DateTime endAt;
  // DateTime createdAt;
  // DateTime updatedAt;
  // List<String> eventIds;
  List<String> motiveIds;

  Map<String, dynamic> toJson() => {};
  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      id: json['id'] as String,
      // calendarId: json['calendarId'] as String,
      // nextAvailabilityId: json['nextAvailabilityId'] as String,
      // previousAvailabilityId: json['previousAvailabilityId'] as String,
      appointmentSlotId: json['appointmentSlotId'] as String,
      meridiem: json['meridiem'] as String,
      state: json['state'] as String,
      duration: int.parse(json['duration'].toString()),
      // dayOfTheWeek: int.parse(json['dayOfTheWeek'].toString()),
      // year: int.parse(json['year']),
      // month: int.parse(json['month']),
      // day: int.parse(json['day']),
      startAt: DateTime.parse(json['startAt']),
      endAt: DateTime.parse(json['endAt']),
      // createdAt: DateTime.parse(json['createdAt']),
      // updatedAt: DateTime.parse(json['updatedAt']),
      // eventIds: json['eventIds'] != null ? List<String>.from(json['eventIds']) : [],
      motiveIds: json['motiveIds'] != null ? List<String>.from(json['motiveIds']) : [],
    );
  }
}