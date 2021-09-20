class DoctorModel {
  String? email, name, specialist, phone;
  double? rating;

  DoctorModel({
    this.email,
    this.name,
    this.specialist,
    this.phone,
    this.rating,
  });

  DoctorModel.fromJson(Map<String, dynamic> json) {
    this.email = json['email'];
    this.name = json['name'];
    this.specialist = json['specialist'];
    this.phone = json['phone'];
    this.rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['specialist'] = this.specialist;
    data['phone'] = this.phone;
    data['rating'] = this.rating;
    return data;
  }
}
