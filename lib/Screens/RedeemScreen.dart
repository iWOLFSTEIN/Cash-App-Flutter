import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reward_app/Screens/HistoryScreen.dart';
import 'package:reward_app/Screens/RewardsScreen.dart';
import 'package:reward_app/Screens/TasksScreen.dart';
import 'package:reward_app/Screens/WithdrawScreen.dart';
import 'package:reward_app/Services/DatabaseServices.dart';
import 'package:reward_app/Services/FirebaseDataUpdationServices.dart';
import 'package:reward_app/Services/FirebaseGetData.dart';

class RedeemScreen extends StatefulWidget {
  RedeemScreen({Key key}) : super(key: key);

  @override
  _RedeemScreenState createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen> {
  List taskContainerNames = [
    'Watch Ads',
    'Spin & Win',
    'Open Crate',
    'Promotions',
    'Sell & Buy',
    'Share App'
  ];

  List taskContainerComments = [
    'Watch video to earn points',
    'Spin to win rewards',
    'Open to get amazing prizes',
    'See promotion for 30 sec',
    'Exchange rewards',
    'Share to get rewards'
  ];

  List taskContainerIcons = [
    'images/watch_ad_icon.png',
    'images/Spin-the-wheel-Icon.png',
    'images/treasure.png',
    'images/promotion_icon.png',
    'images/shop.png',
    'images/share.png'
  ];

  FirbaseDataUpdationServices firbaseDataUpdationServices =
      FirbaseDataUpdationServices();
  var currentUser = FirebaseAuth.instance.currentUser;
  FirebaseGetUserData firebaseGetUserData = FirebaseGetUserData();
  DatabaseServices databaseServices = new DatabaseServices();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var size = (height + width) / 8;

    return Scaffold(
      backgroundColor: Color(0xFFEBF4F3),
      // Color(0xFFEEF4F6),
      body: StreamBuilder<UserData>(
          stream: firebaseGetUserData.streamUserData(email: currentUser.email),
          builder: (context, snapshot) {
            if (!(snapshot.hasData)) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height * 7 / 100),
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
                            color: Color(0xFF1c5162),
                          ),
                        ),
                        SizedBox(
                          width: width * 3.5 / 100,
                        ),
                        Text(
                          'Redeem your rewards',
                          style: TextStyle(
                              color: Color(0xFF1c5162),
                              fontSize: size * 11 / 100,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 4 / 100),
                  child: Container(
                    //  alignment: Alignment.center,
                    height: height * 18 / 100,
                    decoration: BoxDecoration(
                        color: Color(0xFF29bae9),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width * 15 / 100),
                          child: buildColumn(size, height,
                              name: 'Balance',
                              value: '\$${snapshot.data.money}.0'),
                        ),
                        Expanded(child: SizedBox()),
                        Padding(
                          padding: EdgeInsets.only(right: width * 15 / 100),
                          child: buildColumn(size, height,
                              name: 'Gems',
                              value: snapshot.data.gems.toString()),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: height * 65 / 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: width * 18 / 100,
                          right: width * 18 / 100,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HistoryScreen(
                                        height: height,
                                        width: width,
                                        size: size)));
                          },
                          child: Container(
                            height: height * 5 / 100,
                            decoration: BoxDecoration(
                                color: Color(0xFF76DBD1),
                                borderRadius: BorderRadius.circular(75)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Go to History',
                                  style: TextStyle(
                                      fontSize: size * 11 / 100,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: width * 3 / 100,
                                ),
                                Icon(
                                  Icons.forward,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 3 / 100),
                        child: Container(
                          height: height * 10 / 100,
                          decoration: BoxDecoration(
                              color: Color(0xFFEBF4F3).withOpacity(0.7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'images/dollars.png',
                                height: height * 24 / 100,
                                width: width * 12 / 100,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Earn 20 dollars",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFF1c5162).withOpacity(0.6),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.7 / 100,
                                  ),
                                  Text(
                                    "For 5000 reward gems",
                                    style: TextStyle(
                                        color:
                                            Color(0xFF708187).withOpacity(0.3),
                                        fontSize: size * 10 / 100,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  try {
                                    if (snapshot.data.gems >= 5000) {
                                      firbaseDataUpdationServices.updateGems(
                                          currentGems: snapshot.data.gems,
                                          gemsTobeAdded: -5000);

                                      firbaseDataUpdationServices.updateMoney(
                                          currentMoney: snapshot.data.money,
                                          moneyTobeAdded: 20);

                                      databaseServices.userHistoryData(
                                          historyMessage:
                                              'Redeemed 20\$ with 5000 gems',
                                          timestamp: DateTime.now());

                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.success,
                                        title: "Transaction Successful!",
                                        text: "You got 20 dollars.",
                                      );
                                    } else {
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.warning,
                                        title: "Not enough gems!",
                                        text:
                                            "You require atleast 5000 gems to redeem you reward.",
                                      );
                                    }
                                  } catch (e) {
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.error,
                                      title: "Sorry",
                                      text:
                                          // e.toString(),
                                          "An error occured.",
                                    );
                                  }
                                },
                                child: Container(
                                  height: height * 7 / 100,
                                  width: width * 26 / 100,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF29bae9),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Center(
                                    child: Text(
                                      'Redeem',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size * 11 / 100,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      buildRewardTile(width, height,
                          imageAdress: 'images/bank.png',
                          name: 'Ways to earn', voidCallBack: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TasksScreen(
                                      topPadding: height * 7.5 / 100,
                                      height: height,
                                      width: width,
                                      taskContainerIcons: taskContainerIcons,
                                      taskContainerNames: taskContainerNames,
                                      taskContainerComments:
                                          taskContainerComments,
                                      size: size,
                                    )));
                      }),
                      buildRewardTile(width, height,
                          imageAdress: 'images/gift-box.png',
                          name: 'All rewards', voidCallBack: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RewardsScreen(
                                      topPadding: height * 3 / 100,
                                      height: height,
                                      width: width,
                                      size: size,
                                    )));
                      }),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 4 / 100),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WithdrawScreen()));
                          },
                          child: Container(
                            height: height * 8 / 100,
                            decoration: BoxDecoration(
                                color: Color(0xFF76DBD1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: Text(
                                'Withdraw',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: size * 12 / 100),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }

  Padding buildRewardTile(double width, double height,
      {var imageAdress, var name, var voidCallBack}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 3 / 100),
      child: Container(
        height: height * 10 / 100,
        decoration: BoxDecoration(
            color: Color(0xFFEBF4F3).withOpacity(0.4),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              // 'images/bank.png',
              imageAdress,
              height: height * 24 / 100,
              width: width * 12 / 100,
            ),
            Text(
              //  "Ways to earn",
              name,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1c5162).withOpacity(0.6),
              ),
            ),
            SizedBox(
              width: width * 20 / 100,
            ),
            InkWell(
              onTap: voidCallBack,
              child: Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF1c5162).withOpacity(0.3),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column buildColumn(double size, double height, {var name, var value}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          // 'Balance',
          name,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: size * 11 / 100,
          ),
        ),
        SizedBox(
          height: height * 1.5 / 100,
        ),
        Text(
          // "\$537.0",
          value,
          style: TextStyle(
              color: Colors.white,
              fontSize: size * 19 / 100,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
