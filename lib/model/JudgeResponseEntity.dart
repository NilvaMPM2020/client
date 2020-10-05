/// id : 7
/// parties : [{"id":4,"name":"2123کاربر","avatar":"/photo_2020-09-06_21-33-43.jpg"},{"id":5,"name":"کاربر","avatar":"/IMG_20200902_100137_134.jpg"}]
/// service : {"id":6,"name":"new service","avatar":null,"description":"","link":""}
/// steps : [{"id":6,"name":"new service","created_date":"2020-10-03T15:42:13.841257Z","duration":25,"given_stock":"","got_stock":"10000","conditions":[{"id":9,"title":"cond 1","description":"cond 1","checked":false},{"id":10,"title":"cond 2","description":"cond 2","checked":false}],"judgement_description_business":"","description_client":""}]
/// status : 2

class JudgeResponseEntity {
  int _id;
  List<Parties> _parties;
  Service _service;
  List<Steps> _steps;
  int _status;

  int get id => _id;
  List<Parties> get parties => _parties;
  Service get service => _service;
  List<Steps> get steps => _steps;
  int get status => _status;

  JudgeResponseEntity({
    int id,
    List<Parties> parties,
    Service service,
    List<Steps> steps,
    int status}){
    _id = id;
    _parties = parties;
    _service = service;
    _steps = steps;
    _status = status;
  }

  JudgeResponseEntity.fromJson(dynamic json) {
    _id = json["id"];
    if (json["parties"] != null) {
      _parties = [];
      json["parties"].forEach((v) {
        _parties.add(Parties.fromJson(v));
      });
    }
    _service = json["service"] != null ? Service.fromJson(json["service"]) : null;
    if (json["steps"] != null) {
      _steps = [];
      json["steps"].forEach((v) {
        _steps.add(Steps.fromJson(v));
      });
    }
    _status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    if (_parties != null) {
      map["parties"] = _parties.map((v) => v.toJson()).toList();
    }
    if (_service != null) {
      map["service"] = _service.toJson();
    }
    if (_steps != null) {
      map["steps"] = _steps.map((v) => v.toJson()).toList();
    }
    map["status"] = _status;
    return map;
  }

}

/// id : 6
/// name : "new service"
/// created_date : "2020-10-03T15:42:13.841257Z"
/// duration : 25
/// given_stock : ""
/// got_stock : "10000"
/// conditions : [{"id":9,"title":"cond 1","description":"cond 1","checked":false},{"id":10,"title":"cond 2","description":"cond 2","checked":false}]
/// judgement_description_business : ""
/// description_client : ""

class Steps {
  int _id;
  String _name;
  String _createdDate;
  int _duration;
  String _givenStock;
  String _gotStock;
  List<Conditions> _conditions;
  String _judgementDescriptionBusiness;
  String _descriptionClient;

  int get id => _id;
  String get name => _name;
  String get createdDate => _createdDate;
  int get duration => _duration;
  String get givenStock => _givenStock;
  String get gotStock => _gotStock;
  List<Conditions> get conditions => _conditions;
  String get judgementDescriptionBusiness => _judgementDescriptionBusiness;
  String get descriptionClient => _descriptionClient;

  Steps({
    int id,
    String name,
    String createdDate,
    int duration,
    String givenStock,
    String gotStock,
    List<Conditions> conditions,
    String judgementDescriptionBusiness,
    String descriptionClient}){
    _id = id;
    _name = name;
    _createdDate = createdDate;
    _duration = duration;
    _givenStock = givenStock;
    _gotStock = gotStock;
    _conditions = conditions;
    _judgementDescriptionBusiness = judgementDescriptionBusiness;
    _descriptionClient = descriptionClient;
  }

  Steps.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _createdDate = json["createdDate"];
    _duration = json["duration"];
    _givenStock = json["givenStock"];
    _gotStock = json["gotStock"];
    if (json["conditions"] != null) {
      _conditions = [];
      json["conditions"].forEach((v) {
        _conditions.add(Conditions.fromJson(v));
      });
    }
    _judgementDescriptionBusiness = json["judgementDescriptionBusiness"];
    _descriptionClient = json["descriptionClient"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["createdDate"] = _createdDate;
    map["duration"] = _duration;
    map["givenStock"] = _givenStock;
    map["gotStock"] = _gotStock;
    if (_conditions != null) {
      map["conditions"] = _conditions.map((v) => v.toJson()).toList();
    }
    map["judgementDescriptionBusiness"] = _judgementDescriptionBusiness;
    map["descriptionClient"] = _descriptionClient;
    return map;
  }

}

/// id : 9
/// title : "cond 1"
/// description : "cond 1"
/// checked : false

class Conditions {
  int _id;
  String _title;
  String _description;
  bool _checked;

  int get id => _id;
  String get title => _title;
  String get description => _description;
  bool get checked => _checked;

  Conditions({
    int id,
    String title,
    String description,
    bool checked}){
    _id = id;
    _title = title;
    _description = description;
    _checked = checked;
  }

  Conditions.fromJson(dynamic json) {
    _id = json["id"];
    _title = json["title"];
    _description = json["description"];
    _checked = json["checked"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["title"] = _title;
    map["description"] = _description;
    map["checked"] = _checked;
    return map;
  }

}

/// id : 6
/// name : "new service"
/// avatar : null
/// description : ""
/// link : ""

class Service {
  int _id;
  String _name;
  dynamic _avatar;
  String _description;
  String _link;

  int get id => _id;
  String get name => _name;
  dynamic get avatar => _avatar;
  String get description => _description;
  String get link => _link;

  Service({
    int id,
    String name,
    dynamic avatar,
    String description,
    String link}){
    _id = id;
    _name = name;
    _avatar = avatar;
    _description = description;
    _link = link;
  }

  Service.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _avatar = json["avatar"];
    _description = json["description"];
    _link = json["link"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["avatar"] = _avatar;
    map["description"] = _description;
    map["link"] = _link;
    return map;
  }

}

/// id : 4
/// name : "2123کاربر"
/// avatar : "/photo_2020-09-06_21-33-43.jpg"

class Parties {
  int _id;
  String _name;
  String _avatar;

  int get id => _id;
  String get name => _name;
  String get avatar => _avatar;

  Parties({
    int id,
    String name,
    String avatar}){
    _id = id;
    _name = name;
    _avatar = avatar;
  }

  Parties.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _avatar = json["avatar"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["avatar"] = _avatar;
    return map;
  }

}