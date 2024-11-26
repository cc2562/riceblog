import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:riceblog/doapi/postapi.dart';

import '../gloableFunc.dart';

class PostLogic extends GetxController {
  final oneLogic = Get.find<gloableLogic>();
  RxInt enableComment =1.obs;
  double verticalOffset = 0.0;
  void setVerticalOffset(double offset) {
    verticalOffset = offset;
    update();
  }

  void getSco(scrollDetails,context){
    verticalOffset = max(0,
        min(scrollDetails.pixels, scrollDetails.maxScrollExtent));
    //print(verticalOffset);
    //print(MediaQuery.of(context).size.height * (3 / 4)-300);
    update();
  }

  Future<List> getSinglePost(String cid) async {

    List resultData =[];
    var api = PostApi();
    var data =await api.GetSinglePost(cid);
    var fieldsData = await api.GetSinglePostFileds(cid);
    resultData.add(data);
    for(var i=0;i<fieldsData.length;i++) {
      Map fieldsMap = fieldsData[i];
  //    print(fieldsMap);
      if (fieldsMap.containsKey('status')) {
        oneLogic.ImgUrl.value="";
        //不存在信息
      } else {
        if (fieldsMap.containsKey('name') && fieldsMap['name'] == "imgurl") {
          //有图片属性
          if(fieldsMap['str_value']!=""){
            oneLogic.ImgUrl.value=fieldsMap['str_value'];
          }else{
            oneLogic.ImgUrl.value="";
          }
        }else{
          oneLogic.ImgUrl.value="";
        }
        if (fieldsMap.containsKey('name') && fieldsMap['name'] == "enableComment") {
          //有评论
          if(fieldsMap['str_value']!=""){
            enableComment.value = int.parse(fieldsMap['str_value']);
          }
        }
      }
    }
    oneLogic.title.value = data[0]['title']+"-CC米饭的小世界";
    resultData.add(fieldsData);
    return resultData;
  }
}
