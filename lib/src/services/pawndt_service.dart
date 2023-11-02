import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:gsthongbai1app/src/models/pawndt_response.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';

class PawnDtService {
  Future<List<PawnDtResponse>> fetchPawnDt(
      String strPawnID, String strBranchName) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'serverId': Constant.ServerId,
        'customerId': Constant.CustomerId
      };

      final url =
          "${Constant.API}/viewapipawnDt?searchPawnID=${strPawnID}&searchBranchName=${strBranchName}";

      print(url);
      final http.Response response =
          await http.get(Uri.parse(url), headers: requestHeaders);

      if (response.statusCode == 200) {
        final List<PawnDtResponse> pawnDtResponse =
            List<PawnDtResponse>.from(pawnDtResponseFromJson(response.body));

        return pawnDtResponse;
      }
      throw Exception('Network failed PawnDtService');
    } catch (_) {
      print("Error catch ${_}");
    }
  }
}
