class TradeResponseEntity {
  int id;
  List<Parties> parties;
  Service service;
  List<Steps> steps;
  int status;

  TradeResponseEntity({this.id, this.parties, this.service, this.steps, this.status});

  TradeResponseEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['parties'] != null) {
      parties = new List<Parties>();
      json['parties'].forEach((v) {
        parties.add(new Parties.fromJson(v));
      });
    }
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
    if (json['steps'] != null) {
      steps = new List<Steps>();
      json['steps'].forEach((v) {
        steps.add(new Steps.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.parties != null) {
      data['parties'] = this.parties.map((v) => v.toJson()).toList();
    }
    if (this.service != null) {
      data['service'] = this.service.toJson();
    }
    if (this.steps != null) {
      data['steps'] = this.steps.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Parties {
  int id;
  String name;
  String avatar;

  Parties({this.id, this.name, this.avatar});

  Parties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    return data;
  }
}

class Service {
  int id;
  String name;
  String avatar;
  String description;

  Service({this.id, this.name, this.avatar, this.description});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['description'] = this.description;
    return data;
  }
}

class Steps {
  int id;
  String name;
  String createdDate;
  int duration;
  String givenStock;
  String gotStock;
  List<Conditions> conditions;

  Steps(
      {this.id,
        this.name,
        this.createdDate,
        this.duration,
        this.givenStock,
        this.gotStock,
        this.conditions});

  Steps.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdDate = json['created_date'];
    duration = json['duration'];
    givenStock = json['given_stock'];
    gotStock = json['got_stock'];
    if (json['conditions'] != null) {
      conditions = new List<Conditions>();
      json['conditions'].forEach((v) {
        conditions.add(new Conditions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_date'] = this.createdDate;
    data['duration'] = this.duration;
    data['given_stock'] = this.givenStock;
    data['got_stock'] = this.gotStock;
    if (this.conditions != null) {
      data['conditions'] = this.conditions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Conditions {
  int id;
  String title;
  String description;
  bool checked;

  Conditions({this.id, this.title, this.description, this.checked});

  Conditions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    checked = json['checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['checked'] = this.checked;
    return data;
  }
}