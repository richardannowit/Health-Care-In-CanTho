class AddressModel {
  String? name;

  AddressModel({
    this.name,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
