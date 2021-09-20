class Appointment {
  late String doctor;
  late String doctorName;
  late String status;
  late DateTime dateTime;
  Appointment(String doc, String status) {
    doctor = doc;
    this.status = status;
  }
  setDoctorName(String name) {
    doctorName = name;
  }

  setDateTime(DateTime dateTime) {
    this.dateTime = dateTime;
  }

  String getDate() {
    String date = dateTime.day.toString() +
        "/" +
        dateTime.month.toString() +
        "/" +
        dateTime.year.toString();
    return date;
  }

  String getTime() {
    late String time;
    if (dateTime.minute < 10)
      time = dateTime.hour.toString() + ":" + "0" + dateTime.minute.toString();
    else
      time = dateTime.hour.toString() + ":" + dateTime.minute.toString();
    return time;
  }
}
