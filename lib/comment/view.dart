import 'package:enhanced_future_builder/enhanced_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:riceblog/generated/assets.dart';

import '../allfunc.dart';
import '../gloableFunc.dart';
import 'addcomment.dart';
import 'logic.dart';

class CommentPage extends StatelessWidget {
  CommentPage({Key? key}) : super(key: key);

  final logic = Get.put(CommentLogic());
  final Globallogic = Get.find<gloableLogic>();
  final AllFunc = allFunc();
  @override
  Widget build(BuildContext context) {
    String cid = Get.parameters['id'].toString();
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        //评论显示部分

        EnhancedFutureBuilder(
          future: logic.getComment(cid),
          rememberFutureResult: true,
          whenNotDone: Text("Loading"),
          whenDone: (Reultdata) {
            List data = Reultdata[0];
         //   print(data);
            List replyList = Reultdata[1];
            List parentsList = Reultdata[2];
            return MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("记录板",style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                      TextButton(
                        onPressed: () {
                          Get.bottomSheet(
                            ToAddNewComment(cid,context),
                          );
                        },
                        child: Text(
                          "留下评论",
                          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:data.length==0?1:data.length,
                    itemBuilder: (BuildContext context, int index) {
                      if(data.isEmpty){
                        return Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Center(
                            child: Text("还没有任何评论欸"),
                          ),
                        );
                      }
                      String avatarUrl = Globallogic.getAvatar(data[index]['mail']);
                      //  print(parentsList);
                      // print(data[index]['coid']);
                      if (parentsList.contains(data[index]['coid'])) {
                        // print("存在！！！！！！！！！！！！！！！！");
                        List showReplyList = [];
                        for (int i = 0; i < replyList.length; i++) {
                          if (replyList[i]['parent'] == data[index]['coid']) {
                            //   print("有！！！！！！！！！！！！！！！！！！！！！！！");
                            showReplyList.add(replyList[i]);
                          }
                        }
                        //有嵌套评论
                        return Container(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Flex(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                direction: Axis.horizontal,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(avatarUrl),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(10)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              child: Text(
                                                data[index]['author'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              onTap: () {
                                                if (data[index]['url'] != null) {
                                                  //  print("NAME");
                                                  LaunchUrl(data[index]['url']);
                                                }
                                              },
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              AllFunc.ShowDateTime(
                                                  data[index]['created']),
                                              style: TextStyle(
                                                  color: Colors.grey, fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          data[index]['text'],
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.bottomSheet(
                                                ToAddNewComment(cid,context,parent: data[index]['coid'])
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.send),
                                              Text("回复")
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: showReplyList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      String avatarUrl = Globallogic.getAvatar(
                                          showReplyList[index]['mail']);
                                      return Container(
                                        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                        alignment: Alignment.topLeft,
                                        child: Flex(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          direction: Axis.horizontal,
                                          children: [
                                            Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image:
                                                      NetworkImage(avatarUrl),
                                                      fit: BoxFit.cover),
                                                  borderRadius:
                                                  BorderRadius.circular(10)),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                        child: Text(
                                                          showReplyList[index]
                                                          ['author'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              fontSize: 20),
                                                        ),
                                                        onTap: () {
                                                          if (showReplyList[index]
                                                          ['url'] !=
                                                              null) {
                                                            //    print("NAME");
                                                            LaunchUrl(
                                                                showReplyList[index]
                                                                ['url']);
                                                          }
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        AllFunc.ShowDateTime(
                                                            showReplyList[index]
                                                            ['created']),
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    showReplyList[index]['text'],
                                                    style: TextStyle(fontSize: 16),
                                                  ),

                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        );
                      }
                      //没有
                      return Container(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                        alignment: Alignment.topLeft,
                        child: Flex(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          direction: Axis.horizontal,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(avatarUrl),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        child: Text(
                                          data[index]['author'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        onTap: () {
                                          if (data[index]['url'] != null) {
                                            //    print("NAME");
                                            LaunchUrl(data[index]['url']);
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        AllFunc.ShowDateTime(
                                            data[index]['created']),
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    data[index]['text'],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.bottomSheet(
                                        ToAddNewComment(cid,context,parent: data[index]['coid'])
                                      );
                                    },
                                    child: Row(
                                      children: [Icon(Icons.send), Text("回复")],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
