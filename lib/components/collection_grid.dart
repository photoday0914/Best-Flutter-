import 'package:bbb/utils/screen_util.dart';
import 'package:flutter/material.dart';

class CollectionGrid extends StatelessWidget {
  const CollectionGrid(
      {super.key, required this.topText, required this.bottomText});

  final String topText;
  final String bottomText;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    return Container(
      height: media.height / 4,
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil.horizontalScale(1.5),
      ),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/img/card.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(ScreenUtil.verticalScale(5)),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: ScreenUtil.horizontalScale(6),
            ),
            child: Column(
              children: [
                Text(
                  topText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil.verticalScale(2.4),
                    fontWeight: FontWeight.bold,
                    height: 0.8,
                  ),
                ),
                Text(
                  bottomText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil.verticalScale(2.4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
