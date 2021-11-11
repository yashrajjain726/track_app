import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:track_app/homepage.dart';
import 'package:track_app/notification.dart';
import 'package:track_app/screens/screen_five.dart';
import 'package:track_app/screens/screen_four.dart';
import 'package:track_app/screens/screen_one.dart';
import 'package:track_app/screens/screen_three.dart';
import 'package:track_app/screens/screen_two.dart';
import 'package:workmanager/workmanager.dart';
import 'package:geolocator/geolocator.dart';

const fetchBackground = "fetchBackground";

void callbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackground:
        Position userLocation = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        NotificationCall notification = new NotificationCall();
        notification.scheduledNotification(userLocation);
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
    return MultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Track User Location',
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/first': (context) => ScreenOne(),
          '/second': (context) => ScreenTwo(),
          '/three': (context) => ScreenThree(),
          '/four': (context) => ScreenFour(),
          '/five': (context) => ScreenFive(),
        },
      ),
      providers: [ChangeNotifierProvider(create: (_) => NotificationCall())],
    );
  }
}
