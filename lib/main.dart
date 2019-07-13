import 'package:flutter_web/material.dart';
import 'package:http/http.dart' as http;
import "package:async/async.dart";
import 'dart:convert';
import 'otherpage.dart';
import "model.dart";

//flutter pub global run webdev serve

Future<List<Post>> fetchPost() async {

//  final response = await http.get('http://localhost:9090/yesapp/servlet');
  final response = await http.get('https://20190710t212709-dot-heyy-241909.appspot.com/servlet');

  Iterable l = json.decode(response.body);
  List<Post> posts = l.map((model) => Post.fromJson(model)).toList();
  return posts;
//  if (response.statusCode == 200) {
//    // If the call to the server was successful, parse the JSON
//    return Post.fromJson(json.decode(response.body));
//  } else {
//    // If that call was not successful, throw an error.
//    throw Exception('Failed to load post');
//  }
}

void main() => runApp(Test());
 class MyApp extends StatefulWidget{
   MyApp({Key key, this.posts,this.navigatorKey}) : super(key: key);
   Future<List<Post>> posts;
var navigatorKey = GlobalKey<NavigatorState>();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }

 }
class MyAppState extends State<MyApp> {


  void after() {
    setState(() {
      widget.posts = fetchPost();
    });
  }

  var priorColors = [
    null,
    Colors.black,
    Colors.grey,
    Colors.black12,
    Colors.white12
  ];

//


  Post temp = new Post(p: 2, name: "make flutter awesome", id: "AX221");


  @override
  Widget build(BuildContext context) {
    var boxWidth = MediaQuery
        .of(context)
        .size
        .width*0.4;
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Stack(children: [
        Positioned(
            child: Container(
              color: Colors.black,
              height: 5.0,
            )),
        FractionallySizedBox(
          alignment: Alignment.center,


          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Row(mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: 10.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "tarun's",
                                  style: TextStyle(
                                      letterSpacing: 1.7,
                                      fontWeight: FontWeight.w100,
                                      fontSize: 12.0),
                                ),
                                Text(
                                  "PriorList",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 50.0),
                                )
                              ]),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height-542.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80.0),
                          child: Image.asset(
                            "pic.png",
                            height: 400.0,
                          ),
                        )
                      ],
                    ),
                    Column(crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[

                          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                          Padding(
                            padding: const EdgeInsets.only(right: 100.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "about",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ), SizedBox(width: 10.0,),
                                InkWell(
                                  onTap: () {
                                    print("hello");
                                    widget.navigatorKey.currentState
                                        .push(
                                        MaterialPageRoute(builder: (context) {
                                          return OtherPage(null, after);
                                        }));
                                  },
                                  child: Text(
                                    "add task",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 100.0),
                            alignment: FractionalOffset.centerRight,
                            height: 400.0,
                            width: boxWidth,
                            child: FutureBuilder<List<Post>>(
                              future: widget.posts,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, pos) {
                                      return OutlineButton(
                                        onPressed: () {
                                          print("hello");
                                          widget.navigatorKey.currentState
                                              .push(MaterialPageRoute(
                                              builder: (context) {
                                                return new OtherPage(
                                                    snapshot.data[pos], after);
                                              }));
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              snapshot.data[pos].name,
                                              style:
                                              TextStyle(
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Container(
                                              height: 20.0,
                                              width: 20.0,
                                              color: priorColors[snapshot
                                                  .data[pos].p],
                                            )
                                          ],
                                        ),
                                        borderSide: BorderSide(
                                            color: Colors.black),
                                      );
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }


                                return Center(
                                    child: CircularProgressIndicator());
                              },


                            ),
                          ),

                        ])
                  ])
            ],
          ),
        ),
      ]),
    );
  }


}

class Test extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        title: 'PriorList',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: MyApp(posts: fetchPost(),navigatorKey: navigatorKey,)
    );
  }
}