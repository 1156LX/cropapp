class CropEntity {
  int code;
  String message;
  List<Data> data;

  CropEntity({this.code, this.message, this.data});

  CropEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  int cropId;
  String cropName;
  String cropDescribe;
  String cropBaiduUrl;
  String cropImgUrl;
  String cropGrowthEnvironment;
  String cropCultivationTechniques;
  String cropNutritiveValue;
  String cropDiseaseControl;
  String cropStorageMethod;

  Data(
      {this.cropId,
        this.cropName,
        this.cropDescribe,
        this.cropBaiduUrl,
        this.cropImgUrl,
        this.cropGrowthEnvironment,
        this.cropCultivationTechniques,
        this.cropNutritiveValue,
        this.cropDiseaseControl,
        this.cropStorageMethod});

  Data.fromJson(Map<String, dynamic> json) {
    cropId = json['cropId'];
    cropName = json['cropName'];
    cropDescribe = json['cropDescribe'];
    cropBaiduUrl = json['cropBaiduUrl'];
    cropImgUrl = json['cropImgUrl'];
    cropGrowthEnvironment = json['cropGrowthEnvironment'];
    cropCultivationTechniques = json['cropCultivationTechniques'];
    cropNutritiveValue = json['cropNutritiveValue'];
    cropDiseaseControl = json['cropDiseaseControl'];
    cropStorageMethod = json['cropStorageMethod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cropId'] = this.cropId;
    data['cropName'] = this.cropName;
    data['cropDescribe'] = this.cropDescribe;
    data['cropBaiduUrl'] = this.cropBaiduUrl;
    data['cropImgUrl'] = this.cropImgUrl;
    data['cropGrowthEnvironment'] = this.cropGrowthEnvironment;
    data['cropCultivationTechniques'] = this.cropCultivationTechniques;
    data['cropNutritiveValue'] = this.cropNutritiveValue;
    data['cropDiseaseControl'] = this.cropDiseaseControl;
    data['cropStorageMethod'] = this.cropStorageMethod;
    return data;
  }
}