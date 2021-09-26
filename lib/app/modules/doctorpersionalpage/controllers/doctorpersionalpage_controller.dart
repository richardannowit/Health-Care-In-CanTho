import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_healthcare/app/data/models/doctor.dart';
import 'package:flutter_healthcare/app/data/models/review.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:get/get.dart';

class DoctorpersionalpageController extends GetxController {
  final DoctorModel doctor = Get.arguments;
  final userEmail = FirebaseAuth.instance.currentUser!.email.toString();
  late String reviewDocId;
  late bool reviewYet;
  String content = '';
  double score = 0;
  late double rating;
  late Timestamp date;
  late DocumentReference userRef;
  RxDouble _rxRating = 0.0.obs;
  double get rxRating => _rxRating.value;
  set rxRating(value) => _rxRating.value = value;

  RxList<ReviewModel> _reviewList =
      new List<ReviewModel>.empty(growable: true).obs;
  List<ReviewModel> get reviewList => _reviewList;
  set reviewList(value) => _reviewList.value = value;

  RxBool _loading = true.obs;
  bool get loading => _loading.value;
  set loading(value) => _loading.value = value;

  getReviewList() async {
    loading = true;
    reviewList = await DatabaseMethods.getReviews(doctor.docId!);
    loading = false;
    userRef = await DatabaseMethods.getUserRef(userEmail);
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctor.docId!)
        .collection('reviews')
        .where('user', isEqualTo: userRef)
        .get();
    if (reviewYet = snapshot.docs.isNotEmpty)
      reviewDocId = snapshot.docs.first.id;
    if (reviewList.isNotEmpty) {
      getRating();
      doctor.rating = this.rating;
      doctor.addressRef = doctor.address.reference;
      Map<String, dynamic> docData = doctor.toJson();
      FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctor.docId)
          .update(docData);
    }
    rxRating = doctor.rating!;
  }

  getRating() {
    rating = 0;
    for (var element in reviewList) {
      rating += element.score!;
    }
    rating = rating / reviewList.length;
  }

  upReview() async {
    date = Timestamp.now();

    Map<String, dynamic> reviewData = {
      'user': this.userRef,
      'score': this.score,
      'content': this.content,
      'date': this.date
    };
    if (reviewYet) {
      FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctor.docId!)
          .collection('reviews')
          .doc(reviewDocId)
          .update(reviewData);
    } else
      DatabaseMethods.upLoadReview(reviewData, doctor.docId!);
  }

  final count = 0.obs;
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
  void increment() => count.value++;
}
