import 'dart:convert';

import 'package:gsthongbai1app/src/models/mobileappsetting_response.dart';
import 'package:http/http.dart' as http;
import 'package:gsthongbai1app/src/utils/constant.dart';

class MobileAppSettingService {
  Future<MobileAppSettingResponse> fetchCustomer(String custtel) async {
//    final response = await http.get('http://203.151.136.225/api/Customer/$custtel');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'serverId': Constant.ServerId,
      'customerId': Constant.CustomerId
    };

    final response = await http.get(
        Uri.parse("${Constant.API}/MobileAppSetting"),
        headers: requestHeaders);
    print('fetchmobileappsetting');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return MobileAppSettingResponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load MobileAppSetting MobileAppSettingService');
    }
  }
}
