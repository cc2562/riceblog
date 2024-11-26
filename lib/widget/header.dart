import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:riceblog/widget/headerlogic.dart';

import '../command.dart';
import '../gloableFunc.dart';
import '../main.dart';


PreferredSizeWidget HeaerBody(BuildContext context){
  final headerLogic =Get.put(Headerlogic());
  final Globallogic = Get.find<gloableLogic>();
  return PreferredSize(
    preferredSize: Size.fromHeight(300),
    child: Container(
      alignment: Alignment.topCenter,
      height: 300,
      padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
      child: Column(
        children: [
          Acrylic(
            width: ResponsiveBreakpoints.of(context).isTablet
                ? MediaQuery.of(context).size.width
                : 1000,
            borderRadius: BorderRadius.circular(100),
            bgColor: Theme.of(context).cardColor.withValues(alpha: 0.4),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(),
                  IconButton(
                    onPressed: () {
                      headerLogic.menuManger();
                    },
                    icon: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: headerLogic.controller),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Obx(
                  (){
                    return Visibility(
                      visible: headerLogic.showMenu.value,
                      child: Acrylic(
                        width: ResponsiveBreakpoints.of(context).isTablet
                            ? MediaQuery.of(context).size.width
                            : 1000,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        bgColor: Theme.of(context)
                            .cardColor
                            .withValues(alpha: headerLogic.menuController.value.value),
                        child: Container(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Globallogic.changeUriName("/");
                                  Get.toNamed('/');
                                  headerLogic.menuClose();
                                },
                                child: Text("首页"),
                                style: TextButton.styleFrom(
                                    textStyle: TextStyle(fontSize: 20,fontFamily: "LXGWWenKaiLite")),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed('/page?id=460');
                                  headerLogic.menuClose();
                                },
                                child: Text("留言"),
                                style: TextButton.styleFrom(
                                    textStyle: TextStyle(fontSize: 20,fontFamily: "LXGWWenKaiLite")),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed('/page?id=7');
                                  headerLogic.menuClose();
                                },
                                child: Text("友人帐"),
                                style: TextButton.styleFrom(
                                    textStyle: TextStyle(fontSize: 20,fontFamily: "LXGWWenKaiLite")),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed('/page?id=71');
                                  headerLogic.menuClose();
                                },
                                child: Text("关于我"),
                                style: TextButton.styleFrom(
                                    textStyle: TextStyle(fontSize: 20,fontFamily: "LXGWWenKaiLite")),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
          ),

        ],
      ),
    ),
  );
}