import 'package:gsthongbai1app/src/models/savingmt_response.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class SavingMtService {
  Future<List<SavingMtResponse>> fetchSavingMt() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'serverId': Constant.ServerId,
      'customerId': Constant.CustomerId
    };

    final url =
        "${Constant.API}/ViewAPISavingMt?searchCustTel=${Constant.CUSTTEL}";

    print(url);
    final http.Response response =
        await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      final List<SavingMtResponse> savingMtResponse =
          List<SavingMtResponse>.from(savingMtResponseFromJson(response.body));

      return savingMtResponse;
    }
    throw Exception('Network failed SavingMtService');
  }
}
