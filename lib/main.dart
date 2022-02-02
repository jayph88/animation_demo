import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double _size = 0;
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds:2));

    _animation = Tween<double>(begin: -1, end: 1).chain(CurveTween(curve: Curves.bounceOut)).animate(_animationController);
    _animation.addListener(() {
      setState(() {

      });
    });

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _xrange = MediaQuery.of(context).size.width - 50;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        // crossAxisAlignment: Alignment.,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.black12,
              width: double.infinity,
              alignment: Alignment(_animation.value, -1),
              child: Container(
                color: Colors.pink,
                height: 50,
                width: 50,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _animationController.forward();
                  },
                  child: Text('start')),
              ElevatedButton(
                  onPressed: () {
                    _animationController.stop();
                  },
                  child: Text('stop')),
              ElevatedButton(
                  onPressed: () {
                    _animationController.reverse();
                  },
                  child: Text('reverse')),
              ElevatedButton(
                  onPressed: () {
                    _animationController.reset();
                  },
                  child: Text('reset')),
            ],
          )
        ],
      ),
        // body : Stack(
        //   children: [
        //     Container(
        //       height: 100,
        //       width: 100,
        //       color: Colors.red,
        //     )
        //   ],
        // )
    );


  }
}
