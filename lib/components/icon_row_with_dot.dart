import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:flutter/material.dart';

class IconRowWithDot extends StatelessWidget {
  const IconRowWithDot({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenUtil.verticalScale(4)),
      child: IconRow(
        icons: [
          IconDataWithDot(
            icon: Icons.check,
            iconColor: Colors.white,
            backgroundColor: Colors.blue,
            showDot: true,
            dotColor: Colors.transparent,
          ),
          IconDataWithDot(
            icon: Icons.check,
            iconColor: Colors.white,
            backgroundColor: AppColors.primaryColor,
            showDot: true,
            dotColor: AppColors.primaryColor,
          ),
          IconDataWithDot(
            icon: Icons.close,
            iconColor: Colors.white,
            backgroundColor: Colors.red,
            showDot: true,
            dotColor: Colors.transparent,
          ),
          IconDataWithDot(
            icon: null,
            iconColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            borderColor: Colors.red[700],
            showDot: true,
            dotColor: AppColors.primaryColor,
          ),
          IconDataWithDot(
            icon: null,
            iconColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            borderColor: Colors.red[700],
            showDot: true,
            dotColor: Colors.transparent,
          ),
          IconDataWithDot(
            icon: null,
            iconColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            borderColor: Colors.red[700],
            showDot: true,
            dotColor: AppColors.primaryColor,
          ),
          IconDataWithDot(
            icon: null,
            iconColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            borderColor: Colors.red[700],
            showDot: true,
            dotColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}

class IconRow extends StatelessWidget {
  final List<IconDataWithDot> icons;

  const IconRow({super.key, required this.icons});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: icons
          .map(
            (iconData) => IconWithDot(iconData: iconData),
          )
          .toList(),
    );
  }
}

class IconDataWithDot {
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool showDot;
  final Color? dotColor;

  IconDataWithDot({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.dotColor,
    this.borderColor,
    this.showDot = false,
  });
}

class IconWithDot extends StatelessWidget {
  final IconDataWithDot iconData;

  const IconWithDot({super.key, required this.iconData});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(ScreenUtil.horizontalScale(
            1,
          )),
          decoration: BoxDecoration(
            color: iconData.backgroundColor,
            shape: BoxShape.circle,
            border: iconData.borderColor != null
                ? Border.all(color: iconData.borderColor!)
                : null,
          ),
          child: iconData.icon != null
              ? Icon(
                  iconData.icon,
                  color: iconData.iconColor,
                  size: ScreenUtil.verticalScale(
                    3,
                  ),
                )
              : Icon(
                  null,
                  size: ScreenUtil.verticalScale(
                    3,
                  ),
                ),
        ),
        if (iconData.showDot)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Icon(
              Icons.circle,
              size: ScreenUtil.verticalScale(
                0.7,
              ),
              color: iconData.dotColor ?? Colors.red[700],
            ),
          ),
      ],
    );
  }
}
