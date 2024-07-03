import 'package:flutter/material.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/size_config.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
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
            padding: EdgeInsets.only(left: SizeConfig.width(context, 0.05)),
            child: Icon(
              Icons.arrow_back_ios,
              size: SizeConfig.width(context, 0.05),
            ),
          ),
          color: Colors.white,
        ),
        title: Text(
          "New Chat",
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
        mainAxisAlignment: MainAxisAlignment.center,
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
                  hintText: "Search Friend",
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
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: SizeConfig.height(context, 0.04),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(20, (index) {
                    return Container(
                      alignment: Alignment.center,
                      height: SizeConfig.height(context, 0.1),
                      width: SizeConfig.width(context, 0.9),
                      margin: EdgeInsets.only(
                          top: SizeConfig.height(context, 0.02),
                          left: SizeConfig.width(context, 0.05),
                          right: SizeConfig.width(context, 0.05)),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: GlobalColors.textFieldHintColor),
                          color: GlobalColors.backgroundColor,
                          borderRadius: BorderRadius.circular(
                            SizeConfig.width(context, 0.02),
                          )),
                      padding: EdgeInsets.only(
                        top: SizeConfig.height(context, 0.01),
                        bottom: SizeConfig.height(context, 0.01),
                        //   bottom: SizeConfig.height(context, 0.01),
                        left: SizeConfig.width(context, 0.04),
                        right: SizeConfig.width(context, 0.04),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundImage:
                          AssetImage("assets/icons/profile_icon.png"),
                          radius: SizeConfig.width(context, 0.07),
                        ),
                        title: Text(
                          "Ronald Richards",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.width(context, 0.035),
                          ),
                        ),
                        trailing: Image.asset(
                          "assets/icons/chat_icon.png",
                          width: SizeConfig.width(context, 0.08),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
