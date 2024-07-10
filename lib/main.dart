import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:location/location.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/device_utils.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/observer.dart';
import 'package:radar/presentation/screens/job_dashboard_screen.dart';
import 'package:radar/presentation/screens/splash_screen.dart';
import 'package:radar/presentation/screens/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_client/web_socket_client.dart';

import 'constants/generate_route.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

LocationData? _locationData;
Location location = Location();
double lat = 0.0;
double lng = 0.0;

late IO.Socket socket;

_connectSocket() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getInt("user_id") == null || prefs.getInt("user_id") == 0) {
    print("inside user id null condition _connectSocket");
    return;
  }
  socket = IO.io('https://dashboard.radiusapp.online:6002/?user_id=${prefs.getInt("user_id")}',
      IO.OptionBuilder().setTransports(['websocket']).setQuery({'username': "Your  is here"}).build());
  print("_connectSocket user id ${prefs.getInt("user_id")}");

  socket.onConnect((data) {
    print("socket connection  connected");
    getLocationFromLocation();
  });
  socket.onConnectError((data) {
    print("socket connection error");
  });
  socket.onDisconnect((data) {
    print("socket connection disconnected");
  });
}

bool isUserLoggedIn = false;

getLocationFromLocation() async {
  location.enableBackgroundMode(enable: true);
/*  _locationData = await location.getLocation();*/
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("location data ${_locationData?.latitude}");
  print("location data ${_locationData?.longitude}");
  location.onLocationChanged.listen((LocationData currentLocation) {
    print("location data changed ${currentLocation.longitude}");
    print("location data changed ${currentLocation.latitude}");
    lat = currentLocation.latitude ?? 0.0;
    lng = currentLocation.longitude ?? 0.0;
    if (prefs.getInt("user_id") != 0 && prefs.getInt("user_id") != null) {
      print("inside userid condition userId ${prefs.getInt("user_id")}");
      print("socket emit message ${"latitude" "$lat"
          "longitude" "$lng"
          "user_id" "${prefs.getInt("user_id")}"}");
      socket.emit('location-updates', {"latitude": lat, "longitude": lng, "user_id": prefs.getInt("user_id")});
    }
    // setState(() {});
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const RadiusObserver();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyDQWUUe8QbokhujOuQ5ae7InZjahUjl2iI",
            appId: "1:859031581445:android:23e14db953514400917d6c",
            messagingSenderId: "859031581445",
            projectId: "push-notification-mocto",
            storageBucket: "push-notification-mocto.appspot.com",
          ),
        )
      : await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await EasyLocalization.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      EasyLocalization(
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          fallbackLocale: const Locale('en'),
          path: 'assets/translations',
          child: const MyApp(
            isProfile: false,
          )),
    );
  });
//  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyDQWUUe8QbokhujOuQ5ae7InZjahUjl2iI",
            appId: "1:859031581445:android:23e14db953514400917d6c",
            messagingSenderId: "859031581445",
            projectId: "push-notification-mocto",
            storageBucket: "push-notification-mocto.appspot.com",
          ),
        )
      : await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.isProfile});

  final bool isProfile;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    //  internetConnectivity();

    _connectSocket();
  }

  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      navigatorKey: navKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: splashScreen(isProfile: widget.isProfile),
      //  home:  JobDashBoardScreen(),
      onGenerateRoute: onGenerateRoute,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
