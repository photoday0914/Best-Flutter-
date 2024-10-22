import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:flutter/material.dart';

class AthletesListWidget extends StatelessWidget {
  const AthletesListWidget(
      {super.key, required this.height, required this.width});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil.horizontalScale(2.5),
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
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil.verticalScale(4)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Athlete',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil.verticalScale(1.8),
              ),
            ),
            Text(
              'Spotlight',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil.verticalScale(1.8),
              ),
            ),
            Text(
              'Erica Stone',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil.verticalScale(2.5),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Miami FL',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil.verticalScale(2.5),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil.horizontalScale(6),
                  vertical: ScreenUtil.verticalScale(1.5),
                ),
              ),
              child: Text(
                "Read more",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil.verticalScale(1.5),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
