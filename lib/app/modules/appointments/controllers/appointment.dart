class Appointment {
  late String doctorName;
  late String status;
  late DateTime dateTime;
  late String specialist;

  Appointment(String status) {
    switch (status) {
      case "active":
        this.status = "Active";
        break;
      case "waiting":
        this.status = "Waiting";
        break;
      default:
        this.status = "Done";
    }
  }
  setDoctorName(String name) {
    doctorName = name;
  }

  setDateTime(DateTime dateTime) {
    this.dateTime = dateTime;
  }

  setSpecialist(String specialist) {
    this.specialist = specialist;
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

  String getStatus() {
    return status;
  }
}
