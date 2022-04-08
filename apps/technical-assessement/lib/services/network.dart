import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:technical_assessement/constants/apis.dart';
import 'package:technical_assessement/models/slot.dart';

class ApiRequests {
  static final ApiRequests _singleton = ApiRequests._internal();

  factory ApiRequests() {
    return _singleton;
  }

  ApiRequests._internal();

  Future<List<Slot>> getAvailableSlots(DateTime startTime, DateTime endTime, bool isNewPatient, String? motiveId) async {
    try {
      Map<String, String> _params = {};
      Map<String, String> headers = {};
      headers["Accept"] = "application/json";
      headers["Content-Type"] = "application/json";

      _params["from"] = startTime.toUtc().toIso8601String();
      _params["to"] = endTime.toUtc().toIso8601String();

      _params["motive_id"] = motiveId!;
      _params["is_new_patient"] = isNewPatient.toString();
      _params["calendar_ids"] = kCalendarId;
      // _params["state"] = state;

      var uri = Uri.https(kUrlStagingRosa, '/api/availabilities', _params);
      var res = await get(uri);//, headers: headers);
      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);
        List<Slot> slots =
            body.map((dynamic item) => Slot.fromJson(item)).toList();

        return Future.value(slots);
      }
      throw Exception('Failed to load slots: ' + res.statusCode.toString());
    } on Exception catch (exception) {
      throw Exception('Failed to load slots: ' + exception.toString());
    }
  }
}
