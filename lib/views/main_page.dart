import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mosnad_flutter/controllers/main_controller.dart';
import 'package:mosnad_flutter/views/service_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MainController());
    return Directionality(

        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("الخدمات",
              style: TextStyle(fontWeight: FontWeight.bold),),
            centerTitle: true,
            actions: [
              IconButton(onPressed: () {
                // prevent refresh if still loading data
                if(!controller.loading.value) {
                  controller.fetchServices();
                }
              }, icon: const Icon(Icons.refresh))
            ],
          ),
          body:Column(
            children: [
              const Divider(height: 1,),
              Expanded(
                child: Obx(() =>
                controller.loading.value?
                const Center(child: CircularProgressIndicator(),)
                    :
                controller.error.value.isNotEmpty?
                Center(child: Text(controller.error.value),)
                    :
                controller.services.value.isEmpty?
                const Center(child: Text("لا يوجد خدمات متوفرة, تأكد من إتصالك بالإنترنت ثم حاول مرة أخرى"),)
                    :
                LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 480) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 480,
                                child: services(controller),
                              ),]);
                      }
                      return services(controller);
                    }

                ),
                ),
              ),
            ],
          ),

        )
    );
  }

  Widget services(MainController controller){
    return
      ListView.separated(
        itemCount: controller.services.value.length,
        itemBuilder: (context, index) {
          var service = controller.services.value[index];
          return ListTile(
            onTap: () {
              Get.to(() => ServicePage(serviceData: service,));
            },
            leading: const Icon(
              Icons.miscellaneous_services, color: Colors.pinkAccent,),
            title: Text(service.name),
          );
        }, separatorBuilder: (context, index) {
        return const Divider(height: 1,);
      },);

  }
}
