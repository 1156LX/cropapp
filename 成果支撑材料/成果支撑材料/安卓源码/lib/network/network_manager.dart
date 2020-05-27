import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class NetworkManager{

  static const String BASE_URL = 'http://59.110.45.91:9810';
  static const String REGISTER = '/index/register';
  static const String LOGIN = '/index/login';
  static const String CROPS = '/admin/crop';
  static const String USER_CROP = '/usercrop';

  static NetworkManager _networkManager;

  Dio _dio;

  static NetworkManager getInstance(){
    if(_networkManager == null){
      _networkManager = NetworkManager();
    }
    return _networkManager;
  }

  Dio _getDio(){
    if(_dio == null){
      BaseOptions options = BaseOptions();
      options.connectTimeout = 1000 * 8;
      options.receiveTimeout = 1000 * 8;
      options.responseType = ResponseType.plain;
      //options.baseUrl = BASE_URL;
      _dio = Dio();
      _dio.options = options;
      _dio.interceptors.add(CookieManager(CookieJar()));
    }
    return _dio;
  }

  void register(String name,String password,OnSuccess success,OnFailed failed) async{
    Map<String,dynamic> params = {'username' : name,'password':password};
    try{
      var response = await _getDio().post(BASE_URL + REGISTER,queryParameters: params);
      success(response.data.toString());
    }catch(e){
      failed(e.toString());
    }
  }

  void login(String name,String password,OnSuccess success,OnFailed failed) async{
    Map<String,String> params = {'username':name,'password':password};
    try{
      var response = await _getDio().get(BASE_URL + LOGIN,queryParameters: params);
      success(response.toString());
    }catch(e){
      failed(e.toString());
    }
  }

  void queryCrops(OnSuccess success,OnFailed failed) async{
    try{
      var response = await _getDio().get(BASE_URL + CROPS);
      success(response.toString());
    }catch(e){
      failed(e.toString());
    }
  }

  void addCrops(int crops,OnSuccess success,OnFailed failed) async{
    try{
      print('crops:$crops');
      Map<String,dynamic> params = {'cropId':crops};
      var response = await _getDio().post(BASE_URL + USER_CROP,queryParameters: params);
      success(response.toString());
    }catch(e){
      failed(e.toString());
    }
  }

  void queryUserCrops(OnSuccess success,OnFailed failed) async{
    try{
      var response = await _getDio().get(BASE_URL + USER_CROP);
      success(response.toString());
    }catch(e){
      failed(e.toString());
    }
  }

}

typedef OnSuccess = Function(String json);
typedef OnFailed = Function(String message);