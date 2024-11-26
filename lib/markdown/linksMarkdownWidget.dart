import 'package:enhanced_future_builder/enhanced_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

import 'package:markdown_widget/widget/blocks/leaf/heading.dart';
import 'package:markdown/markdown.dart' as m;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:riceblog/allfunc.dart';
import 'package:riceblog/doapi/postapi.dart';
import 'package:skeletonizer/skeletonizer.dart';

final linksTag = 'LinksTag';

class LinksWidget extends StatefulWidget {
  const LinksWidget({super.key});

  @override
  State<LinksWidget> createState() => _LinksWidgetState();
}
Future<List> GetLinkData() async {
  var api = PostApi();
  List data =await api.GetLinks();
  return data;
}
late Future future = GetLinkData();
class _LinksWidgetState extends State<LinksWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: EnhancedFutureBuilder(
          future: future,
          rememberFutureResult: true,
          whenNotDone: Skeletonizer(
            enabled: true,
            child:  GridView.builder(
              shrinkWrap: true,
              itemCount:8,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index){
                return Container(
                  height: 80,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xffebf6f7)
                          .withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Flex(
                      mainAxisAlignment: MainAxisAlignment.start,
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                              radius: 100,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "这里是名字",
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "这里是一段很长很长的简介",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]
                  ),
                );
              },
            ),
          ),
        whenDone: (data){
            return GridView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3,
                crossAxisCount:  ResponsiveBreakpoints.of(context).isTablet
                    ? 1
                    : 2,
              ),
              itemBuilder: (context, index){
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xffebf6f7)
                        .withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: InkWell(
                    onTap: (){
                      LaunchUrl(data[index]['url']);
                    },
                    child: Flex(
                        mainAxisAlignment: MainAxisAlignment.start,
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: CircleAvatar(
                                  radius: 100,
                                  foregroundImage:  NetworkImage(data[index]['image']),
                                  child: Text(data[index]['name'].toString().substring(0,1)),
                                ),
                              ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    data[index]['name'],
                                    style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    data[index]['description'],
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]
                    ),
                  ),
                );
              },
            );
        },
      ),
    );
  }
}

class LinksTag extends SpanNode {
  final Map<String, String> attribute;
  final MarkdownConfig config;
  LinksTag(this.attribute, this.config);
  @override
  InlineSpan build() {
    // TODO: implement build
    return WidgetSpan(
      child: LinksWidget(),
    );
  }
}

SpanNodeGeneratorWithTag linksTagGenerator = SpanNodeGeneratorWithTag(
  tag: linksTag,
  generator: (e, config, visitor) {
    return LinksTag(e.attributes, config);
  },
);

class LinkTagHas extends m.InlineSyntax {
  LinkTagHas() : super(r'\[links\](.*?)\[/links\]');

  @override
  bool onMatch(m.InlineParser parser, Match match) {
    String? content = "";
    m.Element el = m.Element.withTag(linksTag);
    RegExp regExp = RegExp(r'\[links\](.*?)\[/links\]');
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
