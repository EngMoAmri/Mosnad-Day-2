import 'dart:typed_data';


abstract class ServiceRequester {
  Future<String> requestService({required int serviceId, required Map<String, String> body, Uint8List? image});
}