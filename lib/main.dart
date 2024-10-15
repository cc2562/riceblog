import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:riceblog/command.dart';
import 'package:riceblog/generated/assets.dart';
import 'package:riceblog/post/logic.dart';
import 'package:riceblog/post/view.dart';
import 'package:riceblog/widget/background.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue.shade400, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue.shade400, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
        breakpoints: [
          const Breakpoint(start: 0, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final Postlogic = Get.put(PostLogic());
  final oneLogic = Get.find<PostLogic>();
  late AnimationController controller, menuController;
  bool showMenu = false;
  double _verticalOffset = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    menuController = AnimationController(
        duration: Duration(milliseconds: 300),
        lowerBound: 0,
        upperBound: 0.4,
        vsync: this);

    menuController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollStartNotification>(
      onNotification: (_) {
        // 清除之前的偏移量
        setState(() {
          _verticalOffset = 0.0;
        });
        return true;
      },
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(300),
          child: Container(
            alignment: Alignment.topCenter,
            height: 300,
            padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
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
                            if (controller.isDismissed) {
                              setState(() {
                                showMenu = true;
                              });
                              controller.forward();
                              menuController.forward();
                            } else {
                              setState(() {
                                showMenu = false;
                              });
                              controller.reverse();
                              menuController.reverse();
                            }
                          },
                          icon: AnimatedIcon(
                              icon: AnimatedIcons.menu_close,
                              progress: controller),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Visibility(
                  visible: showMenu,
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
                        .withValues(alpha: menuController.value),
                    child: Container(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text("首页"),
                            style: TextButton.styleFrom(
                                textStyle: TextStyle(fontSize: 20)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text("留言"),
                            style: TextButton.styleFrom(
                                textStyle: TextStyle(fontSize: 20)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text("友人帐"),
                            style: TextButton.styleFrom(
                                textStyle: TextStyle(fontSize: 20)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text("关于我"),
                            style: TextButton.styleFrom(
                                textStyle: TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            bcakground(context),
            PostPage(),
          ],
        ),
      ),
    );
  }
}
