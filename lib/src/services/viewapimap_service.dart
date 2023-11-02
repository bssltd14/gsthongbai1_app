import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:gsthongbai1app/src/models/viewapimap_response.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';

class TimelineService {
  Future<List<ViewAPIMAPResponse>> fetchPosts(
      int startIndex, int limit, String searchDetail) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'serverId': Constant.ServerId,
      'customerId': Constant.CustomerId
    };

    final url =
        "${Constant.API}/ViewAPIMAP?startpage=$startIndex&limitpage=${100}&searchDetail=${Constant.searchDetail}";
    print(url);
    final http.Response response =
        await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      final List<ViewAPIMAPResponse> viewAPIMAPResponse =
          List<ViewAPIMAPResponse>.from(
              viewAPIMAPResponseFromJson(response.body));

      print("fetchPosts complete");
      return viewAPIMAPResponse;
    }

    throw Exception('Network failed TimelineService');
  }
}
