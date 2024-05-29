import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> showMyAlertDialog(String message) {
  return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0.0,
          title: const Center(child: Text("ملاحظة")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },

                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(Colors.white),
                  foregroundColor:
                  MaterialStateProperty.all(Colors.black),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                ),
                child: const Text("حسناً",
                    style: TextStyle(fontWeight: FontWeight.bold)))
          ],
        );
      });
}