import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class Offline extends StatelessWidget {
  const Offline({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
            ),
            Image(
              height: MediaQuery.of(context).size.height * .5,
              width: MediaQuery.of(context).size.width * .8,
              image: Svg('assets/images/offline.svg'),
            ),
            Text(
              'No Connection',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
