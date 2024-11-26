import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:riceblog/post/view.dart';

import '../post/logic.dart';
import '../widget/background.dart';
import '../widget/header.dart';
class fullPostPage extends StatefulWidget {
  const fullPostPage({super.key});

  @override
  State<fullPostPage> createState() => _fullPostPageState();
}

class _fullPostPageState extends State<fullPostPage> {
  final Postlogic = Get.put(PostLogic());
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollStartNotification>(
      onNotification: (_) {
        // 清除之前的偏移量
        return true;
      },
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: HeaerBody(context),
        body: Stack(
          children: [
            bcakground(context),
            PostPage()
            //CustomRoute(pageUrl:uriName )
          ],
        ),
      ),
    );
  }
}
