import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mosnad_flutter/controllers/main_controller.dart';
import 'package:mosnad_flutter/models/ServiceData.dart';
import 'package:mosnad_flutter/views/request_service_page.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key, required this.serviceData});
  final ServiceData serviceData;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("تفاصيل الخدمة",
              style: TextStyle(fontWeight: FontWeight.bold),),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const Divider(height: 1,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:
                  LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 480) {
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 480,
                                  child: serviceDetails(),
                                ),]);
                        }
                        return serviceDetails();
                      }

                  ),

                  
                ),
              ),

            ],
          )

      ),
    );
  }
  Widget serviceDetails(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Text(serviceData.name,
              style: const TextStyle(fontWeight: FontWeight.bold),),),
            Text("${serviceData.price.toString()} ريال",
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent),),

          ],
        ),
        Text("الأيام المتوقعة لإنجاز العمل ${serviceData.days.toString()}",
            style: const TextStyle(color: Colors.black54)),
        const SizedBox(height: 10,),
        Text(serviceData.description),
        Expanded(child: Container()),
        ElevatedButton(
            style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.black),
            onPressed: (){
              Get.to(()=>RequestServicePage(serviceData: serviceData));
            }, child: const Text("طلب هذه الخدمة"))
      ],
    );
  }
}
