import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reward_app/Services/FirebaseDataUpdationServices.dart';
import 'package:reward_app/Services/FirebaseGetData.dart';

class WithdrawScreen extends StatefulWidget {
  WithdrawScreen({Key key}) : super(key: key);

  @override
  _WithdrawScreenState createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  var moneyContainerColor = Color(0xFFC5FF82);
  var creditContainerColor = Color(0xFFFFE992);
  var bankContainerColor = Color(0xFF6EFFC0);
  var paypalContainerColor = Color(0xFFEFF4FD);

  FirbaseDataUpdationServices firbaseDataUpdationServices =
      FirbaseDataUpdationServices();
  var currentUser = FirebaseAuth.instance.currentUser;
  FirebaseGetUserData firebaseGetUserData = FirebaseGetUserData();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var size = (height + width) / 8;
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<UserData>(
            stream:
                firebaseGetUserData.streamUserData(email: currentUser.email),
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
                    padding: EdgeInsets.only(top: height * 6 / 100),
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
                            'Withdraw your Money',
                            style: TextStyle(
                                color: Color(0xFF1c5162),
                                fontSize: size * 11 / 100,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ),
                  titleShop(height, width, size, title: 'Current Amount'),
                  Text(
                    '\$${snapshot.data.money}.0',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF708187).withOpacity(0.2),
                        fontSize: size * 50 / 100,
                        fontWeight: FontWeight.w700),
                  ),
                  titleShop(height, width, size, title: 'Get Payment'),
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 2 / 100),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: Container()),
                            InkWell(
                              onTap: () {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.info,
                                  title: "Sorry!",
                                  text:
                                      "You don't have enough money. Come back later.",
                                );
                              },
                              child: buildContainer(
                                height,
                                width,
                                size,
                                imageAdress: 'images/wbank.png',
                                name: 'Bank',
                                color: bankContainerColor.withOpacity(0.2),
                              ),
                            ),
                            Expanded(child: Container()),
                            InkWell(
                              onTap: () {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.info,
                                  title: "Sorry!",
                                  text:
                                      "You don't have enough money. Come back later.",
                                );
                              },
                              child: buildContainer(height, width, size,
                                  imageAdress: 'images/wpaypal.png',
                                  name: 'Paypal',
                                  color: paypalContainerColor
                                  // bankContainerColor.withOpacity(0.2),
                                  ),
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                        SizedBox(
                          height: height * 2 / 100,
                        ),
                        Row(
                          children: [
                            Expanded(child: Container()),
                            InkWell(
                              onTap: () {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.info,
                                  title: "Sorry!",
                                  text:
                                      "You don't have enough money. Come back later.",
                                );
                              },
                              child: buildContainer(
                                height,
                                width,
                                size,
                                imageAdress: 'images/wcredit-card.png',
                                name: 'Credit Card',
                                color: creditContainerColor.withOpacity(0.35),
                              ),
                            ),
                            Expanded(child: Container()),
                            InkWell(
                              onTap: () {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.info,
                                  title: "Sorry!",
                                  text:
                                      "You don't have enough money. Come back later.",
                                );
                              },
                              child: buildContainer(
                                height, width, size,
                                imageAdress: 'images/wmoney.png',
                                name: 'Cash',
                                color: moneyContainerColor.withOpacity(0.3),
                                // paypalContainerColor
                                // bankContainerColor.withOpacity(0.2),
                              ),
                            ),
                            Expanded(child: Container()),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            }));
  }

  Container buildContainer(double height, double width, double size,
      {var color, var imageAdress, var name}) {
    return Container(
      height: height * 27 / 100,
      width: width * 40 / 100,
      decoration: BoxDecoration(
          color: color,
          //bankContainerColor.withOpacity(0.2),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              //  'images/wbank.png',
              imageAdress,
              height: height * 10 / 100,
              width: width * 19 / 100,
            ),
            SizedBox(
              height: height * 4.5 / 100,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height * 3.5 / 100),
              child: Text(
                // 'Bank',
                name,
                style: TextStyle(
                    color: Color(0xFF1c5162).withOpacity(0.8),
                    fontSize: size * 10 / 100,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding titleShop(double height, double width, double size, {var title}) {
    return Padding(
      padding: EdgeInsets.only(left: width * 14 / 100, right: width * 14 / 100),
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
