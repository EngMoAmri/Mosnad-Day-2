import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mosnad_flutter/controllers/main_controller.dart';
import 'package:mosnad_flutter/controllers/request_service_controller.dart';
import 'package:mosnad_flutter/models/ServiceData.dart';
import 'package:mosnad_flutter/utils/pick_image.dart';
import 'package:mosnad_flutter/views/dialogs/image_source_dialog.dart';

class RequestServicePage extends StatelessWidget {
  const RequestServicePage({super.key, required this.serviceData});
  final ServiceData serviceData;
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RequestServiceController());
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title:  Text("طلب خدمة ${serviceData.name}",
            style:const TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const Divider(height: 1,),
            Expanded(
              child: Form(
                key: controller.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child:
                    LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 480) {
                            return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 480,
                                    child: requestForm(controller),
                                  ),]);
                          }
                          return requestForm(controller);
                        }

                    ),


                  ),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }

  Widget requestForm(RequestServiceController controller){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: controller.nameController,
          decoration: const InputDecoration(
              hintText: "الاسم الكامل"
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'هذا الحقل مطلوب';
            }
            return null;
          },

        ),
        TextFormField(
          controller: controller.phoneController,
          decoration: const InputDecoration(
              hintText: "رقم الهاتف"
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'هذا الحقل مطلوب';
            }
            return null;
          },

        ),
        TextFormField(
          controller: controller.modelController,
          decoration: const InputDecoration(
              hintText: "موديل الهاتف"
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'هذا الحقل مطلوب';
            }
            return null;
          },

        ),
        TextFormField(
          controller: controller.descriptionController,
          decoration: const InputDecoration(
            hintText: "وصف المشكلة",
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'هذا الحقل مطلوب';
            }
            return null;
          },

          maxLines: 3,
        ),
        const SizedBox(height: 10,),
        Obx(
              () => Center(
            child: GestureDetector(
              onTap: () => controller.selectImage(),
              child: Card(
                elevation: 0.0,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: Colors.black,
                        width: 2.0),
                    borderRadius:
                    BorderRadius.circular(10.0)),
                child: Card(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Colors.white,
                          width: 5.0),
                      borderRadius:
                      BorderRadius.circular(10.0)),
                  child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(10.0),
                      child: (controller
                          .image.value ==
                          null)
                          ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                          children: [
                            Text(
                                "صورة -إختياري-"),
                            SizedBox(width: 10,),
                            Icon(Icons
                                .image_outlined),
                          ],
                        ),
                      )
                          : Image(
                        fit: BoxFit.cover,
                        image: Image.memory(
                            controller
                                .image.value!)
                            .image,
                      )),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10,),
        Obx(() =>
        controller.requesting.value?
        const Center(child: CircularProgressIndicator(),)
            :
        ElevatedButton(
            style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.black),
            onPressed: ()=>
                controller.requestTheService(serviceData), child: const Text("طلب هذه الخدمة"))
        )
      ],
    );
  }
}
