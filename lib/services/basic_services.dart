import 'dart:convert';

import 'package:don/basic_data.dart';
import 'package:http/http.dart';

class BasicServices
{
  static Future<String?> getAuthToken(String userProfile) async
  {
    String? token;
    try{
      String url = "${BasicData.BASE_URL}/donchain/v1/$userProfile/getToken?org=Org2MSP";
      Response response = await get(Uri.parse(url));
      Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
      token = data["Value"] as String;
    }
    catch(ex)
    {
      return null;
    }
  }

  static Future<bool> createAuthRequest(String userProfile, String token) async
  {
    try{
      String url = "${BasicData.BASE_URL}/donchain/v1/$userProfile/authResponse?token=$token";
      Response response = await post(Uri.parse(url));
      if(response.statusCode >= 200 && response.statusCode < 300){
        return true;
      }

      return false;
    }
    catch(ex)
    {
      return false;
    }
  }


}