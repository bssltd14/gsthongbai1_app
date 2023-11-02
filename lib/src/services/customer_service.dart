import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:gsthongbai1app/src/models/customer_response.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';

//class CustomerService {
//  Future<List<CustomerResponse>> fetchPosts(String custtel) async {
////    final url = 'http://203.151.136.225/api/Customer/$custtel';
//    final url = ' http://203.151.136.225/api/Customer/0849726380';
//    final http.Response response = await http.get(url);
//
//    if (response.statusCode == 200) {
//      final List<CustomerResponse> customerResponse =
//          List<CustomerResponse>.from(customerResponseFromJson(response.body));
////      print(customerResponse);
//      return customerResponse;
//    }
//    throw Exception('Network failed');
//  }
//}

class CustomerService {
  Future<CustomerResponse> fetchCustomer(String custtel) async {
//    final response = await http.get('http://203.151.136.225/api/Customer/$custtel');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'serverId': Constant.ServerId,
      'customerId': Constant.CustomerId
    };

    final response = await http.get(
        Uri.parse("${Constant.API}/Customer/$custtel"),
        headers: requestHeaders);
    print('fetchcustomer');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return CustomerResponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load customer CustomerService');
    }
  }
}
