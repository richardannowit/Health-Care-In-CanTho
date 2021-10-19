import 'package:get/get.dart';

import '../controllers/booked_success_controller.dart';

class BookedSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookedSuccessController>(
      () => BookedSuccessController(),
    );
  }
}
