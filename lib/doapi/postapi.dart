
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:riceblog/doapi/apiIni.dart';
import 'package:riceblog/doapi/diomanger.dart';

class PostApi{

  Future<List> GetPostList(String page) async {
    String url = ApiConfig.baseUrl+ApiConfig.getPostUrl+"?page="+int.parse(page).toString();
    DioManager manager = DioManager.getInstance();
    Response response = await manager.get(url);
    //print(url);
   // print(response);
    List<dynamic> data = response.data;
    //print("进行了一次运行");
    return data;
  }

  Future<List> GetSinglePost(String cid) async {
    String url = ApiConfig.baseUrl+ApiConfig.getPostByIdUrl+"?cid="+int.parse(cid).toString();
    DioManager manager = DioManager.getInstance();
    Response response = await manager.get(url);
   // print(url);
    //print(response);
   // print(response.data.toString());
    //String theListJson = "[" + response.data.toString() + "]";
    //print(theListJson);
    //List jsons = json.decode(theListJson) as List<dynamic>;
    //List<dynamic> data = response.data;
    //print(jsons);
    return response.data;
  }

  Future<List> GetSinglePostFileds(String cid) async {
    String url = ApiConfig.baseUrl+ApiConfig.getsinglePostFields;
    DioManager manager = DioManager.getInstance();
    Response response = await manager.post(url, params: {"cid":cid});
  //  print(response.data);
    return response.data;
  }

  Future<List> GetLinks() async {
    String url = ApiConfig.baseUrl+ApiConfig.getLinks;
    DioManager manager = DioManager.getInstance();
    Response response = await manager.get(url);
    return response.data;
  }
}