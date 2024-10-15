import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  backgroundColor: Colors.black,
                  title: Text("星愿魔法屋",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight:FontWeight.w900,shadows: [Shadow(
                      offset: const Offset(0,0),
                      blurRadius: 5.0,
                      color: Colors.black.withValues()
                  )])),
                  centerTitle: false,
                  pinned: true,
                  floating: true,
                  snap: true,
                  primary: true,
                  expandedHeight: 800,
                  elevation: 0,
                  //是否显示阴影，直接取值innerBoxIsScrolled，展开不显示阴影，合并后会显示
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      decoration: BoxDecoration(
                      ),
                      width: 100,
                      height: 800,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text("宽度有多宽"),
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: NetworkImage("https://imgsa.baidu.com/forum/pic/item/e27bfc1c8701a18b7d5a46059c2f07082938fe73.jpg"),fit: BoxFit.cover)
                                ),
                              ),
                              Text("12322222222222222",style: TextStyle(color: Colors.red),),
                              Text("99999999999",style: TextStyle(color: Colors.red),)
                             //bannerImage('https://pic.bizhi66.com/pic/1375a7df8cc9c9a23b56e4d05178d85c',"炫酷AI机甲"),
                            //  bannerImage('https://pic.bizhi66.com/pic/7881d638b75eef36113497b49bc1e48b',"美少女机甲"),
                            ],
                          ),

                          Container(
                            width: 1000,
                            height: 60,
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              //borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xff8E7AB5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xff8E7AB5).withOpacity(0.8),
                                      blurRadius: 10
                                  )
                                ]
                            ),
                            child: TextButton(onPressed: (){},child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("🪄 释放魔法",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w900),),
                              ],
                            ),
                              style: ButtonStyle(
                                  animationDuration: Duration(microseconds: 0),
                                  alignment: Alignment.centerLeft
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ];
          }, body: SafeArea(
          minimum: EdgeInsets.fromLTRB(0, 0, 0, 0),
          bottom: false,
          child: Container(
              padding: EdgeInsets.fromLTRB(3, 8, 3, 0),
              child: ListView(
                children: [],
              )
          )
      )
      ),
    );
  }
}
