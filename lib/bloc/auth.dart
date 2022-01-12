import 'dart:async';

import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_browser.dart';
import 'package:web/api/local_storage.dart';
import 'package:web/extensios/jwt_convert.dart';
//import 'package:http/http.dart';


class Auth{
  final String testToken = '#id_token=eyJhbGciOiJSUzI1NiIsImtpZCI6IkIzQjdEQ0FBRUFCM0E1OENDREFBOTkxRjNDODJFNTU1MjMyNEUyNUQiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJzN2ZjcXVxenBZek5xcGtmUElMbFZTTWs0bDAifQ.eyJuYmYiOjE2MjI2OTE5MTcsImV4cCI6MTYyMjY5MjIxNywiaXNzIjoiaHR0cHM6Ly9wYXNzcG9ydC5za2Jrb250dXIucnUvIiwiYXVkIjoiYmlnYm9zcyIsIm5vbmNlIjoiMjlsYnVVWWk5dk5jRDNmRGdmTHlaanJNekNYVmMzVnE3YVhSVVV1TU1UTUlqTWx4TjgiLCJpYXQiOjE2MjI2OTE5MTcsImF0X2hhc2giOiJXLTZEelhDVC1sbHJ6dVRYZW1GMFRnIiwic19oYXNoIjoic0NWQWtEMnBQbXgzaTdVMVZYcmpsUSIsInNpZCI6InNFejhINEwwcDZRclpDalpsN1Ywd0EiLCJzdWIiOiJrb250dXJcXGxkaSIsImF1dGhfdGltZSI6MTYyMjY5MTg0OCwiaWRwIjoibG9jYWwiLCJpZCI6IlMtMS01LTIxLTEyMzExNTIxNTUtMTMyMzcxMTgzNi0xNTI1NDU0OTc5LTEzNzEwMSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJrb250dXJcXGxkaSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL3NpZCI6IlMtMS01LTIxLTEyMzExNTIxNTUtMTMyMzcxMTgzNi0xNTI1NDU0OTc5LTEzNzEwMSIsImFtciI6WyJtZmEiXX0.MdaRNH-ABXMdLvaOvducvz7B8BmO77vVgJMJKOWbnxMJERL25Q3MFX6871j7zYDYbofQUrX4-R4sOfOPBVyMSTkDw8mUEGbrfzXlN-COZZfM1sjAEqldEv9y_-yKSRMPK0lYADhtAtT5c6xGna29ItQ_Ao6zXWQoKuVw2mXgsAkILSFjf5bUi04ZFBIoJUoszKXZri7ZxKjGik3llRkdds2dkrcOVNPrL3-cq57DfK0IO2tkcjhSsDb3RSJAmgH4spuIdzXmFHLoaWJF3CMIpaXDahS3HrCbfXAsPsKilbQhZB7u5mesmBxeWQHHa3TPue7iewG1hC8WnTZa4v7OEw&access_token=eyJhbGciOiJSUzI1NiIsImtpZCI6IkIzQjdEQ0FBRUFCM0E1OENDREFBOTkxRjNDODJFNTU1MjMyNEUyNUQiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJzN2ZjcXVxenBZek5xcGtmUElMbFZTTWs0bDAifQ.eyJuYmYiOjE2MjI2OTE5MTcsImV4cCI6MTYyMjcyNzkxNywiaXNzIjoiaHR0cHM6Ly9wYXNzcG9ydC5za2Jrb250dXIucnUvIiwiYXVkIjoiaHR0cHM6Ly9wYXNzcG9ydC5za2Jrb250dXIucnUvcmVzb3VyY2VzIiwiY2xpZW50X2lkIjoiYmlnYm9zcyIsInN1YiI6ImtvbnR1clxcbGRpIiwiYXV0aF90aW1lIjoxNjIyNjkxODQ4LCJpZHAiOiJsb2NhbCIsInNjb3BlIjpbIm9wZW5pZCJdLCJhbXIiOlsibWZhIl19.mSB3OgREro7vhXIklT8kp1Yi5331P0zpjfo2RTPIVyraQJlHVFpTKxF8cFQhDhWV19Pf9wn44lkQjHqqVI9h-Fy2oKO1-eD2I7dC02AbVszdHpTuS_AtY4cNRFOE1ZoX2da5eixkeXlHcDo0f0ciG6OZrD48RUtQ10RsCza5C7aif1o5t7x2pGwmWbTKi4QOIGFr7IBb__FCD5AxUcpy0DIJAnKJsCl2enDP-BBZW03XysgDKgQ-9wyDHJoBpJBoN5hnebm4DYKZ_mXCcc5dJLRmydImE0VkhEjM2Smp6dCVsejdSMcVRWQ4-J-MM0yTjVD-F-Ut6WDYl132L-wwuA&token_type=Bearer&expires_in=36000&scope=openid&state=Qn6wJESQ1FHnAIX9cupEo8KF44azgoBSd2nAsg7aiRItS0VzzS&session_state=PY36j5ORmk-1K80oRCI7LjkYWPwNzf0CEtnJAtsi60s.kd0sHXe2aHwztLtMBcdzRQ';

