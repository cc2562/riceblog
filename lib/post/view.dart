import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:riceblog/comment/view.dart';
import 'package:riceblog/generated/assets.dart';

import '../command.dart';
import 'logic.dart';

class PostPage extends StatelessWidget {
  PostPage({Key? key}) : super(key: key);

  final logic = Get.put(PostLogic());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NotificationListener<ScrollUpdateNotification>(
          onNotification: (notification) {
            final scrollDetails = notification.metrics;
            // print(notification.toString());
            logic.getSco(scrollDetails, context);
            print("1");
            return true;
          },
          child: SingleChildScrollView(
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
                      bgColor: Theme.of(context).cardColor.withValues(alpha: 0.4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "当你吃下名为⌈补佳乐⌋的糖",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "2024-11-08",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Divider(),
                          Text(
                            "我们平常会吃很多糖，但这一颗似乎有一些不同。吃下它的那一刻，你便走上了一条与众不同的道路，在这条路上越往前走那颗糖就越发变得苦涩。这颗糖会让你认识到大脑是那样的屈服在激素之下，人类的智慧中枢，一个如此复杂的器官竟然会被一小串简单的分子式牢牢的控制住。当体内的雌激素越来越多时，你会发现自己的大脑好像被偷偷换掉了，变得更容易哭，变得焦虑甚至染上精神疾病。许你可以说这不是一颗糖，而是一颗包着薄薄糖衣的毒药。没错，这多么像毒药啊，它让人的大脑崩溃，患上千奇百怪的疾病，甚至可以让你原本的朋友开始远离你疏远你。这是多少神奇的一颗毒药。可当初你又为什么要吃下这一颗糖呢？是不是被这颗糖所说的效果迷昏了眼？乳房发育、皮肤细腻柔化、脂肪分布女性化、减缓雄激素引起的脱发......似乎这一切都是你想要的。只需要一颗糖就可以解决困扰自己多年的性别认同问题，谁不想试试呢？可惜的是，这东西可不是什么魔法。你会渐渐发觉似乎上面所说的效果并没有太大的体现。你依旧是那个骨架很大、穿不了女款鞋子的人。接着你会开始后悔，如果自己可以在青春期开始时吃糖就好了，这样就不会有骨架的发育、也不会有胡子、变声，但没有时光机的帮助，你又如何回到过去。也许你会开始羡慕那些生理性别的女性，但是却渴望成为男性的人们，似乎他们的目标远比自己的目标好实现。你每日进行伪音的练习，想要得到自己梦想中的声音，他们却似乎只需要服用激素就可以实现声音的降低。但你没有经历过，又何尝知道他们经历过的苦呢。无论是面对自己的副作用，还是对无法成为梦中自己的焦虑亦或是外界对你的质疑，你为什么依旧选择走下去呢。也许一直走下去总会在这条路上看到那一丁点光亮。",
                            style: TextStyle(fontSize: 18, height: 2),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(),
                          CommentPage()

                        ],
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
