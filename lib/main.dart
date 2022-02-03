import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MainWidget());

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check In Progress'),
      ),
      body: Center(
        child: Column(
          children: [
            GoalTrackerWidget(
                width: MediaQuery.of(context).size.width - 20.0, numGoals: 10),
          ],
        ),
      ),
    );
  }
}

class GoalTrackerWidget extends StatefulWidget {
  final double width;
  final int numGoals;

  GoalTrackerWidget({Key? key, required this.width, required this.numGoals})
      : super(key: key);

  @override
  GoalTrackerWidgetState createState() => GoalTrackerWidgetState();
}

class GoalTrackerWidgetState extends State<GoalTrackerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _rotateAnimation;
  var _currentGoal = 0;
  late int _numGoals;
  var _buttonText = 'Next Step!';
  late VoidCallback  _progress;
  var test = 10;
  final double _degrees = pi / 180.0;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    _animation = Tween<double>(begin: 0, end: widget.width - 10.0)
        .animate(CurvedAnimation(parent: _animationController, curve: Interval(0,.75)));
    // _animation.addListener(() {
    //   setState(() {});
    // });

    _rotateAnimation = Tween<double>(begin: 0, end: 1440).animate(
      CurvedAnimation(parent: _animationController, curve: Interval(.75,1))
    );
    _rotateAnimation.addListener(() { setState(() {

    });});

    _numGoals = widget.numGoals;
    _progress = _nextStep;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _nextStep() {
    _currentGoal += _numGoals;
    _animationController.animateTo(_currentGoal/_numGoals);
    if (_currentGoal >= _numGoals) {
      setState(() {
        _buttonText = 'All done!';
        // _progress = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 40.0,
                  width: widget.width,
                ),
                Positioned(
                  top: 10.0,
                  child: Container(
                    height: 10.0,
                    width: widget.width,
                    color: Colors.black,
                  ),
                ),
                Positioned(
                  left: _animation.value,
                  top: 0.0,
                  child: Transform.rotate(
                    angle: _rotateAnimation.value * _degrees,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: Colors.green[600],
                      ),
                      height: 30.0,
                      width: 10.0,
                    ),
                  ),
                ),
              ],
            ),
            Text(_currentGoal < _numGoals
                ? '$_currentGoal / $_numGoals'
                : 'Completed!'),
            ElevatedButton(
              child: Text(_buttonText),
              onPressed: _progress,
            ),
          ],
        ),
      ),
    );
  }
}
