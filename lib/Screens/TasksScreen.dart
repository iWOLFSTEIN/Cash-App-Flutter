import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reward_app/Screens/OpenCrateScreen.dart';
import 'package:reward_app/Screens/ShopScreen.dart';
import 'package:reward_app/Screens/SpinningWheelScreen.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:reward_app/Services/DatabaseServices.dart';
import 'package:reward_app/Services/FirebaseDataUpdationServices.dart';
import 'package:reward_app/Services/FirebaseGetData.dart';
import 'package:share/share.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({
    Key key,
    @required this.height,
    @required this.width,
    @required this.taskContainerIcons,
    @required this.taskContainerNames,
    @required this.taskContainerComments,
    @required this.size,
    this.topPadding,
  }) : super(key: key);

  final double height;
  final double width;
  final List taskContainerIcons;
  final List taskContainerNames;
  final List taskContainerComments;
  final double size;
  final double topPadding;

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool showSpinner = false;

  int currentCoins;
  int interstitialAdsCount;
  int videoAdsCount;

  var timestampInterstitialAds;
  var timestampVideoAds;

  int totalCoins;

  var currentTime = DateTime.now();
  DatabaseServices databaseServices = new DatabaseServices();

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: appAdID);
    streamUserData =
        firebaseGetUserData.streamUserData(email: currentUser.email);

    streamUserData.listen((event) {
      setState(() {
        currentCoins = event.coins;
        interstitialAdsCount = event.interstitialAdsCount;
        videoAdsCount = event.videoAdsCount;
        timestampInterstitialAds = event.timestampInterstitialAds;
        timestampVideoAds = event.timestampVideoAds;
        totalCoins = event.totalCoins;
      });
    });

    rewardedVideoAds.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      if (event == RewardedVideoAdEvent.rewarded) {
        try {
          firbaseDataUpdationServices.updateCoins(
              currentCoins: currentCoins,
              coinsTobeAdded: rewardAmount,
              totalCoins: totalCoins);

          databaseServices.userHistoryData(
              historyMessage: 'Video Ad reward collected',
              timestamp: DateTime.now());

          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            title: "Congratulations!",
            text: "You got 10 coins.",
          );
        } catch (e) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: "Sorry",
            text: "An error occured.",
          );
        }
      } else if (event == RewardedVideoAdEvent.failedToLoad) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Sorry",
          text: "There is no ad to show at this time!",
        );
        setState(() {
          showSpinner = false;
        });
      } else if (event == RewardedVideoAdEvent.opened) {
        setState(() {
          showSpinner = false;
        });

        try {
          firbaseDataUpdationServices.updateVideoAdsCount(
              count: videoAdsCount + 1);
        } catch (e) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: "Sorry",
            text: "An error occured.",
          );
        }
      }
    };
  }

  @override
  void dispose() {
    super.dispose();
  }

  static const String appAdID = "ca-app-pub-7291860918270627~6266591535";

  static const String interstitialAdID =
      'ca-app-pub-7291860918270627/4741756872';

  static const String videoAdID = 'ca-app-pub-7291860918270627/6177632639';

  var rewardedVideoAds = RewardedVideoAd.instance;

  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    childDirected: true,
    testDevices: <String>[],
  );

  FirbaseDataUpdationServices firbaseDataUpdationServices =
      FirbaseDataUpdationServices();
  var currentUser = FirebaseAuth.instance.currentUser;
  FirebaseGetUserData firebaseGetUserData = FirebaseGetUserData();
  Stream<UserData> streamUserData;

  InterstitialAd myInterstitial() => InterstitialAd(
        adUnitId:
            // interstitialAdID,
            InterstitialAd.testAdUnitId,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) async {
          print("InterstitialAd event is $event");
          if (event == MobileAdEvent.failedToLoad) {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              title: "Sorry",
              text: "There is no ad to show at this time!",
            );
            setState(() {
              showSpinner = false;
            });
          } else if (event == MobileAdEvent.opened) {
            setState(() {
              showSpinner = false;
            });
            try {
              firbaseDataUpdationServices.updateInterstitialAdsCount(
                  count: interstitialAdsCount + 1);
            } catch (e) {
              CoolAlert.show(
                context: context,
                type: CoolAlertType.error,
                title: "Sorry!",
                text: "An error occured.",
              );
            }
          } else if (event == MobileAdEvent.clicked) {
            try {
              firbaseDataUpdationServices.updateCoins(
                  currentCoins: currentCoins,
                  coinsTobeAdded: 5,
                  totalCoins: totalCoins);

              databaseServices.userHistoryData(
                  historyMessage: 'Interstitial Ad reward collected',
                  timestamp: DateTime.now());

              CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                title: "Congratulations!",
                text: "You got 5 coins.",
              );
            } catch (e) {
              CoolAlert.show(
                context: context,
                type: CoolAlertType.error,
                title: "Sorry!",
                text: "An error occured.",
              );
            }
          }
        },
      );
  var firestore = FirebaseFirestore.instance;

  share(BuildContext context, {var link, var subject}) {
    final RenderBox box = context.findRenderObject();
    Share.share(link,
        subject: subject,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEF4F6),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: (widget.topPadding == null)
                        ? widget.height * 0 / 100
                        : widget.topPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClickableIconContainer(
                        voidCallBack: () async {
                          try {
                            if (currentTime
                                .isAfter(timestampVideoAds.toDate())) {
                              if (videoAdsCount <= 9) {
                                setState(() {
                                  showSpinner = true;
                                });
                                await rewardedVideoAds.load(
                                    adUnitId:
                                        // videoAdID,
                                        RewardedVideoAd.testAdUnitId,
                                    targetingInfo: targetingInfo);

                                await rewardedVideoAds.show();
                              } else {
                                firbaseDataUpdationServices.updateVideoAdsCount(
                                    count: 0);
                                var updatedTime =
                                    currentTime.add(Duration(seconds: 86400));
                                firbaseDataUpdationServices
                                    .updateTimestampVideoAds(time: updatedTime);
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.warning,
                                  title: "Ads Limit Reached!",
                                  text:
                                      "You can watch 10 ads. Once ads limit reached, wait for 24 hours.",
                                );
                              }
                            } else {
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.warning,
                                title: "Ads Limit Reached!",
                                text:
                                    "You can watch 10 ads. Once ads limit reached, wait for 24 hours.",
                              );
                            }
                          } catch (e) {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              title: "Sorry",
                              text: "There is no ad to show at this time!",
                            );
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        },
                        height: widget.height,
                        width: widget.width,
                        taskContainerIcons: widget.taskContainerIcons[0],
                        taskContainerNames: widget.taskContainerNames[0],
                        taskContainerComments: widget.taskContainerComments[0],
                        size: widget.size),
                    SizedBox(
                      width: widget.width * 5 / 100,
                    ),
                    ClickableIconContainer(
                        voidCallBack: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SpinningWheelScreen()));
                        },
                        height: widget.height,
                        width: widget.width,
                        taskContainerIcons: widget.taskContainerIcons[1],
                        taskContainerNames: widget.taskContainerNames[1],
                        taskContainerComments: widget.taskContainerComments[1],
                        size: widget.size),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: widget.height * 4 / 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClickableIconContainer(
                        voidCallBack: () {
                          try {
                            if (currentTime
                                .isAfter(timestampInterstitialAds.toDate())) {
                              if (interstitialAdsCount <= 9) {
                                setState(() {
                                  showSpinner = true;
                                });
                                var myInterstitialAd = myInterstitial();
                                myInterstitialAd
                                  ..load()
                                  ..show(
                                    anchorType: AnchorType.bottom,
                                    anchorOffset: 0.0,
                                    horizontalCenterOffset: 0.0,
                                  );
                              } else {
                                firbaseDataUpdationServices
                                    .updateInterstitialAdsCount(count: 0);
                                var updatedTime =
                                    currentTime.add(Duration(seconds: 86400));
                                firbaseDataUpdationServices
                                    .updateTimestampInterstitialAds(
                                        time: updatedTime);
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.warning,
                                  title: "Ads Limit Reached!",
                                  text:
                                      "You can click 10 ads. Once ads limit reached, wait for 24 hours.",
                                );
                              }
                            } else {
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.warning,
                                title: "Ads Limit Reached!",
                                text:
                                    "You can click 10 ads. Once ads limit reached, wait for 24 hours.",
                              );
                            }
                          } catch (e) {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              title: "Sorry",
                              text: "There is no ad to show at this time!",
                            );
                          }
                        },
                        height: widget.height,
                        width: widget.width,
                        taskContainerIcons: widget.taskContainerIcons[3],
                        taskContainerNames: widget.taskContainerNames[3],
                        taskContainerComments: widget.taskContainerComments[3],
                        size: widget.size),
                    SizedBox(
                      width: widget.width * 5 / 100,
                    ),
                    ClickableIconContainer(
                        voidCallBack: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OpenCrateScreen()));
                        },
                        height: widget.height,
                        width: widget.width,
                        taskContainerIcons: widget.taskContainerIcons[2],
                        taskContainerNames: widget.taskContainerNames[2],
                        taskContainerComments: widget.taskContainerComments[2],
                        size: widget.size),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: widget.height * 4 / 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClickableIconContainer(
                        voidCallBack: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ShopScreen();
                          }));
                        },
                        height: widget.height,
                        width: widget.width,
                        taskContainerIcons: widget.taskContainerIcons[4],
                        taskContainerNames: widget.taskContainerNames[4],
                        taskContainerComments: widget.taskContainerComments[4],
                        size: widget.size),
                    SizedBox(
                      width: widget.width * 5 / 100,
                    ),
                    StreamBuilder<DocumentSnapshot>(
                        stream: firestore
                            .collection('appLink')
                            .doc('rewarderPlayStoreUrlLink')
                            .snapshots(),
                        builder: (context, snapshot) {
                          return ClickableIconContainer(
                              voidCallBack: () {
                                try {
                                  if (snapshot.data['link'] == "") {
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.info,
                                      title: "Not Available!",
                                      text:
                                          "This option will be available soon.",
                                    );
                                  } else {
                                    share(context,
                                        link: snapshot.data['link'],
                                        subject:
                                            "Install the Rewarder Now to get amazing cash prizes!");
                                  }
                                } catch (e) {
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.error,
                                    title: "Sorry!",
                                    text: "An error occured. Come back later.",
                                  );
                                }
                              },
                              height: widget.height,
                              width: widget.width,
                              taskContainerIcons: widget.taskContainerIcons[5],
                              taskContainerNames: widget.taskContainerNames[5],
                              taskContainerComments:
                                  widget.taskContainerComments[5],
                              size: widget.size);
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClickableIconContainer extends StatelessWidget {
  const ClickableIconContainer({
    Key key,
    @required this.height,
    @required this.width,
    @required this.taskContainerIcons,
    @required this.taskContainerNames,
    @required this.size,
    this.taskContainerComments,
    this.voidCallBack,
  }) : super(key: key);

  final double height;
  final double width;
  final String taskContainerIcons;
  final String taskContainerNames;
  final String taskContainerComments;
  final double size;
  final voidCallBack;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (voidCallBack == null) ? () {} : voidCallBack,
      child: Container(
        height: height * 24 / 100,
        width: width * 42 / 100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Padding(
          padding: EdgeInsets.only(bottom: height * 1 / 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFFecf9fe),
                radius: size * 25 / 100,
                backgroundImage: AssetImage(
                  taskContainerIcons,
                ),
              ),
              SizedBox(height: height * 2.5 / 100),
              Text(
                taskContainerNames,
                style: TextStyle(
                    color: Color(0xFF1c5162),
                    fontSize: size * 12 / 100,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: height * 0.8 / 100),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 1.5 / 100),
                  child: Text(
                    taskContainerComments,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF708187).withOpacity(0.4),
                        fontSize: size * 9 / 100,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