  final authorizationEndpoint =
  Uri.parse('https://passport.skbkontur.ru/v3/');
  final identifier = 'bigboss';
  final secret = '4LdjPLmB3NuJ1cpiEU0T';
  final redirectUrl = Uri.parse('https://shadow-game.expquest.ru/');
  final tokenEndpoint = Uri.parse('https://passport.skbkontur.ru/v3/token');
  Uri responseUrl;
  List<String> scopes = [];
  //StreamSubscription _sub;
  final IdRepository idRepository = IdRepository();
  final JWTConvert jwtConvert = JWTConvert();

  /*
  Future<oauth2.Client> createClient() async {
 // print(identifier + "   " + authorizationEndpoint.toString() + '  ' + tokenEndpoint.toString() + '  ' + secret);
  /*
  var client = await oauth2.clientCredentialsGrant(
      authorizationEndpoint, identifier, secret);

   */

    var grant = oauth2.AuthorizationCodeGrant(
        identifier, authorizationEndpoint, tokenEndpoint,
        secret: secret);



    var authorizationUrl = grant.getAuthorizationUrl(redirectUrl);
    //print('redirect $redirectUrl');
    print('auth redir ' + authorizationUrl.toString());
    await redirect(authorizationUrl.toString());
    var responseUrl = await listen(redirectUrl);
    print('respone url ' +responseUrl.toString());
    //return await grant.handleAuthorizationResponse(responseUrl.queryParameters);
  }


  void getPassport() async{
    var client = await createClient();
   // print(client.credentials.accessToken.toString());

  }

   */
  Future<void> redirect(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
    // Client implementation detail
  }
  /*
  Future<Uri> listen(Uri url) async {
    // Client implementation detail
    _sub = getLinksStream().listen((String link) async {
      if (url.toString().startsWith(redirectUrl.toString())) {
        responseUrl = url;
        print('got response ' + url.toString());
        return responseUrl;
      }
    });
  }

   */

  Future<void> testKontur() async {
    Uri uri = Uri.parse('https://passport.skbkontur.ru/v3/');
    String clienId = 'bigboss';
    var issuer = await Issuer.discover(uri);
    var client = new Client(issuer, clienId, clientSecret: '4LdjPLmB3NuJ1cpiEU0T');
    var authenticator = new Authenticator(client, scopes: scopes);
    var c = await authenticator.credential;
    authenticator.authorize();
    /*
    if (c==null) {
      // starts the authentication
      print('c is null');
      authenticator.authorize(); // this will redirect the browser
    } else {
      // return the user info
      var info = await c.getUserInfo();
      print(info);
      print('try to get id token');
      var t = await c.getTokenResponse();
      print(t.idToken);
      print('c is not null');
      print(c.idToken);
      print('else 1');
      print(c.idToken.claims);
      print(t.toBase64EncodedString());
      print(t.toJson());
    }

    var i = await c.getUserInfo();
    print('user' + i.toString());
    print('c response token');
    print('try to get id token');
    var t = await c.getTokenResponse();
    print(t.idToken);
    print(c.idToken);
    print('2');
    print(c.idToken.claims);
    print('3');
    print('4');
    //var tok = await c.getTokenResponse();
    print('5');
    //var i = await idRepository.getId();
    //print(i);
    print('5');

     */
  }


  Future<void> testGoogle() async {
    Uri uri = Uri.parse('https://accounts.google.com/o/oauth2/v2/auth');
    print(uri);
    String clienId = '237354341174-208fuaqmvav8ou142sdfqp8v2iif2648.apps.googleusercontent.com';
    var issuer = await Issuer.discover(Issuer.google);
    print(issuer.metadata);
    var client = new Client(issuer, clienId, clientSecret: '6OW2OK6rU2WajuLOSxrsoWzG');
    scopes.add('https://www.googleapis.com/auth/userinfo.profile');
    scopes.add('https://www.googleapis.com/auth/userinfo.email');
    var authenticator = new Authenticator(client, scopes: scopes,);
    var c = await authenticator.credential;
    print(c);
    if (c==null) {
      // starts the authentication
      print('c is null');
      authenticator.authorize(); // this will redirect the browser
    } else {
      // return the user info
      var res = await c.getUserInfo();
      print('c user info');
      print('name' + res.name);
      print('email' + res.email);
      print('nickname' + res.nickname);
      print(res);
      return res;
      //Map<String,dynamic> res = c.response;
      //print(res);
      //return res;
    }
    print('c response');
    print(c.response);
    print(c.response.keys);
    print(c.response.values);
    //print(c.idToken);
  }
  void tryOpenid(){
    Uri _uri =  Uri.parse('https://passport.skbkontur.ru/v3');
    print(_uri);
    authenticate(_uri, identifier, secret, scopes);
  }
  authenticate(Uri uri, String clientId, String secret,List<String> scopes) async {

    // create the client
    var issuer = await Issuer.discover(uri);
   // print(issuer.toString());

    var client = new Client(issuer, clientId, clientSecret: secret);
    print(client.httpClient);

    // create an authenticator
    var authenticator = new Authenticator(client, scopes: scopes);
print(authenticator.flow.client.issuer);
    // get the credential
    var c = await authenticator.credential;

    if (c==null) {
      // starts the authentication
      authenticator.authorize(); // this will redirect the browser
    } else {
      // return the user info
      return await c.getUserInfo();
    }

  }
}