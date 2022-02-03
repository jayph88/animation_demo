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
  var _currentGoal = 0;
  var _numGoals;
  var _buttonText = 'Next Step!';
  late VoidCallback  _progress;
  var test = 10;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _animation = Tween<double>(begin: 0, end: widget.width - 10.0)
        .animate(_animationController);
    _animation.addListener(() {
      setState(() {});
    });

    _numGoals = widget.numGoals;
    _progress = _nextStep;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _nextStep() {
    _currentGoal += 1;
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
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.green[600],
                    ),
                    height: 30.0,
                    width: 10.0,
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
