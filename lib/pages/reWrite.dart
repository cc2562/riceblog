import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class RewritePage extends StatefulWidget {
  const RewritePage({super.key});

  @override
  State<RewritePage> createState() => _RewritePageState();
}

class _RewritePageState extends State<RewritePage> {
  String routePath = Get.currentRoute;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }





  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final path = this.routePath;
      final match = RegExp(r'/archives/(\w+)/?').firstMatch(path);
      if (match != null) {
        final myId = match.group(1);
        final newUrl = '/post?id=$myId';

        // 重定向到新的URL
        Get.toNamed(newUrl);
      }
    });

    return const Text("");
  }
}
