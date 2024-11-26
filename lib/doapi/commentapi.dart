import 'package:dio/dio.dart';
import 'package:riceblog/doapi/apiIni.dart';
import 'package:riceblog/doapi/diomanger.dart';

class CommentApi {
  Future<List> GetComment(String cid) async {
    String url = ApiConfig.baseUrl +
        ApiConfig.getCommentUrl +
        "?cid=" +
        int.parse(cid).toString();
    DioManager manager = DioManager.getInstance();
    Response response = await manager.get(url);
    //print(url);
    // print(response);
    List<dynamic> data = response.data;
    //print(data);
    return data;
  }

  Future<bool> AddComment(String cid, String created, String author,
      String text, String mail, String url,String key,String code,String parent) async {
    String url = ApiConfig.baseUrl + ApiConfig.addComment;
    DioManager manager = DioManager.getInstance();
    Response response = await manager.post(
      url,
      params: <String, String>{
        "cid": cid,
        "created": created,
        "author": author,
        "text": text,
        "url": url,
        "mail": mail,
        "authorId": "0",
        "parent":parent,
        "key":key,
        "code":code,
      },
    );
    //print(url);
   // print(response);
    return true;
  }
}
