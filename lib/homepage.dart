import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supertal/providers/counterprovider.dart';
import 'package:supertal/streams/stream.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? coloranimation;
  Animation? sizeAnimation;
  Stream? stream;
  StreamHelper streamHelper = StreamHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    stream = streamHelper.controller.stream;

    stream!.listen((event) {
      print(event);
    });

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    coloranimation = ColorTween(begin: Colors.blue, end: Colors.red)
        .animate(CurvedAnimation(parent: _controller!, curve: Curves.easeIn));

    // sizeAnimation = Tween(begin: 0.1, end: 1.0).animate(
    //     CurvedAnimation(parent: _controller!, curve: Curves.bounceOut));

    _controller!.addListener(() {
      setState(() {
        left = true;
      });
    });
    _controller!.forward();
  }

  bool left = false;
  bool right = false;
  bool top = true;
  bool bottom = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          Provider.of<Counter>(context, listen: false).icrementcount();
          streamHelper.controller.add(double.parse(
              Provider.of<Counter>(context, listen: false).count.toString()));
          // setState(() {
          //   if (left) {
          //     right = true;
          //   }
          //   if (right) {
          //     bottom = true;
          //     _controller!.forward();
          //   }
          // });
        }),
        appBar: AppBar(
          title: Text('Animation'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Text("Value ${Provider.of<Counter>(context).count.toString()}"),
            Text(
                "Stream Value ${Provider.of<Counter>(context).count.toString()}")
            // AnimatedPositioned(
            //     left: left ? size.width * .5 : 0,
            //     top: right ? size.height * .62 : 0,
            //     child: Container(
            //       width: size.width * .5,
            //       height: size.height * .25,
            //       color: coloranimation!.value,
            //     ),
            //     duration: Duration(milliseconds: 1500))
          ],
        ));
  }
}
