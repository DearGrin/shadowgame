import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralApi{
  Dio dio = Dio();
  String path = 'https://shadow-game.expquest.ru/api/';

   Future<Map<String,dynamic>> post(String api, String token, Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    path = prefs.getString('path') +'/api/';
    String _s = prefs.getString('path');
    print('s is $path');
    String _path = _s + '/api/';
    print('_p is $_path');
    String _np ='https://'+ _path + api;
    print('api is $api');
    var response = await dio.post(_np,
      options: Options(
        headers: {
          'Authorization' : 'Bearer $token'
    },
      ),
      data: data
    );
    print(response);
    print(response.data);
    return response.data;
  }
  Future<Response> postLogin(String api, FormData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _s = prefs.getString('path');
    print('s is $path');
    String _path = _s + '/api/';
    print('_p is $_path');
    String _np ='https://'+ _path + api;
    print('api is $_np');
    path = prefs.getString('path') +'/api/';
    var response = await dio.post(_np, data: data
    );
    return response;
  }
}