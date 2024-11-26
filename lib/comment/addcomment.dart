import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:riceblog/command.dart';
import 'package:riceblog/comment/commentcheck.dart';

import '../allfunc.dart';
import '../gloableFunc.dart';
import 'logic.dart';



Widget ToAddNewComment(String cid,context,{String parent ="0"}){
  final logic = Get.find<CommentLogic>();
  final Globallogic = Get.find<gloableLogic>();
  final AllFunc = allFunc();
  return  SingleChildScrollView(
    child: Acrylic(
      borderRadius: BorderRadius.circular(10),
      bgColor: Theme.of(context).cardColor.withValues(alpha: 0.4),
      width:  ResponsiveBreakpoints.of(context).isTablet
          ? MediaQuery.of(context).size.width
          : 1000,
      child: Container(
        decoration: BoxDecoration(
          //color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
        ),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("发送评论",style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (s) {
                      logic.user.value = s;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffdbd0e6).withValues(alpha: 0.4),
                      errorText: null,
                      hintText: "昵称*",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(style: BorderStyle.none, width: 0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.url,
                    onChanged: (s) {
                      logic.url.value = s;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffdbd0e6).withValues(alpha: 0.4),
                      hintText: "URL",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(style: BorderStyle.none, width: 0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    onChanged: (s) {
                      logic.mail.value = s;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffdbd0e6).withValues(alpha: 0.4),
                      hintText: "E-MAIL",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(style: BorderStyle.none, width: 0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
                onChanged: (s) {
                  logic.text.value = s;
                },
                minLines: 6,
                maxLines: 10,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffdbd0e6).withValues(alpha: 0.4),
                  hintText: "Comment*",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(style: BorderStyle.none, width: 0)),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[\\/\*#%]')) //设置只允许输入数字
                ]),
            SizedBox(
              height: 10,
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Obx(() {
                  return Expanded(
                    child: TextField(
                      onTap: () {
                        logic.GetCaptcha();
                      },
                      onChanged: (s) {
                        logic.inputNum.value = s;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffdbd0e6).withValues(alpha: 0.4),
                        hintText: logic.captchahint.value,
                        helperText: logic.captchahint.value=="验证码，点我出现"?null:logic.captchahint.value,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(style: BorderStyle.none, width: 0)),
                      ),
                    ),
                    flex: 8,
                  );
                }),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () async {

                      if (logic.text.value.isEmpty || logic.user.value.isEmpty) {
                        Get.snackbar("出错啦", "请输入昵称和评论内容");
                        return;
                      }
                      if (logic.inputNum.value.isEmpty) {
                        Get.snackbar("出错啦", "请输入验证码");
                        return;
                      }
                      if (logic.VerifyCaptcha(logic.inputNum.value)) {
                        Get.snackbar("请稍候", "正在发送评论~");
                        var key = encodeComment(logic.text.value, (logic.onenum+logic.twonum).toString());
                        await logic.postComment(cid,key,parent);
                        String routePath = Get.currentRoute;
                        Get.offAndToNamed(routePath);
                      } else {
                        Get.snackbar("出错啦", "验证码错误");
                        return;
                      }
                    },
                    child: Text("发送"),),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
