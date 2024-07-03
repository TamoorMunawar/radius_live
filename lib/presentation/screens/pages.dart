import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/generate_route.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/presentation/screens/Authentication/Login.dart';
import 'package:radar/presentation/screens/Authentication/forgot_password.dart';
import 'package:radar/presentation/screens/Authentication/profile_screen.dart';
import 'package:radar/presentation/screens/attandance.dart';
import 'package:radar/presentation/screens/chat_screen.dart';
import 'package:radar/presentation/screens/dashboard_screen.dart';
import 'package:radar/presentation/screens/events.dart';
import 'package:radar/presentation/screens/job_screen.dart';
import 'package:radar/presentation/screens/notification.dart';
import 'package:radar/presentation/screens/qr_attandance.dart';
import 'package:radar/presentation/screens/request_screen.dart';
import 'package:radar/presentation/screens/usher_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteArgument {
  String? isUsher;
  String? heroTag;
  dynamic param;

  RouteArgument({this.isUsher, this.heroTag, this.param});

  @override
  String toString() {
    return '{id: $isUsher, heroTag:${heroTag.toString()}}';
  }
}

class PagesWidget extends StatefulWidget {
  dynamic currentTab;
  //RouteArgument? routeArgument;
    Widget? currentPage ;

  PagesWidget({super.key, this.currentTab, required this.currentPage}) {

  }

  @override
  _PagesWidgetState createState() => _PagesWidgetState();
}

class _PagesWidgetState extends State<PagesWidget> {

  String? roleName;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  Future getUserDetailsFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    roleName =prefs.getString(
      "role_name",
    ) ??
        "";
    widget.currentPage=roleName!="Usher"?adminDashBoard():dashBoard();

    print("role name pages $roleName");
    setState(() {
});
  }

  @override
  initState() {
    super.initState();
    getUserDetailsFromLocal();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(PagesWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int? tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {

        case 0:
          print("inside case 0 $roleName ${roleName != "Usher"}");
          widget.currentPage = //latlng();
          //dashBoard();
           (roleName != "Usher")?adminDashBoard():  dashBoard();
          break;
        case 1:
          print("inside case 1");
          widget.currentPage = //MapChecking();
          (roleName != "Usher"&&roleName != "Client") ? usherListScreen() : announcement(
              hideBackButton: true);
          break;
        case 2:
          print("inside case 2");
      //    widget.currentPage = usherListScreenByEvent();
         widget.currentPage = eventScreen();
          break;
        case 3:
          print("inside case 3");
          widget.currentPage =
          (roleName == "Usher"||roleName =="Client") ? attandanceDetails(false) : qrAttandance();
          break;
        case 4:
          print("inside case 4");
        // widget.currentPage = RequestScreen(); //FavoritesWidget(parentScaffoldKey: widget.scaffoldKey);
          widget.currentPage =
          //UsherListScreen();
          profileScreen(
              isBack: false); //FavoritesWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        /*case 5:
          print("inside case 5");
          widget.currentPage = //latlng();
          adminDashBoard();

          break;*/
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.backgroundColor,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: widget.currentTab,
        height: 70.0,
        items: [
          widget.currentTab == 0
              ? Image.asset(
            "assets/icons/home_icon.png",
            width: SizeConfig.width(context, 0.07),
          )
              : Image.asset(
            "assets/icons/home_icon.png",
            width: SizeConfig.width(context, 0.06),
          ),
          widget.currentTab == 1
              ? Image.asset(
            "assets/icons/attandance_icon.png",
            width: SizeConfig.width(context, 0.07),
          )
              : Image.asset(
            "assets/icons/attandance_icon.png",
            width: SizeConfig.width(context, 0.06),
          ),
          widget.currentTab == 2
              ? Image.asset(
            "assets/icons/cal.png",
            width: SizeConfig.width(context, 0.07),
          )
              : Image.asset(
            "assets/icons/cal.png",
            width: SizeConfig.width(context, 0.06),
          ),
          widget.currentTab == 3
              ? Image.asset(
            "assets/icons/job_icon.png",
            width: SizeConfig.width(context, 0.07),
          )
              : Image.asset(
            "assets/icons/job_icon.png",
            width: SizeConfig.width(context, 0.06),
          ),
          widget.currentTab == 4
              ? Image.asset(
            "assets/icons/profile.png",
            width: SizeConfig.width(context, 0.07),
          )
              : Image.asset(
            "assets/icons/profile.png",
            width: SizeConfig.width(context, 0.06),
          )
        ],
        color: GlobalColors.backgroundColor,

        buttonBackgroundColor: Color(0xFFC1954A),
        backgroundColor: GlobalColors.backgroundColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          _selectTab(index);
        },
        //  letIndexChange: (index) => true,
      ),
      body: widget.currentPage,
    );
  }
}
