import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CommentPage extends StatelessWidget {
  CommentPage({Key? key}) : super(key: key);

  final logic = Get.put(CommentLogic());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "昵称",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "URL",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "E-MAIL",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        TextField(
          minLines: 6,
          maxLines: 10,
          decoration: InputDecoration(
            hintText: "Comment",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 10,),
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: (){},
                  child: Text("发送")
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.topLeft,
          child:Flex(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            direction: Axis.horizontal,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("CC米饭",
                          style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),
                        ),
                        SizedBox(width: 5,),
                        Text("2024-11-08",
                          style: TextStyle(color: Colors.grey,fontSize: 14),
                        ),
                      ],
                    ),
                    Text("非常不错的一个文章很好",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(onPressed: (){}, child: Row(
                      children: [
                        Icon(Icons.send),Text("回复")
                      ],
                    ),)
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
