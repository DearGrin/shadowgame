import 'dart:convert';

class JWTConvert{

  String convertJWT(String jwt){
    final parts = jwt.split('.');
    //if (parts.length != 3) {
     // throw Exception('invalid token');
   // }
    //else{
     final payload =  decodeBase64(parts[1]);
     final payloadMap = json.decode(payload);
     print('your id is ' + payloadMap['sub']);
     return payloadMap['sub'];
    //}
  }
  String decodeBase64(String str) {
    //'-', '+' 62nd char of encoding,  '_', '/' 63rd char of encoding
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) { // Pad with trailing '='
      case 0: // No pad chars in this case
        break;
      case 2: // Two pad chars
        output += '==';
        break;
      case 3: // One pad char
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}