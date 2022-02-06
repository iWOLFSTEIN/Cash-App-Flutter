import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:reward_app/Screens/HomeScreen.dart';
import 'package:reward_app/Services/DatabaseServices.dart';
import 'package:reward_app/Services/SignInServices.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:reward_app/Services/UserState.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  var introKey = GlobalKey<IntroductionScreenState>();
  DatabaseServices databaseServices = new DatabaseServices();

  SignInServies signInServies = SignInServies();
  UserState userState = UserState();

  bool showSpinner = false;

  // DatabaseServices databaseServices = new DatabaseServices();

  List introImages = [
    'images/intro_image1.png',
    'images/intro_image2.png',
    'images/intro_image3.png',
    'images/intro_image4.png',
    'images/intro_image5.png'
  ];

  Widget _buildImage(String assetName, {var width, var height}) {
    return Align(
      child: Image.asset(
        assetName,
        width: width / 1.3,
        height: height / 2,
      ),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var size = (height + width) / 8;

    var pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          color: Color(0xFF1c5162),
          fontSize: size * 20 / 100,
          fontWeight: FontWeight.w600),
      bodyTextStyle: TextStyle(
          color: Color(0xFF708187).withOpacity(0.4),
          fontSize: size * 14 / 100,
          fontWeight: FontWeight.w600),
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.only(top: height * 8 / 100),
          child: IntroductionScreen(
            showSkipButton: true,
            skipFlex: 0,
            nextFlex: 0,
            skip: Text(
              'Skip',
              style: TextStyle(
                  color: Color(0xFFBDBDBD),
                  fontSize: size * 12 / 100,
                  fontWeight: FontWeight.w600),
            ),
            next: Icon(
              Icons.arrow_forward,
              color: Color(0xFFBDBDBD),
            ),
            dotsDecorator: const DotsDecorator(
              size: Size(10.0, 10.0),
              color: Color(0xFFBDBDBD),
              activeSize: Size(22.0, 10.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
            done: Text(
              'Done',
              style: TextStyle(
                  color: Color(0xFFBDBDBD).withOpacity(0.0),
                  fontSize: size * 12 / 100,
                  fontWeight: FontWeight.w600),
            ),
            onDone: () {},
            key: introKey,
            pages: [
              PageViewModel(
                title: "Welcome",
                body:
                    "Welcome to Rewarder where you can earn free rewards, gift cards and cash prizes!",
                image:
                    _buildImage(introImages[0], height: height, width: width),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "Simple Task",
                body:
                    "Complete simple tasks like watching ads or seeing promotions to earn points!",
                image:
                    _buildImage(introImages[1], height: height, width: width),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "Free Rewards",
                body: "You can get free rewards on daily and weekly basis!",
                image:
                    _buildImage(introImages[2], height: height, width: width),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "Treasure Crates",
                body:
                    "Open crates with corresponding items to get amazing prizes and boost up your winnig streak!",
                image:
                    _buildImage(introImages[3], height: height, width: width),
                decoration: pageDecoration,
              ),
              PageViewModel(
                  title: "Instant Cash",
                  body: "Redeem your rewards to get instant cash prizes!",
                  image:
                      _buildImage(introImages[4], height: height, width: width),
                  decoration: pageDecoration,
                  footer: Padding(
                    padding: EdgeInsets.only(
                      //  top: height * 10 / 100,
                      left: width * 2 / 100,
                      right: width * 2 / 100,
                    ),
                    child: RaisedButton(
                      padding: EdgeInsets.only(
                        top: height * 2 / 100,
                        bottom: height * 2 / 100,
                        left: width * 5 / 100,
                        right: width * 5 / 100,
                      ),
                      color: Color(0xFF29bae9),
                      onPressed: () {
                        try {
                          setState(() {
                            showSpinner = true;
                          });
                          signInServies.signInWithGoogle().whenComplete(() {
                            databaseServices.userHistoryData(
                                historyMessage: 'User logged In',
                                timestamp: DateTime.now());
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (route) => false);
                            userState.setVisitingFlag(value: true);

                            setState(() {
                              showSpinner = false;
                            });
                          });
                        } catch (e) {
                          setState(() {
                            showSpinner = false;
                          });
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            title: "Oops...",
                            text: "Sorry, something went wrong",
                          );
                        }
                      },
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 4.5 / 100,
                            ),
                            Image.asset(
                              'images/google.png',
                              width: width * 8 / 100,
                            ),
                            SizedBox(
                              width: width * 4 / 100,
                            ),
                            Text(
                              'Continue with Google',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size * 14 / 100,
                                  fontWeight: FontWeight.w700),
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
