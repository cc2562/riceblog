import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:transparent_image/transparent_image.dart';

import '../generated/assets.dart';
import '../gloableFunc.dart';
import '../post/logic.dart';

Widget bcakground(BuildContext context) {
  final oneLogic = Get.find<gloableLogic>();
  return Column(
    children: [
      Transform.translate(
        offset: Offset(0, 0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * (3 / 4),
          child: ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment(0.0, 0.2),
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: Obx(() {
              return AnimatedSwitcher(
                  duration: Duration(milliseconds: 800),
                  switchInCurve: Curves.decelerate,
                  transitionBuilder: (child, anim) => FadeTransition(
                        opacity: anim,
                        child: child,
                      ),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: oneLogic.ImgUrl.value == ""
                        ? Assets.assetsTest
                        : oneLogic.ImgUrl.value,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * (3 / 4),key: ValueKey(oneLogic.ImgUrl.value),
                  ));
            }),
          ),
        ),
      ),
      Transform.translate(
        offset: Offset(0, -300),
        child: Container(
          width: ResponsiveBreakpoints.of(context).isTablet
              ? MediaQuery.of(context).size.width
              : 1000,
          height: 100,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "CC米饭的小世界",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                        offset: const Offset(0, 0),
                        blurRadius: 5.0,
                        color: Colors.black.withValues(alpha: 0.5)),
                  ],
                ),
              ),
              Text(
                "世界，再次构建",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(
                        offset: const Offset(0, 0),
                        blurRadius: 5.0,
                        color: Colors.black.withValues(alpha: 0.5)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
