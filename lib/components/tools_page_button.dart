import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:flutter/material.dart';

class ToolsPageButton extends StatelessWidget {
  const ToolsPageButton({super.key, required this.title, required this.url});

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    void onPress() {
      Navigator.pushNamed(context, url);
    }

    return SizedBox(
      width: media.width,
      child: InkWell(
        onTap: onPress,
        child: Container(
          padding: EdgeInsets.only(
            top: ScreenUtil.horizontalScale(7),
            left: ScreenUtil.horizontalScale(8),
            right: ScreenUtil.horizontalScale(8),
            bottom: ScreenUtil.horizontalScale(18),
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(35),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
