import 'dart:math';

import 'package:get/get.dart';
import 'package:riceblog/doapi/commentapi.dart';

class CommentLogic extends GetxController {
  RxString user ="".obs,url ="".obs,mail="".obs,text="".obs;
  RxString captchahint ="验证码，点我出现".obs;
  int onenum=0;
  int twonum=0;
  RxString inputNum = "".obs;
  Map<String,String?> newComment = {
    "cid": null,
    "created": null,
    "author":null,
    "text":null,
    "mail":null,
    "authorId":null
  };
  Future<List> getComment(String cid) async {
    List mainCommentIDlist = [];
    List mainCommentList = [];
    List replyCommentList = [];
    List hasReplyList = [];
    var api = CommentApi();
    var data =await api.GetComment(cid);
    for(var i=0;i<data.length;i++){
   //   print(data[i]);
    //  print('-------------------------------');
      if(data[i]['parent']=="0"){
        mainCommentList.add(data[i]);
        mainCommentIDlist.add(data[i]['coid']);
      }else{
        //判断是否是

        replyCommentList.add(data[i]);
        if( hasReplyList.contains(data[i]['parent'])){

        }else{
          hasReplyList.add(data[i]['parent']);
        }

      }
    }
    //处理评论嵌套
    void GetTheFirstComment(Map toCheckData){

    }
    for(int i=0;i<replyCommentList.length;i++){
      bool isHasinMainList=false;
      if(mainCommentIDlist.contains(data[i]['parent'])){
        isHasinMainList=true;
      }else{
        //print("发现二次");
        //print(data[i]);
        for(int v=0;v<data.length;v++){
          if(data[v]['coid']==data[i]['parent']){
            //找到对应
            //print("找到对应！！");
            //print("对应内容："+data[v]['coid'].toString());
            if(data[v]['parent']=='0'){
              //是第二个
              data[i]['parent'] = data[v]['coid'];
              isHasinMainList =true;
            }else{
              if(mainCommentIDlist.contains(data[v]['parent'])){
                data[i]['parent'] = data[v]['parent'];
                isHasinMainList =true;
              }else{
                //print("发现三次");
                for(int w=0;v<data.length;v++){
                  if(data[w]['coid']==data[v]['parent']){
                    //找到对应
                   // print("找到对应！！");
                  //  print("对应内容："+data[v]['coid'].toString());
                    if(data[w]['parent']=='0'){
                      //是第3个
                      data[v]['parent'] = data[w]['coid'];
                      isHasinMainList =true;
                    }else{
                      if(mainCommentIDlist.contains(data[w]['parent'])){
                        data[v]['parent'] = data[w]['parent'];
                        isHasinMainList =true;
                      }
                    }
                  }
                }
                //
                data[i]['parent'] = data[v]['parent'];
              }
            }
          }
        }
      }
    //  print('处理完成');
    }
    //print('----------主评论------------');
  //  print(mainCommentList);
 //   print('----------回复评论------------');
   // print(replyCommentList);
   // print('-----------id----------------');
   // print(hasReplyList);
    replyCommentList.sort((a,b)=>a['created'].compareTo(b['created']));
    List resuleData = [];
    resuleData.add(mainCommentList);
    resuleData.add(replyCommentList);
    resuleData.add(hasReplyList);
  //  print(resuleData.length);
    return resuleData;
  }
  //发布评论
  Future<bool> postComment(String cid,String key,String parent) async {
    var api = CommentApi();
    newComment['cid'] = cid;
    newComment['text'] = text.value;
    newComment['created'] = (DateTime.now().millisecondsSinceEpoch.toDouble()/1000).toInt().toString();
    newComment['author'] = user.value;
    newComment['mail'] = mail.value;
    newComment['url'] = url.value;
    newComment['authorId'] = '0';
    newComment['key'] =key;
    var res = await api.AddComment(cid,  newComment['created']!, newComment['author']!, newComment['text']!, newComment['mail']!, newComment['url']!,key,(onenum+twonum).toString(),parent);
    newComment =={};
    onenum =0;
    twonum =0;

    return res;
  }
  int RandomNum(int min, int max) {
    int res = min + Random().nextInt(max - min + 1);
    return res;
  }
  void GetCaptcha(){
    onenum = RandomNum(1,9);
    twonum = RandomNum(1,9);
    captchahint.value = '请计算：'+onenum.toString()+'+'+twonum.toString()+'=?';
  }
  bool VerifyCaptcha(String input){
    if(onenum==0||twonum==0){
      return false;
    }
    if(input == (onenum+twonum).toString()){
      return true;
    }else{
      return false;
    }
  }
}
