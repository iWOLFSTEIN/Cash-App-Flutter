import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reward_app/Services/DatabaseServices.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({
    Key key,
    @required this.height,
    @required this.width,
    @required this.size,
  }) : super(key: key);

  final double height;
  final double width;
  final double size;

  var firestore = FirebaseFirestore.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  DatabaseServices databaseServices = new DatabaseServices();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection('usersHistory')
            .doc(currentUser.email)
            .collection('history')
            .snapshots(),
        builder: (context, snapshot) {
          if (!(snapshot.hasData)) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var messages = snapshot.data.docs;
          List<ClickableIconTile> historyWidget = [];
          for (var message in messages) {
            final historyMessage =
                //'user';
                message.data()['historyMessage'];
            final timestamp = message.data()['timestamp'];

            historyWidget.add(ClickableIconTile(
                height: height,
                width: width,
                size: size,
                rewardContainerNames: historyMessage,
                rewardContainerComments: timestamp.toDate().toString()));
          }

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xFF29bae9),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                try {
                  var messages = snapshot.data.docs;
                  for (var message in messages) {
                    message.reference.delete();
                  }
                  databaseServices.userHistoryData(
                      historyMessage: 'All the history deleted',
                      timestamp: DateTime.now());
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.success,
                    title: "Operation Successful!",
                    text: "All the history is deleted successfully.",
                  );
                } catch (e) {
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.error,
                    title: "Sorry!",
                    text: "An error occured.",
                  );
                }
              },
            ),
            body: Container(
              color: Color(0xFFEEF4F6),
              child: ListView(
                children: historyWidget,
              ),
            ),
          );
        });
  }
}

class ClickableIconTile extends StatelessWidget {
  const ClickableIconTile({
    Key key,
    @required this.height,
    @required this.width,
    @required this.size,
    // @required this.rewardContainerIcons,
    @required this.rewardContainerNames,
    @required this.rewardContainerComments,
  }) : super(key: key);

  final double height;
  final double width;
  final double size;
  // final String rewardContainerIcons;
  final String rewardContainerNames;
  final String rewardContainerComments;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: height * 2 / 100, left: width * 5 / 100, right: width * 5 / 100),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: height * 1 / 100,
          horizontal: width * 1 / 100,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ListTile(
          leading: CircleAvatar(
            radius: size * 14 / 100,
            backgroundColor: Color(0xFFecf9fe),
            backgroundImage: AssetImage('images/history.png'),
          ),
          title: Padding(
            padding: EdgeInsets.only(bottom: height * 1 / 100),
            child: Text(
              rewardContainerNames,
              style: TextStyle(
                  color: Color(0xFF1c5162),
                  fontSize: size * 13 / 100,
                  fontWeight: FontWeight.w600),
            ),
          ),
          subtitle: Text(
            rewardContainerComments,
            style: TextStyle(
                color: Color(0xFF708187).withOpacity(0.4),
                fontSize: size * 10 / 100,
                fontWeight: FontWeight.w600),
          ),
          trailing: InkWell(
            onTap: () {},
            child: CircleAvatar(
              radius: size * 7 / 100,
              backgroundImage: AssetImage('images/clock.png'),
            ),
          ),
        ),
      ),
    );
  }
}
