class UserCropEntity {
  int code;
  String message;
  List<UserCropData> data;

  UserCropEntity({this.code, this.message, this.data});

  UserCropEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<UserCropData>();
      json['data'].forEach((v) {
        data.add(new UserCropData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserCropData {
  int id;
  int userId;
  int cropId;
  double height;
  String date;
  String temperature;
  String humidity;
  String place;
  String precipitation;
  String co2;
  String o2;
  String n2;

  UserCropData(
      {this.id,
        this.userId,
        this.cropId,
        this.height,
        this.date,
        this.temperature,
        this.humidity,
        this.place,
        this.precipitation,
        this.co2,
        this.o2,
        this.n2});

  UserCropData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    cropId = json['cropId'];
    height = json['height'];
    date = json['date'];
    temperature = json['temperature'];
    humidity = json['humidity'];
    place = json['place'];
    precipitation = json['precipitation'];
    co2 = json['co2'];
    o2 = json['o2'];
    n2 = json['n2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['cropId'] = this.cropId;
    data['height'] = this.height;
    data['date'] = this.date;
    data['temperature'] = this.temperature;
    data['humidity'] = this.humidity;
    data['place'] = this.place;
    data['precipitation'] = this.precipitation;
    data['co2'] = this.co2;
    data['o2'] = this.o2;
    data['n2'] = this.n2;
    return data;
  }
}