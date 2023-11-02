import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:gsthongbai1app/src/models/pawn_response.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';

class PawnService {
  Future<List<PawnResponse>> fetchPawn() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'serverId': Constant.ServerId,
      'customerId': Constant.CustomerId
    };

    final url =
        "${Constant.API}/ViewAPIPawnMt?searchCustTel=${Constant.CUSTTEL}";

    print(url);
    final http.Response response =
        await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      final List<PawnResponse> pawnResponse =
          List<PawnResponse>.from(pawnResponseFromJson(response.body));

      return pawnResponse;
    }
    throw Exception('Network failed PawnService');
  }
}
