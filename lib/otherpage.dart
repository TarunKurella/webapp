import 'package:flutter_web/material.dart';
import 'package:http/http.dart' as http;
import "package:async/async.dart";
import 'dart:convert';
import 'model.dart';

class OtherPage extends StatefulWidget {
  Post post;
  Function after;

  OtherPage(Post post,Function after) {
    this.post = post;
    this.after=after;
  }

  @override
  State<StatefulWidget> createState() {

    return OtherPageState();
  }
}

class OtherPageState extends State<OtherPage> {
  //double something= MediaQuery.of(context).size.height;
  double topMargin= 168.0;
  var boxColors = [
    null,
    Colors.white10,
    Colors.black12,
    Colors.black12,
    Colors.black12
  ];
  var boxImply = [
    null,
    "and Do this Task First",
    "and Persue this Task",
    "and Delegate this Task",
    "and See If Time Persists"
  ];
  String buttonText = "";
  String name;
  int p;
  String id="";
  TextEditingController controll = new TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      controll.text = widget.post.name;
      boxColors[widget.post.p] = Colors.white;
      buttonText = boxImply[widget.post.p];
      topMargin=138.0;
      id=widget.post.id;
      p=widget.post.p;
    }
  }

  void resetButtons() {
    boxColors[1] = Colors.white10;
    boxColors[2] = Colors.black12;
    boxColors[3] = Colors.black12;
    boxColors[4] = Colors.black12;
  }

  Widget deletebutton(){
    if(widget.post!=null){
      return GestureDetector(
        onTap: ()async {
          Map<String,dynamic> response = {"p":p,"name":controll.text,"id":id,"status":0};
          var responsee = await http.put("https://20190710t212709-dot-heyy-241909.appspot.com/servlet",body: json.encode(response));
          widget.after();
          Navigator.pop(context);
        },
        child: Container(
          height: 30.0,
          color: Colors.tealAccent,
          child: Center(
            child: Text(
              "or DELETE Task",
              style: TextStyle(color: Colors.black,fontSize: 10.0),
            ),
          ),
        ),
      );
    }
    else return Container();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Center(
              child: Container(
                  height: 250.0,
                  width: 800.0,
                  child: TextField(
                      controller: controll,
                      decoration: InputDecoration(hintText: "I want to .. "),
                      style: new TextStyle(
                          fontSize: 60.0, height: 2.0, color: Colors.black))),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        p=2;
                        resetButtons();
                        boxColors[2] = Colors.white;
                        buttonText = boxImply[2];
                      });
                    },
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      color: Colors.grey,
                      child: Center(
                          child: Text(
                        "2",
                        style: TextStyle(color: boxColors[2], fontSize: 40.0),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        resetButtons();
                        p=1;
                        boxColors[1] = Colors.white;
                        buttonText = boxImply[1];
                      });
                    },
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      color: Colors.black,
                      child: Center(
                          child: Text(
                        "1",
                        style: TextStyle(color: boxColors[1], fontSize: 40.0),
                      )),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        p=3;
                        resetButtons();
                        boxColors[3] = Colors.white;
                        buttonText = boxImply[3];
                      });
                    },
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      color: Colors.black12,
                      child: Center(
                          child: Text(
                        "3",
                        style: TextStyle(color: boxColors[3], fontSize: 40.0),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        p=4;
                        resetButtons();
                        boxColors[4] = Colors.white;
                        buttonText = boxImply[4];
                      });
                    },
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      color: Colors.white12,
                      child: Center(
                          child: Text(
                        "4",
                        style: TextStyle(color: boxColors[4], fontSize: 40.0),
                      )),
                    ),
                  )
                ],
              ),
            ),
               SizedBox(height: 108.0,),

               Align(
                alignment: FractionalOffset.bottomCenter,
                child: GestureDetector(
                  onTap: ()async {

                    if(widget.post!=null){
                      Map<String,dynamic> response = {"p":p,"name":controll.text,"id":id,"status":1};
                      var responsee = await http.put("https://20190710t212709-dot-heyy-241909.appspot.com/servlet",body: json.encode(response));

                    }else{
                      Map<String,dynamic> response = {"p":p,"name":controll.text,"id":""};
                      var responsee = await http.post("https://20190710t212709-dot-heyy-241909.appspot.com/servlet",body: json.encode(response));
                    }



                    widget.after();
                    Navigator.pop(context);
                  },
                  child: Container(
                    //margin: EdgeInsets.only(top: topMargin),
                    height: 80.0,
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        buttonText,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ,deletebutton()
          ],
        ),
      ),
    );
  }
}
