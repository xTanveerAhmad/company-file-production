import 'dart:io';

import 'package:dashed_rect/dashed_rect.dart';
import 'package:epp_film/cors/item.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);
  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  int current = 0;
  final service = Get.put(ItemController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: service,
      builder: (_) => Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            const SizedBox(height: 10,),
            TextButton(
              onPressed: () => service.pickImage(),
              child: DashedRect(
                gap: 5,
                strokeWidth: 2.0,
                color: Colors.black,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: service.images.isNotEmpty?
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Stack(
                      children: [
                        PageView(
                          onPageChanged: (value){
                            setState(() {
                              current = value;
                            });
                          },
                          children: service.images.map((image) => Container(
                              child: Image.file(File(image.path)),
                            )).toList(),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              height: 40,
                              width: 90,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text("${current + 1}/${service.images.length}",style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),),
                                  ),
                                  GestureDetector(
                                      onTap: (){
                                        service.deleteImage(index: current);
                                      },
                                      child: const Icon(Icons.delete,color: Colors.black87)),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ):Container(
                      padding: const EdgeInsets.all(20),
                      child: const Icon(Icons.upload_file_outlined,size: 50,)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}