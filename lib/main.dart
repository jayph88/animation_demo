import 'package:flutter/material.dart';

void main() => runApp(MainWidget());

var activities = [
  Activity(
      title: 'Baseball',
      description: 'Something about baseball.',
      iconData: Icons.sports_baseball),
  Activity(
      title: 'Basketball',
      description: 'Something about basketball.',
      iconData: Icons.sports_basketball),
  Activity(
      title: 'Cycling',
      description: 'Something about cycling.',
      iconData: Icons.pedal_bike),
  Activity(
      title: 'Golf',
      description: 'Something about golf.',
      iconData: Icons.sports_golf),
  Activity(
      title: 'Handball',
      description: 'Something about handball.',
      iconData: Icons.sports_handball),
  Activity(
      title: 'Rowing',
      description: 'Something about rowing.',
      iconData: Icons.rowing),
  Activity(
      title: 'Running',
      description: 'Something about running.',
      iconData: Icons.directions_run),
  Activity(
      title: 'Soccer',
      description: 'Something about soccer.',
      iconData: Icons.sports_soccer),
  Activity(
      title: 'Tennis',
      description: 'Something about tennis.',
      iconData: Icons.sports_tennis),
  Activity(
      title: 'Volleyball',
      description: 'Something about volleyball.',
      iconData: Icons.sports_volleyball),
  Activity(
      title: 'Walking',
      description: 'Something about walking.',
      iconData: Icons.directions_walk),
];

class Activity {
  String title;
  String description;
  IconData iconData;

  Activity({required this.title, required this.description, required this.iconData});
}

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
        title: Text('Carved Rock Fitness'),
        backgroundColor: Colors.deepPurple[900],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final activity = activities[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActivityWidget(),
                    settings: RouteSettings(
                      arguments: activity,
                    ),
                  ),
                );
              },
              leading: Hero(
                child: Icon(
                  activity.iconData,
                  size: 70.0,
                  color: Colors.deepPurpleAccent[700],
                ),
                tag: activity.title,
              ),
              title: Container(
                alignment: Alignment.bottomCenter,
                height: 70.0,
                child: Text(
                  activities[index].title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ActivityWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Activity activity = ModalRoute.of(context)!.settings.arguments as Activity;
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Detail'),
        backgroundColor: Colors.deepPurple[900],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width - 40.0,
              child: Stack(
                children: [
                  Positioned(
                    top: 10.0,
                    right: 25.0,
                    child: Hero(
                      placeholderBuilder: (context, size, child) => Icon(
                        activity!.iconData,
                        size: 150,
                        color: Colors.deepPurple[50],
                      ),
                      flightShuttleBuilder: (context, animation, direction,
                          srcContext, destContext) {
                        return ScaleTransition(
                          scale: TweenSequence([
                            TweenSequenceItem(
                                tween: Tween<double>(begin: 1.0, end: 10.0),
                                weight: 1),
                            TweenSequenceItem(
                                tween: Tween<double>(begin: 10.0, end: 2.14),
                                weight: 1),
                          ]).animate(animation),
                          child: Icon(
                            activity.iconData,
                            size: 70,
                            color: Colors.deepPurple[200],
                          ),
                        );
                      },
                      child: Icon(
                        activity.iconData,
                        size: 150.0,
                        color: Colors.deepPurple[200],
                      ),
                      tag: activity.title,
                    ),
                  ),
                  Positioned(
                    top: 115.0,
                    right: 0.0,
                    child: Text(
                      activity.title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 65.0,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -4.0,
                        color: Colors.deepPurple[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              List.filled(10, activity.description).join(' '),
              style: TextStyle(
                color: Colors.black,
                fontSize: 19.0,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
