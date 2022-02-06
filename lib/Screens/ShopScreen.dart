import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reward_app/Services/DatabaseServices.dart';
import 'package:reward_app/Services/FirebaseDataUpdationServices.dart';
import 'package:reward_app/Services/FirebaseGetData.dart';
import 'package:cool_alert/cool_alert.dart';

class ShopScreen extends StatefulWidget {
  ShopScreen({Key key}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  FirbaseDataUpdationServices firbaseDataUpdationServices =
      FirbaseDataUpdationServices();
  var currentUser = FirebaseAuth.instance.currentUser;
  FirebaseGetUserData firebaseGetUserData = FirebaseGetUserData();

  buyGems({
    var coinsTobeAdded,
    var currentGems,
    var gemsTobeAdded,
    var currentCoins,
    var currentKeys,
    var keysTobeAdded,
    var currentWatches,
    var watchesTobeAdded,
  }) {
    if (coinsTobeAdded == 100) {
      firbaseDataUpdationServices.updateCoins(
          currentCoins: currentCoins, coinsTobeAdded: -100);
      firbaseDataUpdationServices.updateGems(
          currentGems: currentGems, gemsTobeAdded: gemsTobeAdded);
    } else if (coinsTobeAdded == 400) {
      firbaseDataUpdationServices.updateCoins(
          currentCoins: currentCoins, coinsTobeAdded: -400);
      firbaseDataUpdationServices.updateGems(
          currentGems: currentGems, gemsTobeAdded: gemsTobeAdded);
      firbaseDataUpdationServices.updateKeys(
          currentKeys: currentKeys, keysTobeAdded: keysTobeAdded);
    } else if (coinsTobeAdded == 500) {
      firbaseDataUpdationServices.updateCoins(
          currentCoins: currentCoins, coinsTobeAdded: -500);
      firbaseDataUpdationServices.updateGems(
          currentGems: currentGems, gemsTobeAdded: gemsTobeAdded);
      firbaseDataUpdationServices.updateWatches(
          currentWatches: currentWatches, watchesTobeAdded: watchesTobeAdded);
    } else if (coinsTobeAdded == 1000) {
      firbaseDataUpdationServices.updateCoins(
          currentCoins: currentCoins, coinsTobeAdded: -1000);
      firbaseDataUpdationServices.updateGems(
          currentGems: currentGems, gemsTobeAdded: gemsTobeAdded);
      firbaseDataUpdationServices.updateKeys(
          currentKeys: currentKeys, keysTobeAdded: keysTobeAdded);
      firbaseDataUpdationServices.updateWatches(
          currentWatches: currentWatches, watchesTobeAdded: watchesTobeAdded);
    }
  }

  buyKeys({
    var coinsTobeAdded,
    var currentGems,
    var gemsTobeAdded,
    var currentCoins,
    var currentKeys,
    var keysTobeAdded,
  }) {
    if (coinsTobeAdded == 60) {
      firbaseDataUpdationServices.updateCoins(
          currentCoins: currentCoins, coinsTobeAdded: -60);
      firbaseDataUpdationServices.updateKeys(
          currentKeys: currentKeys, keysTobeAdded: keysTobeAdded);
    } else if (coinsTobeAdded == 200) {
      firbaseDataUpdationServices.updateCoins(
          currentCoins: currentCoins, coinsTobeAdded: -200);
      firbaseDataUpdationServices.updateGems(
          currentGems: currentGems, gemsTobeAdded: gemsTobeAdded);
      firbaseDataUpdationServices.updateKeys(
          currentKeys: currentKeys, keysTobeAdded: keysTobeAdded);
    } else if (coinsTobeAdded == 400) {
      firbaseDataUpdationServices.updateCoins(
          currentCoins: currentCoins, coinsTobeAdded: -400);
      firbaseDataUpdationServices.updateGems(
          currentGems: currentGems, gemsTobeAdded: gemsTobeAdded);
      firbaseDataUpdationServices.updateKeys(
          currentKeys: currentKeys, keysTobeAdded: keysTobeAdded);
    }
  }

  buyCoins({
    var coinsTobeAdded,
    var totalCoins,
    var currentCoins,
    var currentWatches,
    var watchesTobeAdded,
  }) {
    firbaseDataUpdationServices.updateWatches(
        currentWatches: currentWatches, watchesTobeAdded: -watchesTobeAdded);

    firbaseDataUpdationServices.updateCoins(
        currentCoins: currentCoins,
        coinsTobeAdded: coinsTobeAdded,
        totalCoins: totalCoins);
  }

  shop({
    var height,
    var width,
    var size,
    var widget,
    var description,
    var voidCallBack,
    var name,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: height * 4 / 100,
        // left: width * 10 / 100,
        // right: width * 10 / 100,
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        elevation: 2,
        child: Container(
          height: height / 2,
          width: width - (width * 10 / 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: height * 3 / 100),
                child: Text(
                  name,
                  //  'Basic Offer',
                  style: TextStyle(
                      color: Color(0xFF1c5162),
                      fontSize: size * 16 / 100,
                      fontWeight: FontWeight.w600),
                ),
              ),
              widget,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 5 / 100),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF708187).withOpacity(0.4),
                      fontSize: size * 14 / 100,
                      fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: voidCallBack,
                child: Container(
                  height: height * 8 / 100,
                  decoration: BoxDecoration(
                      color: Color(0xFF29bae9),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Center(
                    child: Text(
                      'Buy',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size * 15 / 100,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))),
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
      appBar: AppBar(
        backgroundColor: Color(0xFFEEF4F6),
        // iconTheme: IconTheme(data: null, child: null),
        iconTheme: IconThemeData(
          color: Color(0xFF1c5162),
        ),
        title: Text(
          'Shop',
          style: TextStyle(
            color: Color(0xFF1c5162),
          ),
        ),
      ),
      body: StreamBuilder<UserData>(
          stream: firebaseGetUserData.streamUserData(email: currentUser.email),
          builder: (context, snapshot) {
            if (!(snapshot.hasData)) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: [
                titleShop(height, width, size, title: 'Buy Gems'),
                Row(
                  children: [
                    Expanded(child: Container()),
                    shop(
                      height: height / 2,
                      width: width / 2,
                      size: size / 2,
                      name: 'Basic Offer',
                      widget: Image.asset(
                        'images/gem.png',
                        height: (height * 25 / 100) / 2,
                        width: (width * 40 / 100) / 2,
                      ),
                      voidCallBack: () {
                        try {
                          if (snapshot.data.coins >= 100) {
                            buyGems(
                                currentCoins: snapshot.data.coins,
                                coinsTobeAdded: 100,
                                currentGems: snapshot.data.gems,
                                gemsTobeAdded: 10);

                            databaseServices.userHistoryData(
                                historyMessage: 'Bought 10 gems',
                                timestamp: DateTime.now());
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              title: "Transaction Successful!",
                              text: "You got 10 gems.",
                            );
                          } else {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.warning,
                              title: "Not enough coins!",
                              text:
                                  "You require atleast 100 coins to get this offer.",
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
                      description: 'Buy 10 gems for 100 coins',
                    ),
                    Expanded(child: Container()),
                    shop(
                      height: height / 2,
                      width: width / 2,
                      size: size / 2,
                      name: 'Custom Offer',
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            'images/gem.png',
                            height: (height * 20 / 100) / 2,
                            width: (width * 34 / 100) / 2,
                          ),
                          SizedBox(
                            width: (width * 1 / 100) / 2,
                          ),
                          Text(
                            '+',
                            style: TextStyle(
                                color: Color(0xFF708187).withOpacity(0.4),
                                fontSize: (size * 26 / 100) / 2,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            width: (width * 1 / 100) / 2,
                          ),
                          Image.asset(
                            'images/keys.png',
                            height: (height * 6 / 100) / 2,
                            width: (width * 14 / 100) / 2,
                          )
                        ],
                      ),
                      voidCallBack: () {
                        try {
                          if (snapshot.data.coins >= 400) {
                            buyGems(
                              currentCoins: snapshot.data.coins,
                              coinsTobeAdded: 400,
                              currentGems: snapshot.data.gems,
                              gemsTobeAdded: 50,
                              currentKeys: snapshot.data.keys,
                              keysTobeAdded: 2,
                            );

                            databaseServices.userHistoryData(
                                historyMessage: 'Bought 50 gems and 2 keys',
                                timestamp: DateTime.now());
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              title: "Transaction Successful!",
                              text: "You got 50 gems and 2 keys.",
                            );
                          } else {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.warning,
                              title: "Not enough coins!",
                              text:
                                  "You require atleast 400 coins to get this offer.",
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
                      description: '50 gems + 2 keys for 400 coins',
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Container()),
                    shop(
                      height: height / 2,
                      width: width / 2,
                      size: size / 2,
                      name: 'Standard Offer',
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            'images/gem.png',
                            height: (height * 20 / 100) / 2,
                            width: (width * 34 / 100) / 2,
                          ),
                          SizedBox(
                            width: (width * 1 / 100) / 2,
                          ),
                          Text(
                            '+',
                            style: TextStyle(
                                color: Color(0xFF708187).withOpacity(0.4),
                                fontSize: (size * 26 / 100) / 2,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            width: (width * 1 / 100) / 2,
                          ),
                          Image.asset(
                            'images/pocket-watch.png',
                            height: (height * 6 / 100) / 2,
                            width: (width * 14 / 100) / 2,
                          )
                        ],
                      ),
                      voidCallBack: () {
                        try {
                          if (snapshot.data.coins >= 500) {
                            buyGems(
                              currentCoins: snapshot.data.coins,
                              coinsTobeAdded: 500,
                              currentGems: snapshot.data.gems,
                              gemsTobeAdded: 80,
                              currentWatches: snapshot.data.watches,
                              watchesTobeAdded: 10,
                            );
                            databaseServices.userHistoryData(
                                historyMessage: 'Bought 80 gems and 10 watches',
                                timestamp: DateTime.now());
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              title: "Transaction Successful!",
                              text: "You got 80 gems and 10 watches.",
                            );
                          } else {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.warning,
                              title: "Not enough coins!",
                              text:
                                  "You require atleast 500 coins to get this offer.",
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
                      description: '80 gems + 10 watches for 500 coins',
                    ),
                    Expanded(child: Container()),
                    shop(
                      height: height / 2,
                      width: width / 2,
                      size: size / 2,
                      name: 'Premium Offer',
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            'images/gem.png',
                            height: (height * 18 / 100) / 2,
                            width: (width * 30 / 100) / 2,
                          ),
                          SizedBox(
                            width: (width * 1 / 100) / 2,
                          ),
                          Text(
                            '+',
                            style: TextStyle(
                                color: Color(0xFF708187).withOpacity(0.4),
                                fontSize: (size * 26 / 100) / 2,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            width: (width * 1 / 100) / 2,
                          ),
                          Image.asset(
                            'images/keys.png',
                            height: (height * 4 / 100) / 2,
                            width: (width * 12 / 100) / 2,
                          ),
                          SizedBox(
                            width: (width * 1 / 100) / 2,
                          ),
                          Text(
                            '+',
                            style: TextStyle(
                                color: Color(0xFF708187).withOpacity(0.4),
                                fontSize: (size * 26 / 100) / 2,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            width: (width * 1 / 100) / 2,
                          ),
                          Image.asset(
                            'images/pocket-watch.png',
                            height: (height * 4 / 100) / 2,
                            width: (width * 12 / 100) / 2,
                          ),
                        ],
                      ),
                      voidCallBack: () {
                        try {
                          if (snapshot.data.coins >= 1000) {
                            buyGems(
                              currentCoins: snapshot.data.coins,
                              coinsTobeAdded: 1000,
                              currentGems: snapshot.data.gems,
                              gemsTobeAdded: 150,
                              currentKeys: snapshot.data.keys,
                              keysTobeAdded: 10,
                              currentWatches: snapshot.data.watches,
                              watchesTobeAdded: 15,
                            );

                            databaseServices.userHistoryData(
                                historyMessage:
                                    'Bought 150 gems and 10 keys and 15 watches',
                                timestamp: DateTime.now());
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              title: "Transaction Successful!",
                              text:
                                  "You got 150 gems and 10 keys and 15 watches.",
                            );
                          } else {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.warning,
                              title: "Not enough coins!",
                              text:
                                  "You require atleast 1000 coins to get this offer.",
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
                      description:
                          '150 gems + 10 keys + 15 watches for 1000 coins',
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                titleShop(height, width, size, title: 'Buy Keys'),
                Row(
                  children: [
                    Expanded(child: Container()),
                    shop(
                      height: height / 2,
                      width: width / 2,
                      size: size / 2,
                      name: 'Basic Offer',
                      widget: Image.asset(
                        'images/keys.png',
                        height: (height * 20 / 100) / 2,
                        width: (width * 34 / 100) / 2,
                      ),
                      voidCallBack: () {
                        try {
                          if (snapshot.data.coins >= 60) {
                            buyKeys(
                              currentCoins: snapshot.data.coins,
                              coinsTobeAdded: 60,
                              currentKeys: snapshot.data.keys,
                              keysTobeAdded: 3,
                            );
                            databaseServices.userHistoryData(
                                historyMessage: 'Bought 3 keys',
                                timestamp: DateTime.now());
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              title: "Transaction Successful!",
                              text: "You got 3 keys.",
                            );
                          } else {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.warning,
                              title: "Not enough coins!",
                              text:
                                  "You require atleast 60 coins to get this offer.",
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
                      description: 'Buy 3 keys for 60 coins',
                    ),
                    Expanded(child: Container()),
                    shop(
                      height: height / 2,
                      width: width / 2,
                      size: size / 2,
                      name: 'Custom Offer',
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            'images/keys.png',
                            height: (height * 16 / 100) / 2,
                            width: (width * 28 / 100) / 2,
                          ),
                          SizedBox(
                            width: (width * 1 / 100) / 2,
                          ),
                          Text(
                            '+',
                            style: TextStyle(
                                color: Color(0xFF708187).withOpacity(0.4),
                                fontSize: (size * 26 / 100) / 2,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            width: (width * 1 / 100) / 2,
                          ),
                          Image.asset(
                            'images/gem.png',
                            height: (height * 6 / 100) / 2,
                            width: (width * 14 / 100) / 2,
                          )
                        ],
                      ),
                      voidCallBack: () {
                        try {
                          if (snapshot.data.coins >= 200) {
                            buyKeys(
                              currentCoins: snapshot.data.coins,
                              coinsTobeAdded: 200,
                              currentGems: snapshot.data.gems,
                              gemsTobeAdded: 5,
                              currentKeys: snapshot.data.keys,
                              keysTobeAdded: 10,
                            );
                            databaseServices.userHistoryData(
                                historyMessage: 'Bought 5 gems and 10 keys',
                                timestamp: DateTime.now());
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              title: "Transaction Successful!",
                              text: "You got 5 gems and 10 keys.",
                            );
                          } else {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.warning,
                              title: "Not enough coins!",
                              text:
                                  "You require atleast 200 coins to get this offer.",
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
                      description: '10 keys + 5 gems for 200 coins',
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0 / 100),
                  child: Row(
                    children: [
                      Expanded(child: Container()),
                      shop(
                        height: height / 2,
                        width: width / 2,
                        size: size / 2,
                        name: 'Standard Offer',
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Image.asset(
                              'images/keys.png',
                              height: (height * 16 / 100) / 2,
                              width: (width * 28 / 100) / 2,
                            ),
                            SizedBox(
                              width: (width * 1 / 100) / 2,
                            ),
                            Text(
                              '+',
                              style: TextStyle(
                                  color: Color(0xFF708187).withOpacity(0.4),
                                  fontSize: (size * 26 / 100) / 2,
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              width: (width * 1 / 100) / 2,
                            ),
                            Image.asset(
                              'images/gem.png',
                              height: (height * 6 / 100) / 2,
                              width: (width * 14 / 100) / 2,
                            )
                          ],
                        ),
                        voidCallBack: () {
                          try {
                            if (snapshot.data.coins >= 400) {
                              buyKeys(
                                currentCoins: snapshot.data.coins,
                                coinsTobeAdded: 400,
                                currentGems: snapshot.data.gems,
                                gemsTobeAdded: 15,
                                currentKeys: snapshot.data.keys,
                                keysTobeAdded: 30,
                              );
                              databaseServices.userHistoryData(
                                  historyMessage: 'Bought 15 gems and 30 keys',
                                  timestamp: DateTime.now());
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                title: "Transaction Successful!",
                                text: "You got 15 gems and 30 keys.",
                              );
                            } else {
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.warning,
                                title: "Not enough coins!",
                                text:
                                    "You require atleast 400 coins to get this offer.",
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
                        description: '30 keys + 15 gems for 400 coins',
                      ),
                      Expanded(child: Container()),
                      Opacity(
                        opacity: 0.0,
                        child: shop(
                          height: height / 2,
                          width: width / 2,
                          size: size / 2,
                          name: 'Basic Offer',
                          widget: Image.asset(
                            'images/keys.png',
                            height: (height * 20 / 100) / 2,
                            width: (width * 34 / 100) / 2,
                          ),
                          voidCallBack: () {},
                          description: 'Buy 3 keys for 90 coins',
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
                titleShop(height, width, size, title: 'Buy Coins'),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 3 / 100),
                  child: Row(
                    children: [
                      Expanded(child: Container()),
                      shop(
                        height: height / 2,
                        width: width / 2,
                        size: size / 2,
                        name: 'Basic Offer',
                        widget: Image.asset(
                          'images/dollar.png',
                          height: (height * 19 / 100) / 2,
                          width: (width * 38 / 100) / 2,
                        ),
                        voidCallBack: () {
                          try {
                            if (snapshot.data.watches >= 10) {
                              buyCoins(
                                currentCoins: snapshot.data.coins,
                                coinsTobeAdded: 50,
                                currentWatches: snapshot.data.watches,
                                watchesTobeAdded: 10,
                                totalCoins: snapshot.data.totalCoins,
                              );
                              databaseServices.userHistoryData(
                                  historyMessage: 'Bought 50 coins',
                                  timestamp: DateTime.now());
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                title: "Transaction Successful!",
                                text: "You got 50 coins.",
                              );
                            } else {
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.warning,
                                title: "Not enough watches!",
                                text:
                                    "You require atleast 10 watches to get this offer.",
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
                        description: 'Buy 50 coins for 10 watches',
                      ),
                      Expanded(child: Container()),
                      Opacity(
                        opacity: 0.0,
                        child: shop(
                          height: height / 2,
                          width: width / 2,
                          size: size / 2,
                          name: 'Basic Offer',
                          widget: Image.asset(
                            'images/keys.png',
                            height: (height * 20 / 100) / 2,
                            width: (width * 34 / 100) / 2,
                          ),
                          voidCallBack: () {},
                          description: 'Buy 3 keys for 90 coins',
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  Padding titleShop(double height, double width, double size, {var title}) {
    return Padding(
      padding: EdgeInsets.only(
          top: height * 2 / 100,
          left: width * 14 / 100,
          right: width * 14 / 100),
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: height * 1.5 / 100),
        decoration: BoxDecoration(
            color: Color(0xFFecf9fe),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Text(
          // 'Buy Gems',
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xFF29bae9),
              fontSize: size * 12 / 100,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
