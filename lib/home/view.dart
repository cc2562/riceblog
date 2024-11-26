import 'package:date_format/date_format.dart';
import 'package:enhanced_future_builder/enhanced_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/blocks/container/blockquote.dart';
import 'package:markdown_widget/widget/blocks/leaf/link.dart';
import 'package:markdown_widget/widget/markdown_block.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:riceblog/allfunc.dart';
import 'package:riceblog/gloableFunc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../command.dart';
import '../post/logic.dart';
import 'logic.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  final Postlogic = Get.find<PostLogic>();
  final logic = Get.find<HomeLogic>();
  final AllFunc = allFunc();
  String nowpage =
  Get.parameters['page'] == null ? "1" : Get.parameters['page'].toString();
  late Future myFuture = logic.GetPostList(Get.parameters['page'] == null ? "1" : Get.parameters['page'].toString());

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        final scrollDetails = notification.metrics;
        // print(notification.toString());
        logic.getSco(scrollDetails, context);
        //  print("1");
        return true;
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                offset: Offset(0, -logic.verticalOffset / 100),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * (3 / 4),
                ),
              ),
              // 其他内容可以放在这里
              Transform.translate(
                offset: Offset(0, -200),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Acrylic(
                    width: ResponsiveBreakpoints.of(context).isTablet
                        ? MediaQuery.of(context).size.width
                        : 1000,
                    borderRadius: BorderRadius.circular(10),
                    bgColor: Theme.of(context).cardColor.withValues(alpha: 0.4),
                    child: EnhancedFutureBuilder(
                      future: myFuture,
                      rememberFutureResult: true,
                      whenNotDone:  Skeletonizer(
                        enabled: true,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 7,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 5, 10),
                              child: InkWell(
                                hoverColor:
                                Theme.of(context).colorScheme.onPrimary,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  // margin: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "TITLETITELTITLETITEL",
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue.shade200,
                                        ),
                                      ),
                                      Text(
                                        "showTime",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      // Text(text,style: TextStyle(fontSize: 17),),
                                      MarkdownBlock(
                                        data: '这里有一二三四五六七八九零十ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz',
                                        config: MarkdownConfig(configs: [
                                          isDark
                                              ? BlockquoteConfig(
                                            textColor: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .color!,
                                            sideColor:
                                            Color(0xff745399),
                                          )
                                              : BlockquoteConfig(
                                            textColor:
                                            Color(0xff745399),
                                            sideColor:
                                            Color(0xff745399),
                                          ),
                                          LinkConfig(
                                            style: TextStyle(
                                                color: Color(0xff745399),
                                                decoration:
                                                TextDecoration.underline),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      whenDone: (data) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length + 1,
                          itemBuilder: (context, index) {
                            if (index < data.length) {
                              var showTime = AllFunc.ShowDateTime(data[index]['created']);
                              var timeStr = data[index]['created'] + "000";
                              var time = DateTime.fromMillisecondsSinceEpoch(
                                int.parse(timeStr),
                              );
                              RegExp exp = RegExp(r'\[(.*?)\]');

                              String text = data[index]['text']
                                  .replaceAll("<!--markdown-->", "");
                              if(text.length<35){
                                text =text;
                              }else{
                                text = text.substring(0, 35);
                              }

                              text = text.replaceAll('>', "");
                              text = text.replaceAll('#', "");
                              text =text.replaceAll('-', "");
                              text = text.replaceAll(exp, '');
                              text = text + "...";
                              //String text = data[index]['text'].replaceAll(exp, "");
                              return Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 5, 10),
                                child: InkWell(
                                  hoverColor:
                                  Theme.of(context).colorScheme.onPrimary,
                                  onTap: () {
                                    Get.toNamed(
                                      '/post?id=' + data[index]['cid'],
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    // margin: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data[index]['title'],
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue.shade200,
                                          ),
                                        ),
                                        Text(
                                          showTime,
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        // Text(text,style: TextStyle(fontSize: 17),),
                                        MarkdownBlock(
                                          data: text,
                                          config: MarkdownConfig(configs: [
                                            isDark
                                                ? BlockquoteConfig(
                                              textColor: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .color!,
                                              sideColor:
                                              Color(0xff745399),
                                            )
                                                : BlockquoteConfig(
                                              textColor:
                                              Color(0xff745399),
                                              sideColor:
                                              Color(0xff745399),
                                            ),
                                            LinkConfig(
                                              style: TextStyle(
                                                  color: Color(0xff745399),
                                                  decoration:
                                                  TextDecoration.underline),
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Flex(
                                direction: Axis.horizontal,
                                children: [
                                  int.parse(nowpage) == 1
                                      ? Text("")
                                      : Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed('/?page=' +
                                            (int.parse(nowpage) - 1)
                                                .toString());
                                      },
                                      child: Text("上一页"),
                                    ),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed('/?page=' +
                                            (int.parse(nowpage) + 1)
                                                .toString());
                                      },
                                      child: Text("下一页"),
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        );
                      },
                      whenError: (e){
                        var routePath = Get.currentRoute;
                        return Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("哇啊 小世界崩溃了",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
                              Text("你的浏览器和网络在正常工作，这不是你的问题",style: TextStyle(fontWeight: FontWeight.bold),),
                              TextButton(onPressed: (){
                                Get.offAllNamed(routePath);
                              }, child: Text("点我刷新")),
                              Text(e.toString(),style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
