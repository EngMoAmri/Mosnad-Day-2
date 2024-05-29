import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Future<dynamic> showImageSourceDialog(context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Center(
                    child: Text(
                      'مصدر الصورة',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              Get.back(result: ImageSource.gallery);
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
                            child: const Text(
                              "الاستوديو",
                              style: TextStyle(fontSize: 16),
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context, ImageSource.camera);
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
                            child: const Text(
                              "الكاميرا",
                              style: TextStyle(fontSize: 16),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ));
      });
}