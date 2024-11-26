import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:markdown_widget/widget/span_node.dart';
import 'package:markdown/markdown.dart' as m;
final musicTag = "musicTag";
class MusicTag extends SpanNode {
  final Map<String, String> attribute;
  final MarkdownConfig config;
  MusicTag(this.attribute, this.config);

  @override
  InlineSpan build() {
    String id='0',type='song',typeid="2";
    // TODO: implement build
    // 使用正则表达式提取 id 的值
    RegExp regex = RegExp(r'id="([^"]+)"');
    // 查找匹配的内容
    RegExpMatch? match = regex.firstMatch(attribute['content']!);
    if (match != null) {
      String? idValue = match.group(1);
   //   print('ID 值: $idValue'); // 输出: ID 值: 1915909372
      id=idValue!;
    } else {
    //  print('未找到匹配的 ID 值');
    }
    //查找type
    RegExp regextype = RegExp(r'type="([^"]+)"');
    // 查找匹配的内容
    RegExpMatch? typematch = regextype.firstMatch(attribute['content']!);
    if (typematch != null) {
      String? typeValue = typematch.group(1);
      //print('Ty 值: $typeValue'); // 输出: ID 值: 1915909372
      type=typeValue!;
    } else {
   //   print('未找到匹配的 ID 值');
    }
    if(type =="playlist"){
      typeid = "0";
      return WidgetSpan(child: HtmlWidget(
          '''<iframe border="0"  width=330 height=450 src="//music.163.com/outchain/player?type='''+typeid+'''&id='''+id +'''&auto=0&height=430"></iframe>'''
      ));
    }

    return WidgetSpan(child: HtmlWidget(
      '''<iframe border="0"  width=330 height=86 src="//music.163.com/outchain/player?type=2&id='''+id +'''&auto=0&height=66"></iframe>'''
    ));
  }


}


SpanNodeGeneratorWithTag musicTagGenerator = SpanNodeGeneratorWithTag(
  tag: musicTag,
  generator: (e, config, visitor) {
    return MusicTag(e.attributes, config);
  },
);

class MusicTagHas extends m.InlineSyntax {
  MusicTagHas() : super(r'\[Meting\]([\s\S]*?)\[/Meting\]');

  @override
  bool onMatch(m.InlineParser parser, Match match) {
    String? content = "";
    m.Element el = m.Element.withTag(musicTag);
    RegExp regExp =RegExp(r'\[Meting\]([\s\S]*?)\[/Meting\]');
    final input = match.input;
  //  print("!!!!!!!!!!!WWWWWWWWWWWWWWWWWWWW");
    Iterable<Match> matches = regExp.allMatches(input);
    print(matches.length);
    for (Match match in matches) {
      content = match.group(1); // 提取第一个捕获组的内容
   //   print("内容是"+content.toString());
//print("这里是内容！！！！！");
    }
    el.attributes['content'] = content!;
    parser.addNode(el);
    return true;
  }
 }

