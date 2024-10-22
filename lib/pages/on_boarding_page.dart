import 'package:bbb/components/button_widget.dart';
import 'package:bbb/pages/login_page.dart';
import 'package:bbb/pages/register_page.dart';
import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:bbb/values/clip_path.dart';
import 'package:bbb/values/slider_content.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this for shared preferences
import 'package:bbb/pages/main_page.dart';
import 'package:url_launcher/url_launcher.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentIndex = 0;
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();

    _videoController = VideoPlayerController.asset('assets/videos/welcome.mp4')
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
          _videoController.setLooping(true);
          _videoController.play();
        });
      });
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    var media = MediaQuery.of(context).size;

    void onPressCreateAccount() async {
      final Uri url =
          Uri.parse('https://bbbdev1.wpenginepowered.com/shop');

      try {
        if (await canLaunchUrl(url)) {
          await launchUrl(
            url,
            mode: LaunchMode
                .externalApplication, // Ensures the URL opens in a browser
          );
        } else {
          print(
              'Cannot launch the URL, not supported or no suitable app found.');
        }
      } catch (e) {
        print('Error launching URL: $e');
      }
    }

    void onPressLogin() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          if (_isVideoInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoController.value.size.width,
                  height: _videoController.value.size.height,
                  child: VideoPlayer(_videoController),
                ),
              ),
            )
          else
            const Center(child: CircularProgressIndicator()),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          Stack(
            children: [
              Stack(
                children: [
                  Container(
                    width: media.width,
                    height: media.height / 1.587,
                    decoration: const BoxDecoration(
                        // color: Colors.black54,
                        // borderRadius: BorderRadius.only(
                        //   bottomRight: Radius.circular(50),
                        // ),
                        ),
                    child: Stack(
                      children: [
                        SafeArea(
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil.horizontalScale(10)),
                                child: PageView.builder(
                                  itemCount: sliderContents.length,
                                  onPageChanged: (index) {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                  },
                                  itemBuilder: (_, i) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: media.height / 10,
                                          width: media.width / 3,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/img/logo1.png'),
                                              fit: BoxFit.fitWidth,
                                              opacity: 1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: ScreenUtil.verticalScale(4)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      sliderContents.length,
                                      (index) => buildDot(index),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ClipPath(
                            clipper: DiagonalClipper(),
                            child: Container(
                              height: 70,
                              width: 60,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: media.height / 4,
                  width: media.width,
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: media.height / 2.69,
                  width: media.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ScreenUtil.verticalScale(8)),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil.verticalScale(4.4),
                        vertical: ScreenUtil.verticalScale(0.7)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: ScreenUtil.horizontalScale(10.3),
                        ),
                        const Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil.horizontalScale(2.2),
                        ),
                        const Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Color(0xff6f6f6f),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil.horizontalScale(4.5),
                        ),
                        ButtonWidget(
                          text: 'Sign in',
                          textColor: Colors.white,
                          color: AppColors.primaryColor,
                          onPress: onPressLogin,
                          isLoading: false,
                        ),
                        SizedBox(
                          height: ScreenUtil.horizontalScale(1.2),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't you have an account?",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff888888),
                              ),
                            ),
                            TextButton(
                              onPressed: onPressCreateAccount,
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Container buildDot(int index) {
    return Container(
      height: ScreenUtil.horizontalScale(2.3),
      width: ScreenUtil.horizontalScale(2.3),
      margin: EdgeInsets.only(right: ScreenUtil.horizontalScale(3.6)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? AppColors.primaryColor : Colors.white,
      ),
    );
  }
}
