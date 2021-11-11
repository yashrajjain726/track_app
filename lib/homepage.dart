import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:track_app/main.dart';
import 'package:track_app/notification.dart';
import 'package:workmanager/workmanager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textcontroller = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.reference();
  final Future<FirebaseApp> _future = Firebase.initializeApp();

  void addData(String latitude, String longitude) {
    databaseRef.push().set({'latitude': latitude, 'longitude': longitude});
  }

  Position? location;

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position userCurrentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      addData(userCurrentLocation.latitude.toString(),
          userCurrentLocation.longitude.toString());
      location = userCurrentLocation;
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<NotificationCall>(context, listen: false).initialize();
    Workmanager().initialize(callbackDispatcher);
    Workmanager().registerPeriodicTask(
      "1",
      fetchBackground,
      frequency: const Duration(
        minutes: 15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            "Track Me",
          ),
          titleTextStyle: const TextStyle(
            fontSize: 22,
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
        body: Container(
          child: Center(
              child: Consumer<NotificationCall>(
            builder: (context, model, _) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (location != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Latitude is: ${location!.latitude} "),
                          Text("Longitude is: ${location!.longitude} ")
                        ],
                      )
                    : const SizedBox(),
                ElevatedButton(
                  onPressed: () async {
                    await _getUserLocation();
                  },
                  child: const Text(
                    "Fetch Location",
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/first');
                  },
                  child: const Text(
                    "Change Screens",
                  ),
                ),
                ElevatedButton(
                  onPressed: () => model.notificationOne(),
                  child: const Text(
                    "Notification One",
                  ),
                ),
                ElevatedButton(
                  onPressed: () => model.notificationTwo(),
                  child: const Text(
                    "Notification Two",
                  ),
                ),
                ElevatedButton(
                  onPressed: () => model.notificationThree(),
                  child: const Text(
                    "Notification Three",
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}
