
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web/api/general_api.dart';
import 'package:web/bloc/auth.dart';
import 'package:web/models/evnet_model.dart';
import 'package:web/models/player_model.dart';

class LoginBloc{
  final Function getUserStatus;
  final Function changeToken;
  final Function checkUri;
  LoginBloc(this.getUserStatus, this.changeToken, this.checkUri);

  //final Dio dio = Dio();
  final GeneralApi _api = GeneralApi();
  final Auth auth = Auth();
  /*
  Future<void> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('token');
    if(checkValue)
    {
      String _token = prefs.getString('token');
      nextPage(_token);
      //doDebug('prefs', _token);
      //token = _token;
      //_statePage = 1;
      //addToStreamStatePage();
    }
    else{
      //todo show login page
      //_statePage = 0;
      //addToStreamStatePage();
    }
  }

   */
  Future<PhpCallback> logIn(String email, String password) async {
    FormData formData = FormData.fromMap({
      'email': email,
      'password': password,
    });
    var r = await _api.postLogin('login', formData);
    //var response = await dio.post('https://shadow-game.expquest.ru/api/login', data: formData);
    //PhpCallback callback = PhpCallback.fromJson(response.data);
    //print('login response is ' +r.toString());
    PhpCallback callback = PhpCallback.fromJson(r.data);
    if(callback.type == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', callback.token.token);
      prefs.setString('sub', email);
      nextPage(callback.token.token);
      return callback;
    }
    else{
      return callback;
    }
  }
  Future<PhpCallback> register(User user) async{
    FormData formData = FormData.fromMap({
      'name': user.name,
      'email': user.email,
      'password': user.password,
    });
    //var response = await dio.post('https://shadow-game.expquest.ru/api/register', data: user.toJson());
    var r = await _api.postLogin('register', formData);
   // PhpCallback callback = PhpCallback.fromJson(response.data);
    PhpCallback callback = PhpCallback.fromJson(r.data);
    if(callback.type == true)
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', callback.token.token);
      nextPage(callback.token.token);
      // token = callback.token.token;
      //_statePage = 1;
      //addToStreamStatePage();
      // connectToSocket();
      return callback;
    }
    return callback;
  }
  void nextPage(String token){
    changeToken(token);
    getUserStatus();
    //changePage();
   // changePage(1);
    //todo switch page
    //todo save token?
  }
  void testGoogle(){
    //auth.testKontur();
    checkUri();
  }
}
//final LoginBloc loginBloc = LoginBloc();