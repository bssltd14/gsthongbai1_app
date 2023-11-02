import 'package:gsthongbai1app/src/models/mobileapppaymentint_response.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:gsthongbai1app/src/utils/constant.dart';

class MobileAppPaymentIntService {
  Future<List<MobileAppPaymentIntResponse>> fetchMobileAppPaymentInt() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'serverId': Constant.ServerId,
      'customerId': Constant.CustomerId
    };

    final url =
        "${Constant.API}/GetMobileAppPaymentInt?custid=${Constant.MobileAppPaymentIntCustId}&type=${Constant.MobileAppPaymentIntType}&billid=${Constant.MobileAppPaymentIntBillId}";
    print(url);
    final http.Response response =
        await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      final List<MobileAppPaymentIntResponse> mobileAppPaymentIntResponse =
          List<MobileAppPaymentIntResponse>.from(
              mobileAppPaymentIntResponseFromJson(response.body));

      print("fetchMobileAppPaymentInt complete");
      return mobileAppPaymentIntResponse;
    }

    throw Exception('Network failed MobileAppPaymentIntService');
  }
}
