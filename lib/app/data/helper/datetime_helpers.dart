import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DateTimeHelpers {
  static String timestampsToDate(Timestamp timestamp) {
    var datetime =
        DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);

    return DateFormat('dd-MM-yyyy').format(datetime);
  }

  static String timestampsToTime(Timestamp timestamp) {
    var datetime =
        DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);

    return DateFormat('HH:mm a').format(datetime);
  }
}
