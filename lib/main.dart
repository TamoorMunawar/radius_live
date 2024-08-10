import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/firebase_options.dart';
import 'package:radar/observer.dart';
import 'package:radar/presentation/cubits/logistics/logistics_state.dart';
import 'package:radar/presentation/cubits/theme/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/generate_route.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'domain/repository/logistics_repo.dart';

LocationData? _locationData;
Location location = Location();
double lat = 0.0;
double lng = 0.0;

late io.Socket socket;

_connectSocket() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getInt("user_id") == null || prefs.getInt("user_id") == 0) {
    print("inside user id null condition _connectSocket");
    return;
  }
  socket = io.io('https://dashboard.radiusapp.online:6002/?user_id=${prefs.getInt("user_id")}',
      io.OptionBuilder().setTransports(['websocket']).setQuery({'username': "Your  is here"}).build());
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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
    super.initState();
    _connectSocket();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BuyAssetCubit(BuyAssetRepository()),
        ),
        BlocProvider(create: (_) => ThemeCubit())
      ],
      child: MaterialApp(
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'Radius',
        navigatorKey: navKey,

        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: GlobalColors.submitButtonTextColor),
            scaffoldBackgroundColor: GlobalColors.backgroundColor,
            fontFamily: 'Poppins',
            bottomAppBarTheme: const BottomAppBarTheme(color: GlobalColors.backgroundColor),
            appBarTheme: const AppBarTheme(backgroundColor: GlobalColors.backgroundColor)),

        home: splashScreen(isProfile: widget.isProfile),
        //  home:  JobDashBoardScreen(),
        onGenerateRoute: onGenerateRoute,
      ),
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
