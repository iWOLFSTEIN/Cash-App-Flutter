import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reward_app/Screens/HomeScreen.dart';
import 'package:reward_app/Screens/IntroScreen.dart';
import 'package:reward_app/Services/UserState.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var currentUser = FirebaseAuth.instance.currentUser;
  UserState userState = UserState();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
            value: FirebaseAuth.instance.authStateChanges()),
      ],
      child: Container(
        color: Colors.white,
        child: FutureBuilder(
            future: userState.getVisitingFlag(),
            builder: (context, snapshot) {
              if (!(snapshot.hasData)) {
                return Center(child: CircularProgressIndicator());
              }
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home: (snapshot.data) ? HomeScreen() : IntroScreen(),
              );
            }),
      ),
    );
  }
}
