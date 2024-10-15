import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostLogic extends GetxController {
  double verticalOffset = 0.0;
  void setVerticalOffset(double offset) {
    verticalOffset = offset;
    update();
  }

  void getSco(scrollDetails,context){
    verticalOffset = max(0,
        min(scrollDetails.pixels, scrollDetails.maxScrollExtent));
    print(verticalOffset);
    print(MediaQuery.of(context).size.height * (3 / 4)-300);
    update();
  }
}
