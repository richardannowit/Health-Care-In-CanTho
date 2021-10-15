import 'package:get/get.dart';

class MakeAppointmentController extends GetxController {
  RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(value) => _loading.value = value;

  Rx<DateTime> _selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ).obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(value) => _selectedDate.value = value;

  void onDateChange(DateTime newDate) async {
    selectedDate = newDate;
  }

  bool isDate(DateTime thisDate, DateTime _selected) {
    final selected = DateTime(
      _selected.year,
      _selected.month,
      _selected.day,
    );

    return selected.compareTo(thisDate) == 0;
  }

  bool isLessThanNow(DateTime date) {
    final now = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    return now.compareTo(date) > 0;
  }

  bool isNow(DateTime date) {
    final now = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    return now.compareTo(date) == 0;
  }

  Future<void> loadData() async {
    //
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
