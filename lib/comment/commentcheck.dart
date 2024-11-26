//comment加密验证模块
//传入评论内容，返回加密后的评论内容
import 'dart:convert';

import 'package:crypto/crypto.dart';

final String code ="zBt6VliP7If5eG6U17n6D6Scwn7kLy5V";
String encodeComment(String comment,String code) {
  String encode = "";
  for (int i = 0; i < comment.length; i++) {
    encode += String.fromCharCode(comment.codeUnitAt(i) + int.parse(code));
    //进行便宜
  }
  print('code:$code \n org = $comment');
  print(encode);
  encode = encode+code;
  encode = md5.convert(utf8.encode(encode)).toString();
  print(encode);
  return encode;
}