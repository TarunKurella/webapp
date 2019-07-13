import 'package:flutter_web/material.dart';


class navRight extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget>[
        Padding(
          padding:
          const EdgeInsets.only(left: 600.0, top: 60.0),
          child: Text(
            "about",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 80.0, top: 60.0),
          child: InkWell(
            onTap: () {
              print("hello");
              navigatorKey.currentState
                  .push(MaterialPageRoute(builder: (context) {
                return OtherPage(null,after);
              }));
            },
            child: Text(
              "add task",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
          ),
        ),
      ],
    );
  }

}


class navLeft extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
  }

}