import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:riceblog/home/view.dart';
import 'package:riceblog/post/view.dart';

import '../home/logic.dart';
import '../post/logic.dart';
import '../widget/background.dart';
import '../widget/header.dart';
class fullHomePage extends StatefulWidget {
  const fullHomePage({super.key});

  @override
  State<fullHomePage> createState() => _fullHomePageState();
}

class _fullHomePageState extends State<fullHomePage> {
  final Postlogic = Get.put(PostLogic());
  final logic = Get.put(HomeLogic());
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollStartNotification>(
      onNotification: (_) {
        // 清除之前的偏移量
        return true;
      },
      child:Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: HeaerBody(context),
        body: Stack(
          children: [
            bcakground(context),
            HomePage()
            //CustomRoute(pageUrl:uriName )
          ],
        ),
      ),
    );
  }
}
