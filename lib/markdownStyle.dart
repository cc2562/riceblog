import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

import 'package:markdown_widget/widget/blocks/leaf/heading.dart';
import 'package:markdown/markdown.dart' as m;
class CustomH1Config extends H1Config {
  const CustomH1Config({
    this.style = const TextStyle(
      fontSize: 32,
      height: 40 / 32,
      fontWeight: FontWeight.bold,
    ),
  });
  // @override
  @override
  final TextStyle style;

  static H1Config get darkConfig => H1Config(
    style: TextStyle(
      fontSize: 32,
      height: 40 / 32,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );
  @override
  HeadingDivider? get divider => null;
}

class CustomH2config extends H2Config{

  const CustomH2config({
    this.style = const TextStyle(
      fontSize: 24,
      height: 32 / 24,
      fontWeight: FontWeight.bold,
    ),
  });
  // @override
  @override
  final TextStyle style;

  static H2Config get darkConfig => H2Config(
    style: TextStyle(
      fontSize: 24,
      height: 32 / 24,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    )
  );
  @override
  // TODO: implement divider
  HeadingDivider? get divider => null;

}
final tag = "test";
class CustomH3config extends H3Config{
  const CustomH3config({
    this.style = const TextStyle(
      fontSize: 20,
      height: 24 / 20,
      fontWeight: FontWeight.bold,
    ),
  });
  // @override
  @override
  final TextStyle style;

  static H3Config get darkConfig => H3Config(
    style: TextStyle(
      fontSize: 20,
      height: 24 / 20,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    )
  );
  @override
  // TODO: implement divider
  HeadingDivider? get divider => null;
}

class TestTage extends SpanNode{
  final Map<String, String> attribute;
  final MarkdownConfig config;

  TestTage(this.attribute,this.config);
  @override
  InlineSpan build() {
    print("有进行BUILDD!!!!!!!!!!!!!!!!!!!!!!!!");
    print(attribute['content']);
    return WidgetSpan(child: Container(
      child: Text(attribute['content']!),
      color: Colors.red,
    ));
  }

}

SpanNodeGeneratorWithTag testTagGenerator =SpanNodeGeneratorWithTag(tag: tag,
  generator: (e,config,visitor){
  print("有！！！！！！！！！！！！！！！！！！！！！！！");
  return TestTage(e.attributes,config);
  },
);

class TestTagHas extends  m.InlineSyntax {
  TestTagHas():super(r'\[\!(.*?)\!\]');

  @override
  bool onMatch(m.InlineParser parser, Match match) {
    String? content ="";
    m.Element el = m.Element.withTag(tag);
    RegExp regExp = RegExp(r'\[!(.*?)!\]');
    final input = match.input;
    print("INPUT是："+input);
    Iterable<Match> matches = regExp.allMatches(input);
    for (Match match in matches) {
       content = match.group(1); // 提取第一个捕获组的内容
    }
    el.attributes['content'] = content!;
    parser.addNode(el);
    return true;
  }
}