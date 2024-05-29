

import 'package:get/get.dart';
import 'package:mosnad_flutter/models/ServiceData.dart';
import 'package:mosnad_flutter/repositories/HttpDevOptionsRepository.dart';
import 'package:mosnad_flutter/repositories/LocalDevOptionsRepository.dart';

import '../utils/internet_checker.dart';

class MainController extends GetxController{
  HttpDevOptionsRepository httpDevOptionsRepository = HttpDevOptionsRepository();
  LocalDevOptionsRepository localDevOptionsRepository = LocalDevOptionsRepository();
  var loading = true.obs;
  var error = "".obs;

  Rx<List<ServiceData>> services = Rx([]);

  Future<void> fetchServices() async{
    loading.value=true;
    var internetExists = await isConnectedToInternet();
    if(internetExists) {
      httpDevOptionsRepository.getServices().then((value) {
        services.value = value;
        services.refresh();
        localDevOptionsRepository.saveServices(services.value);
        loading.value=false;
      }).onError((e, stackTrace) {
        error.value = "$e";
        loading.value=false;
      });
    }else{
      localDevOptionsRepository.getServices().then((value) {
        services.value = value;
        services.refresh();
        loading.value=false;
      }).onError((e, stackTrace) {
        error.value = "$e";
        loading.value=false;
      });
    }
  }
  @override
  void onInit() {
    fetchServices();
    super.onInit();
  }

}