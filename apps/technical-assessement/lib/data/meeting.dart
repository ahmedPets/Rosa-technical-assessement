import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Session> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}

class Session {
  Session(this.id, this.eventName, this.from, this.to, this.background);

  String id;
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
}