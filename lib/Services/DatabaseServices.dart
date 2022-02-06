import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance.currentUser;

  createUser({var email}) async {
    await _firestore.collection('users').doc(email).set({
      'interstitialAdsCount': 0,
      'videoAdsCount': 0,
      'timestampWeekly': DateTime.now(),
      'timestampDaily': DateTime.now(),
      'timestampInterstitialAds': DateTime.now(),
      'timestampVideoAds': DateTime.now(),
      'totalCoins': 100,
      'money': 0,
      'coins': 100,
      'keys': 0,
      'watches': 0,
      'gems': 10
    });
    // userHistoryData(
    //     historyMessage: 'New user signed up', timestamp: DateTime.now());
  }

  userHistoryData({var historyMessage, var timestamp}) async {
    await _firestore
        .collection('usersHistory')
        .doc(_auth.email)
        .collection('history')
        .add({
      'historyMessage': historyMessage,
      'timestamp': timestamp,
    });
  }
}
