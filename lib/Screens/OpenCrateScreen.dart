import 'dart:math';

import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reward_app/Logics/RewardLogic.dart';
import 'package:reward_app/Services/DatabaseServices.dart';
import 'package:reward_app/Services/FirebaseDataUpdationServices.dart';
import 'package:reward_app/Services/FirebaseGetData.dart';

class OpenCrateScreen extends StatefulWidget {
  OpenCrateScreen({Key key}) : super(key: key);

  @override
  _OpenCrateScreenState createState() => _OpenCrateScreenState();
}

class _OpenCrateScreenState extends State<OpenCrateScreen> {
  List images = ['images/treasure.png', 'images/treasure_opened.png'];

  var index = 0;

  Random rnd = new Random();
  List itemsTobeCollected = [
    '1c',
    '1c',
    '1c',
    '1g',
    '1g',
    '1g',
    '1g',
    '5g',
    '5g',
    '5g',
    '1c',
    '1c',
    '5c',
    '5c',
    '5c',
    '5c',
    '5c',
    '1w',
    '1w',
    '1w',
    '1w',
    '5c',
    '5c',
    '1c',
    '1g',
    '1g',
    '1g',
    '5c',
    '5g',
    '5g',
    '5g',
    '5g',
    '5g',
    '1c',
    '1g',
    '1g',
    '1g',
    '5c',
    '1w',
    '1w',
    '1w',
    '1c',
    '1c',
    '1c',
    '1c',
    '1c',
    '10g',
    '10g',
    '10g',
    '10g',
    '1c',
    '1g',
    '1g',
    '1g',
    '10g',
    '1w',
    '1w',
    '1w',
    '1w',
    '5c',
    '1c',
    '5c',
    '1c',
    '5c',
    '1c',
    '1g',
    '1g',
    '1g',
    '1c',
    '5c',
    '5c',
    '1c',
    '5c',
    '5c',
    '5g',
    '5g',
    '5g',
    '5g',
    '5g',
    '5g',
    '5g',
    '5c',
    '1c',
    '5c',
    '10c',
    '10c',
    '10c',
    '10c',
    '10c',
    '10c',
    '1c',
    '1c',
    '1c',
    '1c',
    '1c',
    '1c',
    '1c',
    '1c',
    '1c',
    '10c',
    '10c',
    '10c',
    '10c',
    '20c',
    '20c',
    '20c',
    '1c',
    '1c',
    '1c',
    '1c',
    '1c',
    '5g',
    '5g',
    '5g',
    '5g',
    '5g',
    '5g',
    '20c',
    '20c',
    '20c',
    '20c',
    '50c',
    '50c',
    '50c',
    '100c',
    '5c',
    '5c',
    '5c',
    '5c',
    '1k',
    '1k',
    '1c',
    '1g',
    '1g',
    '1g',
    '1k',
    '1k',
    '5c',
    '1w',
    '1w',
    '1c',
    '1c',
    '1c',
    '5g',
    '5g',
    '5g',
    '5g',
    '5g',
    '1c',
    '1c',
    '1c',
    '1c',
    '1c',
    '1c',
    '1w',
    '5c',
    '5c',
    '5c',
    '5c',
    '5g',
    '5g',
    '5g',
    '5g',
    '5g',
    '5g',
    '5g',
    '5c',
    '5c',
    '5c',
    '5c',
    '5c',
    '1k',
    '1k',
    '5g',
    '5g',
    '5g',
    '5g',
    '5g',
    '1k',
    '1k',
    '1k',
    '1k',
    '1k',
    '1k',
    '3k',
    '3k',
    '3k',
    '3k',
    '3k',
    '3k',
    '1c',
    '1c',
    '1c',
    '1c',
    '1c',
    '1c',
    '1c',
    '1c',
    '1g',
    '1g',
    '1g',
    '3k',
    '3k',
    '3k',
    '3k',
    '10k',
    '5g',
    '5g',
    '5g',
    '5g',
    '5g',
    '10k',
    '10k',
    '10k',
    '10k',
    '10k',
    '15k',
    '15k',
    '15k',
    '1k',
    '1k',
    '1k',
    '5g',
    '5g',
    '5g',
    '5g',
    '5g',
    '1k',
    '1w',
    '1w',
    '1w',
    '20c',
    '20c',
    '20c',
    '1c',
    '1c',
    '1c',
    '20c',
    '1w',
    '3w',
    '5w',
    '5w',
    '10g',
    '1w',
    '1w',
    '3w',
    '10g',
    '10g',
    '5g',
    '5g',
    '5g',
    '1w',
    '1w',
    '1w',
    '1w',
    '1w',
    '1w',
    '20g',
    '30g',
    '5g',
    '5g',
    '5g',
    '5g',
    '5c',
    '5c',
    '5c',
    '5c',
    '5c',
    '30g',
    '5g',
    '1c',
  ];
  var currentUser = FirebaseAuth.instance.currentUser;
  var db = FirebaseGetUserData();
  var firebaseDataUpdationServices = FirbaseDataUpdationServices();
  RewardsLogic rewardsLogic = RewardsLogic();

  imageProvider(String imageAdress, {var width, var height}) {
    return Expanded(
      child: Image.asset(
        imageAdress,
        width: width * 8 / 100,
        height: height * 4 / 100,
      ),
    );
  }

