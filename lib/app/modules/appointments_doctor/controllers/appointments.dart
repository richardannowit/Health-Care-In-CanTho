import 'package:flutter_healthcare/app/data/helper/datetime_helpers.dart';
import 'package:flutter_healthcare/app/data/models/appointment.dart';

sortAppointment(List<AppointmentModel> appointments) {
  List<AppointmentModel> done =
      new List<AppointmentModel>.empty(growable: true);
  List<AppointmentModel> notYet =
      new List<AppointmentModel>.empty(growable: true);

  for (var appointment in appointments) {
    DateTime appointmentDate =
        DateTimeHelpers.timestampsToDateTime(appointment.appointment_date!);
    if (DateTimeHelpers.isBeforeNow(appointmentDate)) {
      appointment.status = 'Done';
    }
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
      dynamic dj = notYet[j].appointment_date!;
      dynamic di = notYet[i].appointment_date!;
      if (di.compareTo(dj) < 0) {
        temp = notYet[j];
        notYet[j] = notYet[i];
        notYet[i] = temp;
      }
    }
  }
  for (i = 0; i < done.length - 1; i++) {
    for (j = i + 1; j < done.length; j++) {
      dynamic dj = done[j].appointment_date!;
      dynamic di = done[i].appointment_date!;
      if (di.compareTo(dj) < 0) {
        temp = done[j];
        done[j] = done[i];
        done[i] = temp;
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
