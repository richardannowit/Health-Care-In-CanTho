import 'appointment.dart';

sortAppointment(List<Appointment> appointments) {
  int i, j;
  Appointment temp;
  for (i = 0; i < appointments.length - 1; i++) {
    for (j = i + 1; j < appointments.length; j++) {
      if (appointments[j].dateTime.isAfter(appointments[i].dateTime)) {
        temp = appointments[j];
        appointments[j] = appointments[i];
        appointments[i] = temp;
      }
    }
  }
}
