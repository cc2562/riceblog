import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

import 'package:markdown_widget/widget/blocks/leaf/heading.dart';
import 'package:markdown/markdown.dart' as m;

final noticeTag = 'noticetag';

class NoticeTag extends ElementNode {
  final Map<String, String> attribute;
  final MarkdownConfig config;
  NoticeTag(this.attribute, this.config);
  @override
  InlineSpan build() {
    // TODO: implement build
    return WidgetSpan(
      child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                decoration: BoxDecoration(
                  color: Color(0xff83ccd2).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(attribute['content']!),
              ),
            ),
          ],
        ),
    );
  }
}

SpanNodeGeneratorWithTag noticeTagGenerator = SpanNodeGeneratorWithTag(
  tag: noticeTag,
  generator: (e, config, visitor) {
    return NoticeTag(e.attributes, config);
  },
);

class NoticeTagHsa extends m.InlineSyntax {
  NoticeTagHsa() : super(r'\[notice\](.*?)\[/notice\]');

  @override
  bool onMatch(m.InlineParser parser, Match match) {
    String? content = "";
    m.Element el = m.Element.withTag(noticeTag);
    RegExp regExp = RegExp(r'\[notice\](.*?)\[/notice\]');
    final input = match.input;
    Iterable<Match> matches = regExp.allMatches(input);
    for (Match match in matches) {
      content = match.group(1); // 提取第一个捕获组的内容
    }
    el.attributes['content'] = content!;
    parser.addNode(el);
    return true;
  }
}
