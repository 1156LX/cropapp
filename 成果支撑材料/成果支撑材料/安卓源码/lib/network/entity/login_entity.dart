class LoginEntity {
  int code;
  String message;
  Data data;

  LoginEntity({this.code, this.message, this.data});

  LoginEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String userPhoneNumber;
  String userPassWord;

  Data({this.userPhoneNumber, this.userPassWord});

  Data.fromJson(Map<String, dynamic> json) {
    userPhoneNumber = json['userPhoneNumber'];
    userPassWord = json['userPassWord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userPhoneNumber'] = this.userPhoneNumber;
    data['userPassWord'] = this.userPassWord;
    return data;
  }
}