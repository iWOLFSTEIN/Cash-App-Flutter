import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class FirbaseDataUpdationServices {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  var firestoreInstance = FirebaseFirestore.instance;

  void updateCoins({var currentCoins, var coinsTobeAdded, var totalCoins}) {
    var firebaseUser = FirebaseAuth.instance.currentUser;

    if (coinsTobeAdded >= 0) {
      updateTotalCoins(
          currentCoins: totalCoins, coinsTobeAdded: coinsTobeAdded);
    }
    firestoreInstance
        .collection("users")
        .doc(firebaseUser.email)
        .update({"coins": currentCoins + coinsTobeAdded}).then((_) {
      print("success!");
    });
  }

  void updateTotalCoins({var currentCoins, var coinsTobeAdded}) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance
        .collection("users")
        .doc(firebaseUser.email)
        .update({"totalCoins": currentCoins + coinsTobeAdded}).then((_) {
      print("success!");
    });
  }

  void updateKeys({var currentKeys, var keysTobeAdded}) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance
        .collection("users")
        .doc(firebaseUser.email)
        .update({"keys": currentKeys + keysTobeAdded}).then((_) {
      print("success!");
    });
  }

  void updateMoney({var currentMoney, var moneyTobeAdded}) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance
        .collection("users")
        .doc(firebaseUser.email)
        .update({"money": currentMoney + moneyTobeAdded}).then((_) {
      print("success!");
    });
  }

  void updateWatches({var currentWatches, var watchesTobeAdded}) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance
        .collection("users")
        .doc(firebaseUser.email)
        .update({"watches": currentWatches + watchesTobeAdded}).then((_) {
      print("success!");
    });
  }

  void updateGems({var currentGems, var gemsTobeAdded}) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance
        .collection("users")
        .doc(firebaseUser.email)
        .update({"gems": currentGems + gemsTobeAdded}).then((_) {
      print("success!");
    });
  }

  void updateTimeStampDaily({var time}) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance
        .collection("users")
        .doc(firebaseUser.email)
        .update({"timestampDaily": time}).then((_) {
      print("success!");
    });
  }

  void updateTimeStampWeekly({var time}) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance
        .collection("users")
        .doc(firebaseUser.email)
        .update({"timestampWeekly": time}).then((_) {
      print("success!");
    });
  }

  void updateTimestampVideoAds({var time}) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance
        .collection("users")
        .doc(firebaseUser.email)
        .update({"timestampVideoAds": time}).then((_) {
      print("success!");
    });
  }

  void updateTimestampInterstitialAds({var time}) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance
        .collection("users")
        .doc(firebaseUser.email)
        .update({"timestampInterstitialAds": time}).then((_) {
      print("success!");
    });
  }

  void updateInterstitialAdsCount({var count}) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance
        .collection("users")
        .doc(firebaseUser.email)
        .update({"interstitialAdsCount": count}).then((_) {
      print("success!");
    });
  }

  void updateVideoAdsCount({var count}) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance
        .collection("users")
        .doc(firebaseUser.email)
        .update({"videoAdsCount": count}).then((_) {
      print("success!");
    });
  }
}
