import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:gsthongbai1app/src/models/mobileappnotisent_response.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';

class MobileAppNotiSentService {
  Future<List<MobileAppNotiSentResponse>> fetchMobileAppNotiSent() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'serverId': Constant.ServerId,
      'customerId': Constant.CustomerId
    };

    final url =
        "${Constant.API}/GetMobileAppNotiSent?searchcusttel=${Constant.CUSTTEL}&searchNotiDateStart=${Constant.formatDateWhere.format(Constant.searchNotiDateStart)}&searchNotiDateEnd=${Constant.formatDateWhere.format(Constant.searchNotiDateEnd)}";
    print(url);
    final http.Response response =
        await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      final List<MobileAppNotiSentResponse> mobileAppNotiSentResponse =
          List<MobileAppNotiSentResponse>.from(
              mobileAppNotiSentResponseFromJson(response.body));

      print("fetchMobileAppNotiSent complete");
      return mobileAppNotiSentResponse;
    }

    throw Exception('Network failed MobileAppNotiSentService');
  }
}
