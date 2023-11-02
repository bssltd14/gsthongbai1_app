import 'package:gsthongbai1app/src/models/saving_response.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class SavingService {
  Future<List<SavingResponse>> fetchSaving() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'serverId': Constant.ServerId,
      'customerId': Constant.CustomerId
    };

    final url =
        "${Constant.API}/ViewAPIsavingdt?searchSavingId=${Constant.SavingId}";
    print(url);
    final http.Response response =
        await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      final List<SavingResponse> savingResponse =
          List<SavingResponse>.from(savingResponseFromJson(response.body));

      return savingResponse;
    }
    throw Exception('Network failed SavingService');
  }
}
