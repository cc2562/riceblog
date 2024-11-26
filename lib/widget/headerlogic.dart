import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../main.dart';
class Headerlogic extends GetxController with GetTickerProviderStateMixin {
  late AnimationController controller;
  late Rx<AnimationController> menuController;
  RxBool showMenu = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    menuController = AnimationController(
        duration: Duration(milliseconds: 300),
        lowerBound: 0,
        upperBound: 0.4,
        vsync: this).obs;
    menuController.value.addListener(() {
      update();
    });
  }

  void changeShowMenu(){
    showMenu.value = !showMenu.value;
    print("改变:"+showMenu.value.toString());
    update();
  }

  void menuManger(){
    if (controller.isDismissed) {
      changeShowMenu();
      controller.forward();
      menuController.value.forward();
    } else {
      changeShowMenu();
      controller.reverse();
      menuController.value.reverse();
    }
  }

  void menuClose(){
    changeShowMenu();
    controller.reverse();
    menuController.value.reverse();
  }





}
