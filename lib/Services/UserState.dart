import 'package:shared_preferences/shared_preferences.dart';

class UserState {
  getVisitingFlag() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool alreadyVisited = prefs.getBool('alreadyVisited') ?? false;

    return alreadyVisited;
  }

  setVisitingFlag({bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('alreadyVisited', value);
  }
}
