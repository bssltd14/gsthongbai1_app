import 'package:gsthongbai1app/src/models/mobileapppayment_response.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:gsthongbai1app/src/utils/constant.dart';

class MobileAppPaymentService {
  Future<List<MobileAppPaymentResponse>> fetchMobileAppPayment() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'serverId': Constant.ServerId,
      'customerId': Constant.CustomerId
    };

    final url =
        "${Constant.API}/GetMobileAppPayment?custid=${Constant.MobileAppPaymentCustId}&type=${Constant.MobileAppPaymentType}&billid=${Constant.MobileAppPaymentBillId}";
    print(url);
    final http.Response response =
        await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      final List<MobileAppPaymentResponse> mobileAppPaymentResponse =
          List<MobileAppPaymentResponse>.from(
              mobileAppPaymentResponseFromJson(response.body));

      print("fetchMobileAppPayment complete");
      return mobileAppPaymentResponse;
    }

    throw Exception('Network failed MobileAppPaymentService');
  }
}
