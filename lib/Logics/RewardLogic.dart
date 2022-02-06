import 'package:reward_app/Services/FirebaseDataUpdationServices.dart';

class RewardsLogic {
  getReward(
    String data, {
    var currentCoins,
    var currentKeys,
    var currentWatches,
    var currentGems,
    var totalCoins,
  }) {
    var firebaseDataUpdationServices = FirbaseDataUpdationServices();
    var length = data.length;
    var rewardType = data[length - 1];

    var rewardAmount = int.parse(data.substring(0, length - 1));

    if (rewardType == 'c') {
      firebaseDataUpdationServices.updateCoins(
          currentCoins: currentCoins,
          coinsTobeAdded: rewardAmount,
          totalCoins: totalCoins);
      return getRewardType(rewardType);
    } else if (rewardType == 'k') {
      firebaseDataUpdationServices.updateKeys(
        currentKeys: currentKeys,
        keysTobeAdded: rewardAmount,
      );
      return getRewardType(rewardType);
    } else if (rewardType == 'w') {
      firebaseDataUpdationServices.updateWatches(
          currentWatches: currentWatches, watchesTobeAdded: rewardAmount);
      return getRewardType(rewardType);
    } else if (rewardType == 'g') {
      firebaseDataUpdationServices.updateGems(
          currentGems: currentGems, gemsTobeAdded: rewardAmount);
      return getRewardType(rewardType);
    }
  }

  getRewardType(var rewardType) {
    if (rewardType == 'c') {
      return 'coins';
    } else if (rewardType == 'k') {
      return 'keys';
    } else if (rewardType == 'w') {
      return 'watches';
    } else if (rewardType == 'g') {
      return 'gems';
    }
  }
}
