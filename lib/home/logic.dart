import 'dart:math';



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riceblog/doapi/postapi.dart';

class HomeLogic extends GetxController {
  String page = "1";
  //late final Future myFuture;
  var pa = Get.parameters['page'] == null ? "1" : Get.parameters['page'].toString();
 // late Future myFuture = GetPostList(Get.parameters['page'] == null ? "1" : Get.parameters['page'].toString());

  @override
  void refresh() {
    // TODO: implement refresh
    super.refresh();
    //myFuture = GetPostList(Get.parameters['page'] == null ? "1" : Get.parameters['page'].toString());
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  //  print("INIT");
  }

  onReady() {
    super.onReady();
   // myFuture =GetPostList(pa);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   // print('Dis');
  }

  @override
  void onClose() {
    super.onClose();
  }

  double verticalOffset = 0.0;
  void setVerticalOffset(double offset) {
    verticalOffset = offset;
    update();
  }

  void getSco(scrollDetails,context){
    verticalOffset = max(0,
        min(scrollDetails.pixels, scrollDetails.maxScrollExtent));
   // print(verticalOffset);
    //print(MediaQuery.of(context).size.height * (3 / 4)-300);
    update();
  }

  Future<List> GetPostList(String page) async {
    var api = PostApi();
    var data =await api.GetPostList(page);
    if(data[0]['error'] ==null){
     // print(data);
      return data;
    }else{
      await Get.toNamed('/');
      return data;
    }

  }


}
