import 'appointment.dart';

sortAppointment(List<Appointment> appointments) {
  List<Appointment> done = new List<Appointment>.empty(growable: true);
  List<Appointment> notYet = new List<Appointment>.empty(growable: true);

  for (var appointment in appointments) {
    if (appointment.status == 'Done') {
      done.add(appointment);
    } else {
      notYet.add(appointment);
    }
  }

  int i, j;
  Appointment temp;
  for (i = 0; i < notYet.length - 1; i++) {
    for (j = i + 1; j < notYet.length; j++) {
      dynamic dj = new DateTime.fromMicrosecondsSinceEpoch(
          notYet[j].dateTime.microsecondsSinceEpoch);
      dynamic di = new DateTime.fromMicrosecondsSinceEpoch(
          notYet[i].dateTime.microsecondsSinceEpoch);
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
