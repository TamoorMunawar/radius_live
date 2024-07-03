import 'package:flutter/material.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/presentation/screens/message_screen.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          //GlobalColors.backgroundColor,
          centerTitle: true,

          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Padding(
              padding: EdgeInsets.only(left: SizeConfig.width(context, 0.05),right:  SizeConfig.width(context, 0.05)),
              child: Icon(
                Icons.arrow_back_ios,
                size: SizeConfig.width(context, 0.05),
              ),
            ),
            color: Colors.white,
          ),
          title: Text(
            "Request",
            style: TextStyle(
              color: GlobalColors.whiteColor,
              fontSize: SizeConfig.width(
                context,
                0.05,
              ),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.width(context, 0.05),
                  right: SizeConfig.width(context, 0.05)),
              child: Material(
                color: Colors.transparent,
                shadowColor: const Color(0xff006DFC).withOpacity(0.16),
                child: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    /*    prefix: Padding(
                    padding: EdgeInsets.only(
                      top: SizeConfig.height(
                        context,
                        0.005,
                      ),
                    ),
                    child: Image.asset(
                      "assets/icons/search_icon.png",
                      width: SizeConfig.width(context, 0.07),
                    ),
                  ),*/
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.width(context, 0.04),
                          right: SizeConfig.width(context, 0.02)),
                      child: Image.asset(
                        "assets/icons/search_icon.png",
                        width: SizeConfig.width(context, 0.01),
                      ),
                    ),
                    filled: false,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalColors.hintTextColor,
                        //    width: SizeConfig.width(context, 0.005),
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.02),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalColors.hintTextColor,
                        // width: SizeConfig.width(context, 0.005),
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.02),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalColors.hintTextColor,
                        // width: SizeConfig.width(context, 0.005),
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.02),
                      ),
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: GlobalColors.textFieldHintColor,
                    ),
                  ),
                  style: TextStyle(
                    color: GlobalColors.textFieldHintColor,
                    fontSize: SizeConfig.width(context, 0.04),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    // height: 0.09,
                  ),
                  /*                  autovalidateMode: AutovalidateMode.onUserInteraction,
                textCapitalization:
                widget.textCapitalization ?? TextCapitalization.words,*/
                  onChanged: (text) {},
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: List.generate(20, (index) {
                  return Container(
                    //  height: SizeConfig.height(context, 0.135),
                    width: SizeConfig.width(context, 0.9),
                    margin: EdgeInsets.only(
                      top: SizeConfig.height(context, 0.02),
                      left: SizeConfig.width(context, 0.05),
                      right: SizeConfig.width(context, 0.05),
                    ),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: GlobalColors.textFieldHintColor),
                        color: GlobalColors.backgroundColor,
                        borderRadius: BorderRadius.circular(
                          SizeConfig.width(context, 0.02),
                        )),
                    padding: EdgeInsets.only(
                      top: SizeConfig.height(context, 0.01),
                      //   bottom: SizeConfig.height(context, 0.01),
                      left: SizeConfig.width(context, 0.02),
                      right: SizeConfig.width(context, 0.02),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/icons/profile_icon.png"),
                        radius: SizeConfig.width(context, 0.055),
                      ),
                      title: Text(
                        "Ronald Richards",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.width(context, 0.035),
                        ),
                      ),
                      subtitle: Text(
                        "Usher",
                        style: TextStyle(
                          color: GlobalColors.textFieldHintColor,
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.width(context, 0.035),
                        ),
                      ),
                      trailing: Container(
                        //   color: Colors.red,
                        width: SizeConfig.width(context, 0.25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              //   padding: EdgeInsets.symmetric(vertical: SizeConfig.height(context, 0.005)),
                              //   height: SizeConfig.height(context, 0.02),
                              width: SizeConfig.width(context, 0.23),
                              decoration: BoxDecoration(
                                color: Color(0xFFDAA35A).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                  SizeConfig.width(context, 0.01),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                "Accept",
                                style: TextStyle(
                                    color: GlobalColors.submitButtonColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: SizeConfig.width(context, 0.03)),
                              )),
                            ),
                            Container(
                              //   height: SizeConfig.height(context, 0.02),
                              width: SizeConfig.width(context, 0.23),
                              decoration: BoxDecoration(
                                color: Color(0xFFDAA35A).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                  SizeConfig.width(context, 0.01),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                "Reject",
                                style: TextStyle(
                                    color: GlobalColors.submitButtonColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: SizeConfig.width(context, 0.03)),
                              )),
                            ),
                            /* IconButton(
                           icon: Icon(Icons.add_circle_outline_sharp,color: Color(0xFFEF4A4A),
                               size: SizeConfig.width(context, 0.08)),
                           onPressed: () {},
                         ),
                         IconButton(
                           icon: Icon(Icons.delete_sharp,
                               size: SizeConfig.width(context, 0.08),color: Color(0xFFEF4A4A),),
                           onPressed: () {},
                         ),*/
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            )),
          ],
        ),
      );
  }
}
