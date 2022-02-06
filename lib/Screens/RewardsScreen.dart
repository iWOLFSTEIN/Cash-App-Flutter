import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reward_app/Screens/TasksScreen.dart';
import 'package:reward_app/Services/DatabaseServices.dart';
import 'package:reward_app/Services/FirebaseDataUpdationServices.dart';
import 'package:reward_app/Services/FirebaseGetData.dart';

class RewardsScreen extends StatefulWidget {
  RewardsScreen({
    Key key,
    @required this.height,
    @required this.width,
    @required this.size,
    this.topPadding,
  }) : super(key: key);

  final double height;
  final double width;
  final double size;
  final double topPadding;

  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  var currentTime = DateTime.now();

  List rewardContainerNames = [
    'Daily Reward',
    'Weekly Reward',
    'Coins',
    'Watches',
    'Keys',
    'Diamonds',
  ];

  List rewardContainerComments = [
    'Collect your free prize',
    'Collect your grand prize',
  ];

  List rewardContainerIcons = [
    'images/gift-box.png',
    'images/gift.png',
    'images/dollar.png',
    'images/pocket-watch.png',
    'images/key.png',
    'images/diamond.png'
  ];

  var _auth = FirebaseAuth.instance;

  User user;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
  }

  var firestore = FirebaseFirestore.instance;

  FirebaseGetUserData db = FirebaseGetUserData();

  var firebaseDataUpdationServices = new FirbaseDataUpdationServices();
  DatabaseServices databaseServices = new DatabaseServices();
  @override
  Widget build(BuildContext context) {
    // var user = Provider.of<User>(context);
    return Scaffold(
      body: StreamBuilder<UserData>(
          stream: db.streamUserData(email: user.email),
          builder: (context, snapshot) {
            if (!(snapshot.hasData)) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              color: Color(0xFFEEF4F6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    color: Color(0xFF29bae9),
                    elevation: 8,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: (widget.topPadding == null)
                              ? widget.height * 0 / 100
                              : widget.topPadding),
                      child: Column(
                        children: [
                          BuildAlignText(
                              height: widget.height,
                              width: widget.width,
                              size: widget.size,
                              text: 'Free Rewards',
                              color: Colors.white),
                          Padding(
                            padding: EdgeInsets.only(
                                top: widget.height * 2 / 100,
                                bottom: widget.height * 6 / 100),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClickableIconContainer(
                                    voidCallBack: () {
                                      try {
                                        if (currentTime.isAfter(snapshot
                                            .data.timestampDaily
                                            .toDate())) {
                                          var updatedTime = currentTime
                                              .add(Duration(seconds: 86400));

                                          firebaseDataUpdationServices
                                              .updateCoins(
                                            currentCoins: snapshot.data.coins,
                                            coinsTobeAdded: 10,
                                            totalCoins:
                                                snapshot.data.totalCoins,
                                          );

                                          firebaseDataUpdationServices
                                              .updateTimeStampDaily(
                                                  time: updatedTime);

                                          databaseServices.userHistoryData(
                                              historyMessage:
                                                  'Daily Reward collected',
                                              timestamp: DateTime.now());

                                          CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.success,
                                            title: "Congratulations!",
                                            text: "You got 10 coins",
                                          );
                                        } else {
                                          CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.warning,
                                            title: "Coins Already Collected!",
                                            text: "Come back later",
                                          );
                                        }
                                      } catch (e) {
                                        CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.error,
                                          title: "Sorry!",
                                          text: "An error occured.",
                                        );
                                      }
                                    },
                                    height: widget.height,
                                    width: widget.width,
                                    taskContainerIcons: rewardContainerIcons[0],
                                    taskContainerNames: rewardContainerNames[0],
                                    taskContainerComments:
                                        rewardContainerComments[0],
                                    size: widget.size),
                                SizedBox(
                                  width: widget.width * 5 / 100,
                                ),
                                ClickableIconContainer(
                                    voidCallBack: () {
                                      try {
                                        if (currentTime.isAfter(snapshot
                                            .data.timestampWeekly
                                            .toDate())) {
                                          var updatedTime = currentTime.add(
                                              Duration(seconds: 86400 * 7));

                                          firebaseDataUpdationServices
                                              .updateCoins(
                                            currentCoins: snapshot.data.coins,
                                            coinsTobeAdded: 100,
                                            totalCoins:
                                                snapshot.data.totalCoins,
                                          );

                                          firebaseDataUpdationServices
                                              .updateTimeStampWeekly(
                                                  time: updatedTime);

                                          databaseServices.userHistoryData(
                                              historyMessage:
                                                  'Weekly reward collected',
                                              timestamp: DateTime.now());

                                          CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.success,
                                            title: "Congratulations!",
                                            text: "You got 100 coins",
                                          );
                                        } else {
                                          CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.warning,
                                            title: "Coins Already Collected!",
                                            text: "Come back later",
                                          );
                                        }
                                      } catch (e) {
                                        CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.error,
                                          title: "Sorry!",
                                          text: "An error occured.",
                                        );
                                      }
                                    },
                                    height: widget.height,
                                    width: widget.width,
                                    taskContainerIcons: rewardContainerIcons[1],
                                    taskContainerNames: rewardContainerNames[1],
                                    taskContainerComments:
                                        rewardContainerComments[1],
                                    size: widget.size),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BuildAlignText(
                      height: widget.height,
                      width: widget.width,
                      size: widget.size,
                      text: 'Collections',
                      color: Color(0xFF708187)),
                  Padding(
                    padding: EdgeInsets.only(
                        top: widget.height * 2 / 100,
                        bottom: widget.height * 1 / 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClickableIconContainer(
                            height: widget.height / 1.3,
                            width: widget.width / 1.3,
                            taskContainerIcons: rewardContainerIcons[2],
                            taskContainerNames: rewardContainerNames[2],
                            taskContainerComments:
                                'currently: ' + snapshot.data.coins.toString(),
                            // rewardContainerComments[2],
                            size: widget.size / 1.3),
                        SizedBox(
                          width: widget.width * 8 / 100,
                        ),
                        ClickableIconContainer(
                            height: widget.height / 1.3,
                            width: widget.width / 1.3,
                            taskContainerIcons: rewardContainerIcons[3],
                            taskContainerNames: rewardContainerNames[3],
                            taskContainerComments: 'currently: ' +
                                snapshot.data.watches.toString(),
                            // rewardContainerComments[3],
                            size: widget.size / 1.3),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: widget.height * 1 / 100,
                        bottom: widget.height * 2 / 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClickableIconContainer(
                            height: widget.height / 1.3,
                            width: widget.width / 1.3,
                            taskContainerIcons: rewardContainerIcons[4],
                            taskContainerNames: rewardContainerNames[4],
                            taskContainerComments:
                                'currently: ' + snapshot.data.keys.toString(),
                            // rewardContainerComments[4],
                            size: widget.size / 1.3),
                        SizedBox(
                          width: widget.width * 8 / 100,
                        ),
                        ClickableIconContainer(
                            height: widget.height / 1.3,
                            width: widget.width / 1.3,
                            taskContainerIcons: rewardContainerIcons[5],
                            taskContainerNames: rewardContainerNames[5],
                            taskContainerComments:
                                'currently: ' + snapshot.data.gems.toString(),
                            // rewardContainerComments[5],
                            size: widget.size / 1.3),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class BuildAlignText extends StatelessWidget {
  const BuildAlignText({
    Key key,
    @required this.height,
    @required this.width,
    @required this.size,
    @required this.text,
    @required this.color,
  }) : super(key: key);

  final double height;
  final double width;
  final double size;
  final text;
  final color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(top: height * 3 / 100, left: width * 6 / 100),
        child: Text(
          //  'Collections',
          text,
          style: TextStyle(
              color:
                  // Colors.white,
                  // Color(0xFF708187),
                  color,
              fontSize: size * 13 / 100,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
