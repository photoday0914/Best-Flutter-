import 'package:flutter/material.dart';
import 'package:bbb/components/button_widget.dart';
import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';

class JoinChallengeWidget extends StatelessWidget {
  const JoinChallengeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    ScreenUtil.init(context);

    return Column(
      children: [
        Container(
          height: media.height / 1.8,
          width: media.width,
          color: Colors.white, // Set the outside background color to white
          child: Stack(
            children: [
              // Top white section
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: media.height / 8, // Adjust height of white top section
                child: Container(
                  color: Colors.white,
                ),
              ),
              // Bottom white section
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: media.height / 8, // Adjust height of white bottom section
                child: Container(
                  color: Colors.white,
                ),
              ),
              // Middle image section with clip path
              Positioned.fill(
                child: ClipPath(
                  clipper: MiddleClipper(),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/card.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              // Centered content over the image
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '2024',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil.verticalScale(2.5),
                      ),
                    ),
                    Text(
                      'June',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil.verticalScale(4),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Challenge',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil.verticalScale(4),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: ScreenUtil.verticalScale(2),
                        horizontal: ScreenUtil.horizontalScale(18),
                      ),
                      child: ButtonWidget(
                        text: 'Join the Challenge',
                        textColor: Colors.white,
                        color: AppColors.primaryColor,
                        onPress: () {},
                        isLoading: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MiddleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, size.height * 0.2);

    path.quadraticBezierTo(
      size.width * 0.05, size.height * 0.1, // Control point
      size.width * 0.15, size.height * 0.1,  // End point
    );

    path.lineTo(size.width * 0.85, size.height * 0.1);

    path.quadraticBezierTo(
      size.width * 0.95, size.height * 0.1,  // Control point
      size.width, size.height * 0,           // End point
    );

    path.lineTo(size.width, size.height * 0.8);

    path.quadraticBezierTo(
      size.width * 0.95, size.height * 0.9,  // Control point
      size.width * 0.85, size.height * 0.9,   // End point
    );

    path.lineTo(size.width * 0.15, size.height * 0.9);

    path.quadraticBezierTo(
      size.width * 0.05, size.height * 0.9,  // Control point
      0, size.height * 1,                   // End point
    );

    path.lineTo(0, size.height * 0.2);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
