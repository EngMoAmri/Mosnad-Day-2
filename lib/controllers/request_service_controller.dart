
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mosnad_flutter/database/my_database.dart';
import 'package:mosnad_flutter/models/ServiceData.dart';
import 'package:mosnad_flutter/utils/pick_image.dart';
import 'package:mosnad_flutter/views/dialogs/alert_dialog.dart';
import 'package:mosnad_flutter/views/dialogs/image_source_dialog.dart';

import '../repositories/HttpDevOptionsRepository.dart';
import '../utils/internet_checker.dart';

class RequestServiceController extends GetxController{
  HttpDevOptionsRepository httpDevOptionsRepository = HttpDevOptionsRepository();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final modelController = TextEditingController();
  final descriptionController = TextEditingController();
  Rx<Uint8List?> image = Rx(null);
  var requesting = false.obs;
  Rx<List<ServiceData>> services = Rx([]);
  void selectImage(){
    showImageSourceDialog(Get.context!)
        .then((source) {
      if (source == null) return;
      pickImage(
        Get.context!,
        source,
      ).then((imageFile) async{
        if (imageFile != null) {
          image.value = await imageFile.readAsBytes();
        }
      });
    });
  }
  Future<void> requestTheService(ServiceData serviceData) async{
    if(!formKey.currentState!.validate()){
      return;
    }
    requesting.value=true;
    var internetExists = await isConnectedToInternet();
    if(internetExists) {
      httpDevOptionsRepository.requestService(serviceId: serviceData.id, body: {
        "service_id":"${serviceData.id}",
        "name": nameController.text,
        "phone": phoneController.text,
        "mobile_model": modelController.text,
        "description": descriptionController.text,
      }, image: image.value).then((value) {
        requesting.value=false;
        showMyAlertDialog(value).then((value) {
          Get.back();
        });
      }).onError((error, stackTrace) {
        requesting.value=false;
        showMyAlertDialog("$error");
      });
    }else{
      showMyAlertDialog('فشل طلب الخدمة لعدم توفر إنترنت');
      requesting.value=false;
    }
  }

}