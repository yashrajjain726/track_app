import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:track_app/homepage.dart';
import 'package:track_app/screens/screen-one.dart';
import 'package:track_app/screens/screen-two.dart';
import 'package:workmanager/workmanager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:track_app/notification.dart' as notify;

const fetchBackground = "fetchBackground";

void callbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackground:
        Position userLocation = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        notify.Notification notification = new notify.Notification();
        notification.showNotification(userLocation);
        break;
    }
    return Future.value(true);
  });
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Track User Location',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/first': (context) => ScreenOne(),
        '/second': (context) => ScreenTwo(),
      },
    );
  }
}
