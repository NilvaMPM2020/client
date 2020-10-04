class CreateServiceResponseEntity {
  String status;
  String link;

  CreateServiceResponseEntity({this.status, this.link});

  CreateServiceResponseEntity.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['link'] = this.link;
    return data;
  }
}