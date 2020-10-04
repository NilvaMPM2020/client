
class User {
  String username;
  String name;
  String avatar;
  double rate;
  String phone;
  String email;
  int userType;

  User(
      {this.username,
        this.name,
        this.avatar,
        this.rate,
        this.phone,
        this.email,
        this.userType});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    avatar = json['avatar'];
    rate = json['rate'];
    phone = json['phone'];
    email = json['email'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['rate'] = this.rate;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['user_type'] = this.userType;
    return data;
  }
}