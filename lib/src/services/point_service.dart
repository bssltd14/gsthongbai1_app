import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:gsthongbai1app/src/models/point_response.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';

class PointService {
  Future<List<PointResponse>> fetchPoint() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'serverId': Constant.ServerId,
      'customerId': Constant.CustomerId
    };

    final url =
        "${Constant.API}/ViewAPICustomerPoint?searchCustID=${Constant.CUSTID}";
    print(url);
    final http.Response response =
        await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      final List<PointResponse> pointResponse =
          List<PointResponse>.from(pointResponseFromJson(response.body));

      return pointResponse;
    }
    throw Exception('Network failed PointService');
  }
}
