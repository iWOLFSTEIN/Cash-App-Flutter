import 'package:flutter/material.dart';

class ItemDescriptionScreen extends StatefulWidget {
  ItemDescriptionScreen({Key key}) : super(key: key);

  @override
  _ItemDescriptionScreenState createState() => _ItemDescriptionScreenState();
}

class _ItemDescriptionScreenState extends State<ItemDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var size = (height + width) / 8;

    return Scaffold(
      backgroundColor: Color(0xFFEEF4F6),
      appBar: AppBar(
        backgroundColor: Color(0xFFEEF4F6),
        title: Text(
          'Items Description',
          style: TextStyle(
            color: Color(0xFF1c5162),
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF1c5162),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 6 / 100,
        ),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 3 / 100),
              child: descriptiveItem(
                size,
                height,
                width,
                name: 'Coins',
                itemAdress: 'images/dollar.png',
                description:
                    'Coins can be earned by watching video ads and clicking on the promotion ads. Free coins can also be earned by free daily rewards and free weekly rewards. Coins are used to spin wheels, to buy keys for opening crates and to buy gems.',
              ),
            ),
            SizedBox(
              height: height * 3 / 100,
            ),
            descriptiveItem(
              size,
              height,
              width,
              name: 'Keys',
              itemAdress: 'images/key.png',
              description:
                  'Keys are usually earned by spinning the wheel and they also can be bought from shop with coins. Keys are used to open the crates, which can futher provide keys and ohter items.',
            ),
            SizedBox(
              height: height * 3 / 100,
            ),
            descriptiveItem(
              size,
              height,
              width,
              name: 'Watches',
              itemAdress: 'images/pocket-watch.png',
              description:
                  "Watches can't be bought, they only come out of crates and spinning wheel. Watches are used to buy coins in shop section.",
            ),
            SizedBox(
              height: height * 3 / 100,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height * 3 / 100),
              child: descriptiveItem(
                size,
                height,
                width,
                name: 'Gems',
                itemAdress: 'images/diamond.png',
                description:
                    "Diamonds can be bought by coins in the shop and can be obtained from cartes and spinning wheel. They are used to redeem cash prizes.",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column descriptiveItem(double size, double height, double width,
      {var name, var itemAdress, var description}) {
    return Column(
      children: [
        Text(
          // 'Coins',
          name,
          style: TextStyle(
              color: Color(0xFF1c5162).withOpacity(0.6),
              fontSize: size * 15 / 100,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: height * 1 / 100,
        ),
        Image.asset(
          // 'images/dollar.png',
          itemAdress,
          width: width * 45 / 100,
          height: height * 25 / 100,
        ),
        SizedBox(
          height: height * 2 / 100,
        ),
        Text(
          //  'Coins can be earned by watching video ads and clicking on the promotion ads. Free coins can also be earned by free daily rewards and free weekly rewards. Coins are used to spin wheels, to buy keys for opening crates and to buy gems.',
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xFF708187).withOpacity(0.4),
              fontSize: size * 11 / 100,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
