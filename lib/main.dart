import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager.initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  Workmanager.registerPeriodicTask("1", "regularTask",
      frequency: Duration(seconds: 10));
  runApp(MyApp());
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {
    // FlutterLocalNotificationsPlugin localNotification;
    // var androidInitialize = AndroidInitializationSettings('launch_background');
    // var iOSInitialize = IOSInitializationSettings();
    // var initializationSettings =
    //     InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    // localNotification = FlutterLocalNotificationsPlugin();
    // localNotification.initialize(initializationSettings);
    // var andriodDetails = AndroidNotificationDetails("channelId",
    //     "Local Notification", "eto prosto descpittion kak govorit Marekak",
    //     importance: Importance.high);
    // var iOSDetails = IOSNotificationDetails();
    // var generalNotificationDetails =
    //     NotificationDetails(android: andriodDetails, iOS: iOSDetails);
    // await localNotification.show(0, "Привет дружок, Марк",
    //     "Ну что ты мне расскажешь", generalNotificationDetails);

    //simpleTask will be emitted here.
    print("Хелло ворлд!");

    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FlutterLocalNotificationsPlugin localNotification;
  @override
  void initState() {
    super.initState();
    var androidInitialize = AndroidInitializationSettings('launch_background');
    var iOSInitialize = IOSInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    localNotification = FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings);
  }

  Future _showNotification() async {
    var andriodDetails = AndroidNotificationDetails("channelId",
        "Local Notification", "eto prosto descpittion kak govorit Marekak",
        importance: Importance.high);
    var iOSDetails = IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: andriodDetails, iOS: iOSDetails);
    await localNotification.show(0, "Привет дружок, Марк",
        "Ну что ты мне расскажешь", generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Click the button to notification!"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.notifications),
        onPressed: () {
          _showNotification();
        },
      ),
    );
  }
}
