import 'package:bbb/components/button_widget.dart';
import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:flutter/material.dart';
// import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
import 'package:flutter/material.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

class VideoIntroWidget extends StatefulWidget {
  final String vimeoId;

  const VideoIntroWidget({super.key, required this.vimeoId});

  @override
  _VideoIntroWidgetState createState() => _VideoIntroWidgetState();
}

class _VideoIntroWidgetState extends State<VideoIntroWidget> {
  // VimeoPlayer? vimeoVideoPlayer;
  VimeoVideoPlayer? vimeoVideoPlayer;

  @override
  void initState() {
    vimeoVideoPlayer = VimeoVideoPlayer(url: 'https://player.vimeo.com/video/${widget.vimeoId}', autoPlay: false,);
    print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ${widget.vimeoId}");
    // debugPrint('https://vimeo.com/${widget.vimeoId}');
    // vimeoVideoPlayer = VimeoPlayer(videoId: widget.vimeoId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtil.verticalScale(5),
            ),
            Row(
             children: [
               SizedBox(
                 width: ScreenUtil.horizontalScale(85),
               ),
               Container(
                 width: ScreenUtil.horizontalScale(10),
                 height: ScreenUtil.horizontalScale(10),
                 decoration: const BoxDecoration(
                   color: Color(0XFFBBBBBB),
                   shape: BoxShape.circle,
                 ),
                 child: IconButton(
                   icon: const Icon(Icons.close,
                       color: Colors.white),
                   onPressed: () {
                     Navigator.pop(context);
                   },
                   iconSize: ScreenUtil.horizontalScale(5),
                 ),
               ),
             ],
            ),
            SizedBox(
              height: ScreenUtil.verticalScale(10),
            ),
            SizedBox(
              height: ScreenUtil.verticalScale(60),
              width: ScreenUtil.horizontalScale(80),
              child: vimeoVideoPlayer,
            ),
            SizedBox(
              height: ScreenUtil.verticalScale(6.5)
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil.horizontalScale(10),
              ),
              child: ButtonWidget(
                text: "Continue Working Out",
                textColor: Colors.white,
                onPress: () {
                  // Navigator.pushNamed(context, '/dayOverview');
                  Navigator.pop(context);
                },
                color: AppColors.primaryColor,
                isLoading: false,
              ),
            ),
            SizedBox(
              height: ScreenUtil.verticalScale(5),
            ),
          ],
        ),
      ),
    );
  }
}
