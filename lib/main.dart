import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:riceblog/command.dart';
import 'package:riceblog/generated/assets.dart';
import 'package:riceblog/gloableFunc.dart';
import 'package:riceblog/pages/fullHomePage.dart';
import 'package:riceblog/pages/fullPostPage.dart';
import 'package:riceblog/pages/reWrite.dart';
import 'package:riceblog/post/logic.dart';
import 'package:riceblog/post/view.dart';
import 'package:riceblog/widget/background.dart';
import 'package:riceblog/widget/header.dart';

import 'home/view.dart';

void main()  {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Globallogic = Get.put(gloableLogic());
    return GetMaterialApp(

      defaultTransition: Transition.fadeIn,
      initialRoute: '/',
      routingCallback: (routing){
        if(routing?.current=='/post'||routing?.current!='/page'){

        }
        if(routing?.isBack == true){
          print("BACK");
          print(routing?.current.toString());
          if(routing!.current.contains('/?page')||routing!.current=='/'){
            Globallogic.ImgUrl.value = "";
            Globallogic.title.value = "CC米饭的小世界";
          }
        }else if(routing!.current.contains('/?page')||routing!.current=='/'){
          Globallogic.ImgUrl.value = "";
          Globallogic.title.value = "CC米饭的小世界";
        }

      },
      getPages: [
        GetPage(
          name: '/',
          page: () => ResponsiveBreakpoints.builder(
            child: const fullHomePage(),
            breakpoints: [
              const Breakpoint(start: 0, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          ),
        ),
        GetPage(
          name: '/post',
        //  transition: Transition.zoom,
          page: () => ResponsiveBreakpoints.builder(
            child: fullPostPage(),
            breakpoints: [
              const Breakpoint(start: 0, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          ),
        ),
        GetPage(
          name: '/page',
          //  transition: Transition.zoom,
          page: () => ResponsiveBreakpoints.builder(
            child: fullPostPage(),
            breakpoints: [
              const Breakpoint(start: 0, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          ),
        ),
        GetPage(
          name: '/archives',
          page: ()=>ResponsiveBreakpoints.builder(
            child: RewritePage(),
            breakpoints: [
              const Breakpoint(start: 0, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          ),
        )
      ],
      title: Globallogic.title.value,
      theme: ThemeData(
        fontFamily: 'LXGWWenKaiLite',
        fontFamilyFallback: ['Arial',"Noto Sans Symbols",'华文细黑','Microsoft YaHei','微软雅黑','Roboto','sans-serif'],
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xff745399), brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        fontFamily: 'LXGWWenKaiLite',
        fontFamilyFallback: ['Arial',"Noto Sans Symbols",'华文细黑','Microsoft YaHei','微软雅黑','Roboto','sans-serif'],
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xff745399), brightness: Brightness.dark),
        useMaterial3: true,
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

class _MyHomePageState extends State<MyHomePage> {
//  final Globallogic =Get.put(gloableLogic());

  final Globallogic = Get.find<gloableLogic>();
  double _verticalOffset = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