  rewardPopup(context, {var width, var height}) {
    var alertDialog = AlertDialog(
      backgroundColor: Color(0xFFecf9fe),
      // Color(0xFF29bae9),
      title: Text(
        'Congratulations!',
        style: TextStyle(
            color: Color(0xFF29bae9),
            fontWeight: FontWeight.bold,
            fontSize: ((height + width) / 8) * 14 / 100),
      ),
      content: Container(
        height: height * 14 / 100,
        child: Column(
          children: [
            Image.asset(
              'images/key.png',
              width: width * 14 / 100,
              height: height * 7 / 100,
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 2 / 100),
              child: Text(
                'You got 3 keys!',
                style: TextStyle(
                    color: Color(0xFF29bae9),
                    fontSize: ((height + width) / 8) * 12 / 100),
              ),
            )
          ],
        ),
      ),
    );

    showDialog(context: context, builder: (context) => alertDialog);
  }

  itemsCount(double width, double height, double size, {var text}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFecf9fe),
            // Colors.cyanAccent,
            borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 3.5 / 100, vertical: height * 1 / 100),
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: size * 9.5 / 100,
                color: Color(0xFF29bae9),
              ),
            ),
          ),
        ),
      ),
    );
  }

  DatabaseServices databaseServices = new DatabaseServices();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var size = (height + width) / 8;

    return Scaffold(
      backgroundColor: Color(0xFFEEF4F6),
      body: StreamBuilder<UserData>(
          stream: db.streamUserData(email: currentUser.email),
          builder: (context, snapshot) {
            if (!(snapshot.hasData)) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Material(
                  elevation: 8,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: height * 6 / 100, bottom: height * 6.5 / 100),
                    color: Color(0xFF29bae9),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: width * 3 / 100),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Color(0xFFecf9fe),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: width * 4 / 100),
                                  child: Text(
                                    'Current Items',
                                    style: TextStyle(
                                        color: Color(0xFFecf9fe),
                                        fontSize: size * 15 / 100,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 3.5 / 100,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: width * 7 / 100),
                          child: Row(
                            children: [
                              imageProvider('images/dollar.png',
                                  height: height, width: width),
                              itemsCount(width, height, size,
                                  text: snapshot.data.coins.toString()),
                              imageProvider('images/key.png',
                                  height: height, width: width),
                              itemsCount(width, height, size,
                                  text: snapshot.data.keys.toString()),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 3 / 100,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: width * 7 / 100),
                          child: Row(
                            children: [
                              imageProvider('images/pocket-watch.png',
                                  height: height, width: width),
                              itemsCount(width, height, size,
                                  text: snapshot.data.watches.toString()),
                              imageProvider('images/diamond.png',
                                  height: height, width: width),
                              itemsCount(width, height, size,
                                  text: snapshot.data.gems.toString()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(
                      scale:
                          CurvedAnimation(parent: animation, curve: Curves.ease)
                            ..addStatusListener((status) {
                              if (status == AnimationStatus.completed) {}
                            }),
                      child: child,
                    );
                  },
                  duration: Duration(milliseconds: 400),
                  child: Image.asset(
                    images[index],
                    key: ValueKey<int>(index),
                    width: width * 70 / 100,
                    height: height * 35 / 100,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 3 / 100,
                    horizontal: width * 4 / 100,
                  ),
                  child: RaisedButton(
                    padding: EdgeInsets.only(
                      top: height * 2 / 100,
                      bottom: height * 2 / 100,
                      left: width * 12 / 100,
                      right: width * 5 / 100,
                    ),
                    color: Color(0xFF29bae9),
                    onPressed: () {
                      try {
                        if (snapshot.data.keys >= 3) {
                          setState(() {
                            index = 1;
                          });
                          firebaseDataUpdationServices.updateKeys(
                              currentKeys: snapshot.data.keys,
                              keysTobeAdded: -3);

                          Future.delayed(Duration(milliseconds: 500), () {
                            // rewardPopup(context, height: height, width: width);
                            setState(() {
                              index = 0;
                            });

                            var reward = itemsTobeCollected[
                                rnd.nextInt(itemsTobeCollected.length)];
                            var itemType = rewardsLogic.getReward(
                              reward,
                              currentCoins: snapshot.data.coins,
                              currentKeys: snapshot.data.keys - 3,
                              currentWatches: snapshot.data.watches,
                              currentGems: snapshot.data.gems,
                              totalCoins: snapshot.data.totalCoins,
                            );
                            var rewardAmount =
                                reward.substring(0, reward.length - 1);

                            databaseServices.userHistoryData(
                                historyMessage: "You win " +
                                    rewardAmount +
                                    " " +
                                    itemType +
                                    " from crate",
                                timestamp: DateTime.now());

                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              title: "Congratulations!",
                              text: "You got " + rewardAmount + " " + itemType,
                            );
                          });
                        } else {
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.warning,
                            title: "Not enough keys!",
                            text:
                                "You require atleast 3 keys to open the crate.",
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
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 4.5 / 100,
                          ),
                          Image.asset(
                            'images/key.png',
                            width: width * 8 / 100,
                          ),
                          SizedBox(
                            width: width * 8 / 100,
                          ),
                          Text(
                            'Open for 3 keys',
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
                )
              ],
            );
          }),
    );
  }
}
