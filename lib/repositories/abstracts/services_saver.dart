import '../../models/ServiceData.dart';

abstract class ServicesSaver {
  Future<void> saveServices(List<ServiceData> services);
}