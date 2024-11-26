import 'package:enhanced_future_builder/enhanced_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:riceblog/comment/view.dart';
import 'package:riceblog/generated/assets.dart';
import 'package:riceblog/gloableFunc.dart';
import 'package:riceblog/markdown/customMusicWidget.dart';
import 'package:riceblog/markdown/custommarkdownwarnwidget.dart';
import 'package:riceblog/markdown/linksMarkdownWidget.dart';
import 'package:riceblog/markdownStyle.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:transparent_image/transparent_image.dart';

import '../allfunc.dart';
import '../command.dart';
import '../gloableFunc.dart';
import '../markdown/custommarkdownnoticewidget.dart';
import 'logic.dart';
import 'package:flutter_highlight/themes/a11y-light.dart';

class PostPage extends StatefulWidget {
  PostPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PostPageState();
  }
}

class _PostPageState extends State<PostPage> {
  String cid = Get.parameters['id'].toString();
  final AllFunc = allFunc();
   final logic = Get.put(PostLogic());
  final Gloablelogic = Get.find<gloableLogic>();
  late Future postFuture = logic.getSinglePost(cid);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final singleController = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, 0),
      suggestedRowHeight: 0,
    );
    return Stack(
      children: [
        Obx(
          () => Title(
            color: Theme.of(context).colorScheme.surface,
            child: Text(""),
            title: Gloablelogic.title.value,
          ),
        ),
        NotificationListener<ScrollUpdateNotification>(
          onNotification: (notification) {
            final scrollDetails = notification.metrics;
            // print(notification.toString());
            logic.getSco(scrollDetails, context);
            // print("1");
            return true;
          },
          child: SingleChildScrollView(
            controller: singleController,
            physics: const AlwaysScrollableScrollPhysics(),
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
                    child: Acrylic(
                      width: ResponsiveBreakpoints.of(context).isTablet
                          ? MediaQuery.of(context).size.width
                          : 1000,
                      borderRadius: BorderRadius.circular(10),
                      bgColor:
                          Theme.of(context).cardColor.withValues(alpha: 0.4),
                      child: EnhancedFutureBuilder(
                        future: postFuture,
                        rememberFutureResult: true,
                        whenNotDone: Skeletonizer(
                          enabled: true,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "这里是一段标题文本的样子",
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "2024-11-08",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed sodales leo. Vivamus nec sem dui. Pellentesque semper nunc sit amet consequat maximus. Cras hendrerit nisl libero, quis pharetra velit lobortis eget. Sed dapibus gravida quam non luctus. Mauris et commodo diam. In quis arcu tempus, viverra mi ullamcorper, fermentum velit. Vivamus consectetur, magna nec ornare condimentum, mi nisl pretium urna, id scelerisque urna arcu in lorem. Fusce auctor, ipsum quis aliquet blandit, risus justo molestie libero, quis aliquet arcu lacus vel nisl. In hac habitasse platea dictumst. Praesent ac eros ac libero consequat venenatis.",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        whenDone: (ResultData) {
                          var datas = ResultData[0];
                          Map dataMap = datas[0];
                          String text =
                              dataMap['text'].replaceAll("<!--markdown-->", "");
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoScrollTag(key: ValueKey('top'), controller: singleController, index: 1,child: Text(""),),
                              AutoScrollTag(key: ValueKey('title'), controller: singleController, index: 2,child: Text(
                                dataMap['title'],
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),),
                              Text(
                                AllFunc.ShowDateTime(dataMap['created']),
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                              SizedBox(height: 15,),
                              MarkdownBlock(
                                data: text,
                                config: MarkdownConfig(
                                  configs: [
                                    CustomH1Config(),
                                    CustomH2config(),
                                    CustomH3config(),
                                    isDark
                                        ? BlockquoteConfig(
                                            textColor: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .color!,
                                            sideColor: Color(0xff745399),
                                          )
                                        : BlockquoteConfig(
                                            textColor: Color(0xff745399),
                                            sideColor: Color(0xff745399),
                                          ),
                                    LinkConfig(
                                      style: TextStyle(
                                          color: Color(0xff745399),
                                          decoration: TextDecoration.underline),
                                    ),
                                    isDark
                                        ? PreConfig(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color(0xffd6e9ca)
                                                  .withValues(alpha: 0.2),
                                            ),
                                          )
                                        : PreConfig(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color(0xffd6e9ca)
                                                  .withValues(alpha: 0.2),
                                            ),
                                          ),
                                    isDark
                                        ? CodeConfig(
                                            style: TextStyle(
                                              backgroundColor: Color(0xffd6e9ca)
                                                  .withValues(alpha: 0.2),
                                            ),
                                          )
                                        : CodeConfig(
                                            style: TextStyle(
                                              backgroundColor: Color(0xffd6e9ca)
                                                  .withValues(alpha: 0.2),
                                            ),
                                          ),
                                    ImgConfig(
                                      builder: ( String url, Map<String, String> attributes){
                                        return FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: url, width: MediaQuery.of(context).size.width,fit: BoxFit.contain,);
                                      }
                                    )
                                  ],
                                ),
                                generator: MarkdownGenerator(
                                  generators: [
                                    testTagGenerator,
                                    noticeTagGenerator,
                                    warnTagGenerator,
                                    linksTagGenerator,
                                    musicTagGenerator,
                                  ],
                                  inlineSyntaxList: [
                                    TestTagHas(),
                                    NoticeTagHsa(),
                                    WarnTagHas(),
                                    LinkTagHas(),
                                    MusicTagHas(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //   Divider(),
                              Obx(() => logic.enableComment == 0 &&
                                      dataMap['type'] == 'page'
                                  ? Text("")
                                  : CommentPage()),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
