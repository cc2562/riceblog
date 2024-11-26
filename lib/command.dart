import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:riceblog/home/view.dart';
import 'package:riceblog/post/view.dart';

import 'gloableFunc.dart';

class Acrylic extends StatefulWidget {

  ///阴影颜色
  final Color shadowColor;
  ///背景颜色
  final Color bgColor;
  ///背景模糊度
  final double blur;
  ///组件高度
  ///组件宽度
  final double width;
  ///组件是否有圆角
  final BorderRadiusGeometry? borderRadius;
  ///阴影的高斯模糊
  final double blurRadius;
  ///子组件
  final Widget child;

  const Acrylic({
    Key? key,
    this.shadowColor =  Colors.transparent,
    this.bgColor = const Color.fromRGBO(175, 175, 175, 0.1),
    this.blur = 70.0,
    //required this.height,
    required this.width,
    this.borderRadius,
    this.blurRadius = 100.0,
    required this.child,
  }) : super(key: key);

  @override
  State<Acrylic> createState() => _AcrylicState();
}

class _AcrylicState extends State<Acrylic> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
         // height: widget.height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: widget.borderRadius,
              boxShadow: [BoxShadow(
                  color: widget.shadowColor,
                  blurRadius: widget.blurRadius,
                  blurStyle: BlurStyle.outer///外部阴影，内部不填充
              )]
          ),
          child: ClipRRect(
            child:BackdropFilter(///背景过滤器
              filter: ImageFilter.blur(sigmaX: widget.blur,sigmaY: widget.blur),///模糊度
              child: Container(///主体背景
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: widget.width,
               // height: widget.height,
                decoration: BoxDecoration(
                    color: widget.bgColor,
                    borderRadius: widget.borderRadius
                ),
                child: widget.child,
              ),
            ),
          ),
        ),

      ],
    );
  }
}

//自定义路由
class CustomRoute extends StatefulWidget{
  final String pageUrl;
  CustomRoute({
    Key? key,
    required this.pageUrl,
  });
  @override
  State<CustomRoute> createState() => _CustomRouteState();

}

class _CustomRouteState extends State<CustomRoute>{
  @override
  Widget build(BuildContext context) {
    final Gloablelogic = Get.find<gloableLogic>();
    // TODO: implement build
    var uri = Uri.parse(widget.pageUrl);
   // print("11111111gwg分开"+uri.pathSegments[0]);
    if(uri.pathSegments.length==2&&uri.pathSegments[0]=='post'){
      var postId = uri.pathSegments[1];
      print(postId);
      Gloablelogic.changePostId(postId);
      return PostPage();
    }
    if(uri.path=="/"){
      return HomePage();
    }
    return HomePage();
  }

}

