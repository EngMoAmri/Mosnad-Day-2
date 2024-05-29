import '../../models/ServiceData.dart';

abstract class ServicesProvider {
  Future<List<ServiceData>> getServices();
}