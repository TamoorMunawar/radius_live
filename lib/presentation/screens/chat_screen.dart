import 'package:flutter/material.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/presentation/screens/message_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
        actions: [
          IconButton(
            onPressed: () {
              //  Navigator.pop(context);
            },
            icon: Image.asset("assets/icons/message_icon.png",
                width: SizeConfig.width(context, 0.05)),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              //  Navigator.pop(context);
            },
            icon: Padding(
              padding: EdgeInsets.only(right: SizeConfig.width(context, 0.05)),
              child: Image.asset("assets/icons/notification.png",
                  width: SizeConfig.width(context, 0.05)),
            ),
            color: Colors.white,
          ),
        ],
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
          "Chat",
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
      floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(SizeConfig.width(context, 0.1))),
          backgroundColor: GlobalColors.submitButtonColor,
          child: Image.asset("assets/icons/message.png",
              width: SizeConfig.width(context, 0.07)),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MessageScreen()));
          }),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(20, (index) {
            return Container(
              height: SizeConfig.height(context, 0.135),
              width: SizeConfig.width(context, 0.9),
              margin: EdgeInsets.only(
                  top: SizeConfig.height(context, 0.02),
                  left: SizeConfig.width(context, 0.05),
                  right: SizeConfig.width(context, 0.05)),
              decoration: BoxDecoration(
                  border: Border.all(color: GlobalColors.textFieldHintColor),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(right: SizeConfig.width(context, 0.01)),
                    child: Text(
                      "04:09 PM",
                      style: TextStyle(
                          fontSize: SizeConfig.width(context, 0.023),
                          color: GlobalColors.textFieldHintColor),
                    ),
                  ),
                  ListTile(
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
                      "Hey there! How's your day going?",
                      style: TextStyle(
                        color: GlobalColors.textFieldHintColor,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.width(context, 0.035),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
