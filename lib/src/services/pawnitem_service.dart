import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:gsthongbai1app/src/models/pawnItem_response.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';

class PawnItemService {
  Future<List<PawnItemResponse>> fetchPawnItem(
      String strPawnID, String strBranchName) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'serverId': Constant.ServerId,
      'customerId': Constant.CustomerId
    };

    final url =
        "${Constant.API}/viewapipawnitem?searchPawnID=${strPawnID}&searchBranchName=${strBranchName}";

    print(url);
    final http.Response response =
        await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      final List<PawnItemResponse> pawnItemResponse =
          List<PawnItemResponse>.from(pawnItemResponseFromJson(response.body));

      return pawnItemResponse;
    }
    throw Exception('Network failed PawnItemService');
  }
}
