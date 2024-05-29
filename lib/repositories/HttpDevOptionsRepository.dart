import 'dart:convert';
import 'dart:typed_data';

import 'package:mosnad_flutter/models/ServiceData.dart';
import 'package:http/http.dart' as http;
import 'package:mosnad_flutter/repositories/abstracts/service_requester.dart';
import 'package:mosnad_flutter/repositories/abstracts/services_provider.dart';

class HttpDevOptionsRepository implements ServicesProvider, ServiceRequester{
  // singleton
  static final HttpDevOptionsRepository _singleton = HttpDevOptionsRepository._internal();

  factory HttpDevOptionsRepository() {
    return _singleton;
  }

  HttpDevOptionsRepository._internal();
  // singleton end


  @override
  Future<List<ServiceData>> getServices() async{
    List<ServiceData> services = [];
    var response =
        await http.get(Uri.parse('https://app.dev-options.com/api/services'), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      for (var service in data["data"] as List<dynamic>) {
        services.add(ServiceData.fromMap(service));
      }
      return services;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw 'فشل جلب الخدمات';
    }
  }

  @override
  Future<String> requestService({required int serviceId, required Map<String, String> body, Uint8List? image}) async {
    var request =
    http.MultipartRequest("POST",Uri.parse('https://app.dev-options.com/api/request_service'),);
    if(image!=null) {
      final httpImage = http.MultipartFile.fromBytes('image', image);
      request.files.add(httpImage);
    }
    request.fields.addAll(body);
    var response = await request.send();
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode((await http.Response.fromStream(response)).body) as Map<String, dynamic>;
      if(data["code"] == 1){
        return data["message"];
      }else{
        throw data["message"];
      }
    }
    throw "خطأ غير معروف";
  }

}