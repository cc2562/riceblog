import 'package:date_format/date_format.dart';
import 'package:get/get.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
class gloableLogic extends GetxController{
  RxString postId = 0.toString().obs;

  RxString ImgUrl="".obs;
  var uriName ="/";
  RxString title ="CC米饭的小世界".obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changePostId(String id){
    postId.value = id;
    update();
  }

  void changeUriName(String name){
    uriName = name;
    update();
  }


  void JumpPage(String value){
    var uri = Uri.parse(value);
    print(uri.pathSegments.toString());
    if(uri.pathSegments.length==1&&uri.pathSegments[0]=="post"){
      Get.toNamed(value);
    }
  }

  String getAvatar(String email){
    var tomd5 = utf8.encode(email);
    String md5Result = md5.convert(tomd5).toString();
    return "https://dn-qiniu-avatar.qbox.me/avatar/"+md5Result;

  }


}