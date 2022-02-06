import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reward_app/Screens/HistoryScreen.dart';
import 'package:reward_app/Screens/IntroScreen.dart';
import 'package:reward_app/Screens/ItemDescriptionScreen.dart';
import 'package:reward_app/Screens/RedeemScreen.dart';
import 'package:reward_app/Screens/RewardsScreen.dart';
import 'package:reward_app/Screens/TasksScreen.dart';
import 'package:reward_app/Screens/WithdrawScreen.dart';
import 'package:reward_app/Services/DatabaseServices.dart';
import 'package:reward_app/Services/FirebaseGetData.dart';
import 'package:reward_app/Services/SignInServices.dart';
import 'package:reward_app/Services/UserState.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // Widget build(BuildContext context) {
  //   return Container();
  // }
  SignInServies signInServies = SignInServies();
  FirebaseAuth _auth = FirebaseAuth.instance;
  User currentSignedInUser;
  var tabController;
  var indicatedColor = 0;
  final controller = PageController();

  var currentUserAlternateName = 'App User';
  var currentUserAlternateImage = AssetImage('images/user.png');

  DatabaseServices databaseServices = DatabaseServices();

  // getCurrentUser() async {
  //   return await _auth.currentUser;
  // }

  var time = DateTime.friday;

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
    'Click on promotion',
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

  @override
  void initState() {
    super.initState();

    currentSignedInUser = _auth.currentUser;

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  UserState userState = UserState();
  var firestore = FirebaseFirestore.instance;

  FirebaseGetUserData db = FirebaseGetUserData();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var size = (height + width) / 8;

    return Scaffold(
      body: StreamBuilder<UserData>(
          stream: db.streamUserData(email: currentSignedInUser.email),
          builder: (context, snapshot) {
            if (!(snapshot.hasData)) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  bottom: TabBar(
                    indicatorColor: Color(0xFF29bae9),
                    controller: tabController,
                    tabs: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: height * 2 / 100,
                        ),
                        child: Text(
                          'Rewards',
                          style: TextStyle(
                              color: Color(0xFF708187),
                              fontSize: size * 12 / 100),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: height * 2 / 100,
                        ),
                        child: Text(
                          'Tasks',
                          style: TextStyle(
                              color: Color(0xFF708187),
                              fontSize: size * 12 / 100),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: height * 2 / 100),
                        child: Text(
                          'History',
                          style: TextStyle(
                              color: Color(0xFF708187),
                              fontSize: size * 12 / 100),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.white,
                  expandedHeight: height * 45 / 100,
                  pinned: true,
                  iconTheme: IconThemeData(
                    color: Color(0xFF29bae9),
                  ),
                  //  leading: Icon(Icons.),
                  title: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                      left: width * 15.5 / 100,
                      right: width * 18.5 / 100,
                      top: height * 5 / 100,
                      bottom: height * 5 / 100,
                    ),
                    child: Text(
                      (currentSignedInUser.displayName != null)
                          ? currentSignedInUser.displayName
                          : currentUserAlternateName,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1c5162),
                          fontSize: size * 15.5 / 100),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'images/reward_image.jpg',
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height * 14.5 / 100),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 2 / 100,
                                      vertical: height * 1 / 100),
                                  child: Text(
                                    "Current Coins",
                                    style: TextStyle(
                                        color: Color(
                                          0xFF537b88,
                                        ),
                                        fontSize: size * 11 / 100,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 4 / 100,
                                            vertical: height * 1.5 / 100),
                                        child: Text(
                                          //snapshot.data['coins'].toString(),

                                          snapshot.data.coins.toString(),

                                          // "5,01,234",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              fontSize: size * 30 / 100),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF29bae9),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 1 / 100,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFecf9fe),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 3.5 / 100,
                                            vertical: height * 1 / 100),
                                        child: Text(
                                          "Lifetime score: ${snapshot.data.totalCoins}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: size * 9.5 / 100,
                                            color: Color(0xFF29bae9),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: height * 7 / 100,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                      height: (height * 90 / 100),
                      child: Scaffold(
                        body: TabBarView(controller: tabController, children: [
                          RewardsScreen(
                            height: height,
                            width: width,
                            size: size,
                          ),
                          TasksScreen(
                              height: height,
                              width: width,
                              taskContainerIcons: taskContainerIcons,
                              taskContainerNames: taskContainerNames,
                              taskContainerComments: taskContainerComments,
                              size: size),
                          HistoryScreen(
                              height: height, width: width, size: size)
                        ]),
                      )),
                )
              ],
            )
                //,
                ;
          }),
      drawer: Drawer(
        child: Container(
          color: Color(0xFFEEF4F6),
          child: ListView(
            children: [
              Container(
                height: height / 3,
                decoration: BoxDecoration(
                    color: Color(0xFF29bae9),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF29bae9).withOpacity(1.0),
                          Color(0xFF29bae9).withOpacity(0.5),
                          Color(0xFF29bae9).withOpacity(0.0),
                        ])),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: height * 1 / 100, left: width * 4 / 100),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Color(0xFF1c5162).withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFFecf9fe),
                          radius: size * 50 / 100,
                          backgroundImage:
                              (currentSignedInUser.photoURL != null)
                                  ? NetworkImage(currentSignedInUser.photoURL)
                                  : currentUserAlternateImage,
                        ),
                        SizedBox(height: height * 1.5 / 100),
                        Text(
                          (currentSignedInUser.displayName != null)
                              ? currentSignedInUser.displayName
                              : currentUserAlternateName,
                          style: TextStyle(
                              color: Color(0xFF1c5162).withOpacity(0.8),
                              fontWeight: FontWeight.w900,
                              fontSize: size * 16 / 100),
                        ),
                        SizedBox(height: height * 1 / 100),
                        Text(
                          currentSignedInUser.email,
                          style: TextStyle(
                              color: Color(0xFF708187).withOpacity(0.4),
                              fontSize: size * 11 / 100,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemDescriptionScreen()));
                },
                leading: Icon(
                  Icons.description_outlined,
                  color: Color(0xFF1c5162).withOpacity(0.6),
                ),
                title: Text(
                  "Item Description",
                  style: TextStyle(
                      color: Color(0xFF1c5162).withOpacity(0.6),
                      fontWeight: FontWeight.w600,
                      fontSize: size * 12 / 100),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RedeemScreen()));
                },
                leading: Icon(
                  Icons.redeem_outlined,
                  color: Color(0xFF1c5162).withOpacity(0.6),
                ),
                title: Text(
                  "Redeem",
                  style: TextStyle(
                      color: Color(0xFF1c5162).withOpacity(0.6),
                      fontWeight: FontWeight.w600,
                      fontSize: size * 12 / 100),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WithdrawScreen()));
                },
                leading: Icon(
                  Icons.attach_money_outlined,
                  color: Color(0xFF1c5162).withOpacity(0.6),
                ),
                title: Text(
                  "Withdraw",
                  style: TextStyle(
                      color: Color(0xFF1c5162).withOpacity(0.6),
                      fontWeight: FontWeight.w600,
                      fontSize: size * 12 / 100),
                ),
              ),
              ListTile(
                title: Text(
                  "  ---------------------------------------------",
                  style: TextStyle(
                      color: Color(0xFF1c5162).withOpacity(0.2),
                      fontWeight: FontWeight.w600,
                      fontSize: size * 12 / 100),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  showAboutDialog(
                      context: context,
                      applicationName: 'Rewarder',
                      applicationVersion: '1.0.0',
                      applicationLegalese:
                          'This is Rewarder version 1.0.0 with all the copy rightes secured by the maker of this app. Any attempy to steal this app or its content can cause copy right issues and a legal action against you.',
                      applicationIcon: Image.asset(
                        'images/intro_image1.png',
                        height: height * 5.5 / 100,
                        width: width * 11 / 100,
                      ));
                },
                leading: Icon(
                  Icons.info_outline,
                  color: Color(0xFF1c5162).withOpacity(0.6),
                ),
                title: Text(
                  "About",
                  style: TextStyle(
                      color: Color(0xFF1c5162).withOpacity(0.6),
                      fontWeight: FontWeight.w600,
                      fontSize: size * 12 / 100),
                ),
              ),
              StreamBuilder<DocumentSnapshot>(
                  stream: firestore
                      .collection('appLink')
                      .doc('rewarderPlayStoreUrlLink')
                      .snapshots(),
                  builder: (context, snapshot) {
                    return ListTile(
                      onTap: () async {
                        try {
                          if (snapshot.data['link'] == "") {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.info,
                              title: "Not Available!",
                              text: "This option will be available soon.",
                            );
                          } else {
                            var url = snapshot.data['link'];
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.warning,
                                title: "Invalid Url!",
                                text: "The url is not valid to launch.",
                              );
                            }
                          }
                        } catch (e) {
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            title: "Sorry!",
                            text: e.toString(),
                            //  "An error occured. Come back later.",
                          );
                        }
                      },
                      leading: Icon(
                        Icons.star_border,
                        color: Color(0xFF1c5162).withOpacity(0.6),
                      ),
                      title: Text(
                        "Rate us",
                        style: TextStyle(
                            color: Color(0xFF1c5162).withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                            fontSize: size * 12 / 100),
                      ),
                    );
                  }),
              ListTile(
                onTap: () {
                  try {
                    databaseServices.userHistoryData(
                        historyMessage: 'User logged out',
                        timestamp: DateTime.now());
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => IntroScreen()),
                        (route) => false);

                    signInServies.signOutGoogle();
                    userState.setVisitingFlag(value: false);
                  } catch (e) {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.error,
                      title: "Oops...",
                      text: "Sorry, something went wrong",
                    );
                  }
                },
                leading: Icon(
                  Icons.logout,
                  color: Color(0xFF1c5162).withOpacity(0.6),
                ),
                title: Text(
                  "Log out",
                  style: TextStyle(
                      color: Color(0xFF1c5162).withOpacity(0.6),
                      fontWeight: FontWeight.w600,
                      fontSize: size * 12 / 100),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
