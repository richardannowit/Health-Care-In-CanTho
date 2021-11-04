import 'package:flutter_healthcare/app/data/models/appointment.dart';

sortAppointment(List<AppointmentModel> appointments) {
  List<AppointmentModel> done =
      new List<AppointmentModel>.empty(growable: true);
  List<AppointmentModel> notYet =
      new List<AppointmentModel>.empty(growable: true);

  for (var appointment in appointments) {
    if (appointment.status == 'Done') {
      done.add(appointment);
    } else {
      notYet.add(appointment);
    }
  }

  int i, j;
  AppointmentModel temp;
  for (i = 0; i < notYet.length - 1; i++) {
    for (j = i + 1; j < notYet.length; j++) {
      dynamic dj = new DateTime.fromMicrosecondsSinceEpoch(
          notYet[j].appointment_date!.microsecondsSinceEpoch);
      dynamic di = new DateTime.fromMicrosecondsSinceEpoch(
          notYet[i].appointment_date!.microsecondsSinceEpoch);
      if (di.isAfter(dj)) {
        temp = notYet[j];
        notYet[j] = notYet[i];
        notYet[i] = temp;
      }
    }
  }
  appointments.clear();
  for (var appointment in notYet) {
    appointments.add(appointment);
  }

  for (var appointment in done) {
    appointments.add(appointment);
  }
}
