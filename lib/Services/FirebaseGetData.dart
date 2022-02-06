import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class UserData {
  final int totalCoins;
  final int money;
  final int coins;
  final int keys;
  final int watches;
  final int gems;
  final timestampDaily;
  final timestampWeekly;
  final interstitialAdsCount;
  final videoAdsCount;
  final timestampInterstitialAds;
  final timestampVideoAds;

  UserData(
      {this.totalCoins,
      this.money,
      this.timestampInterstitialAds,
      this.timestampVideoAds,
      this.coins,
      this.timestampDaily,
      this.timestampWeekly,
      this.keys,
      this.watches,
      this.interstitialAdsCount,
      this.videoAdsCount,
      this.gems});

  factory UserData.fromMap(Map data) {
    return UserData(
      totalCoins: (data['totalCoins'] == null) ? 0 : data['totalCoins'],
      money: (data['money'] == null) ? 0 : data['money'],
      coins: (data['coins'] == null) ? 0 : data['coins'],
      keys: (data['keys'] == null) ? 0 : data['keys'],
      watches: (data['watches'] == null) ? 0 : data['watches'],
      gems: (data['gems'] == null) ? 0 : data['gems'],
      timestampDaily: data['timestampDaily'] ?? DateTime.now(),
      timestampWeekly: data['timestampWeekly'] ?? DateTime.now(),
      interstitialAdsCount: data['interstitialAdsCount'] ?? 0,
      videoAdsCount: data['videoAdsCount'] ?? 0,
      timestampInterstitialAds:
          data['timestampInterstitialAds'] ?? DateTime.now(),
      timestampVideoAds: data['timestampVideoAds'] ?? DateTime.now(),
    );
  }
}

class FirebaseGetUserData {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  var firestoreInstance = FirebaseFirestore.instance;

  Stream<UserData> streamUserData({String email}) {
    return firestoreInstance
        .collection('users')
        .doc(email)
        .snapshots()
        .map((event) => UserData.fromMap(event.data()));
  }
}
