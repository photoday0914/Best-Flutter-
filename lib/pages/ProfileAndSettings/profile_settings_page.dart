import 'dart:io';

import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:bbb/values/clip_path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../providers/user_data_provider.dart';
import '../WatchTutorial/watch_tutorial.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  String? _imageUrl;
  UserDataProvider? userData;

  @override
  void didChangeDependencies() {
    userData = Provider.of<UserDataProvider>(
      this.context,
      listen: false,
    );
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickAndUploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Upload to Firebase Storage
      File file = File(image.path);
      String fileName = basename(image.path);

      try {
        Reference storageRef =
            FirebaseStorage.instance.ref().child('profile_images/$fileName');
        await storageRef.putFile(file);
        String downloadUrl = await storageRef.getDownloadURL();

        // Update the state with the image URL
        setState(() {
          _imageUrl = downloadUrl;
        });
      } catch (e) {
        print("Error uploading image: $e");
      }
    }
  }

  void _handleLogout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    // Add your logout logic here
    Navigator.pushNamed(context, '/login');
    print("Log out button clicked");
  }

  openUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  toSupportPage() async {
    openUrl('bootybybret.com/pages/contact-us');
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: media.height / 1.5,
                          width: media.width,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/img/pp_4.png'),
                              fit: BoxFit.cover,
                              opacity: 1,
                            ),
                          ),
                        ),
                        Container(
                          height: media.height / 1.5,
                          width: media.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primaryColor.withOpacity(0.7),
                                AppColors.primaryColor.withOpacity(0.7),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: SafeArea(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil.horizontalScale(3),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(
                                          ScreenUtil.verticalScale(3),
                                        ),
                                        // decoration: const BoxDecoration(
                                        //   color: Color(0XFFd18a9b),
                                        //   shape: BoxShape.circle,
                                        // ),
                                        // child: IconButton(
                                        //   icon: const Icon(
                                        //       Icons.keyboard_arrow_left,
                                        //       color: Colors.white),
                                        //   onPressed: () {},
                                        //   iconSize: ScreenUtil.verticalScale(4),
                                        // ),
                                      ),
                                      // Row(
                                      //   children: [
                                      //     Container(
                                      //       alignment: Alignment.center,
                                      //       padding: EdgeInsets.all(
                                      //         ScreenUtil.verticalScale(0.6),
                                      //       ),
                                      //       decoration: BoxDecoration(
                                      //         shape: BoxShape.circle,
                                      //         color:
                                      //             Colors.white.withOpacity(0.2),
                                      //         border: Border.all(
                                      //             color: Colors.white),
                                      //       ),
                                      //       child: Text(
                                      //         '0',
                                      //         style: TextStyle(
                                      //           color: Colors.white,
                                      //           fontSize:
                                      //               ScreenUtil.verticalScale(
                                      //             1.5,
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     Navigator.pushNamed(
                                      //         context, '/streak');
                                      //   },
                                      //   child: Icon(
                                      //     Icons
                                      //         .local_fire_department_outlined,
                                      //     color: Colors.white,
                                      //     size: ScreenUtil.verticalScale(3),
                                      //   ),
                                      // ),
                                      // IconButton(
                                      //   onPressed: () {},
                                      //   icon: Icon(
                                      //     Icons.notifications_none,
                                      //     color: Colors.white,
                                      //     size: ScreenUtil.verticalScale(3),
                                      //   ),
                                      // ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _pickAndUploadImage,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal:
                                          ScreenUtil.horizontalScale(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height:
                                              ScreenUtil.horizontalScale(25),
                                          width: ScreenUtil.horizontalScale(25),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                ScreenUtil.horizontalScale(
                                                    12.5),
                                              ),
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              ScreenUtil.horizontalScale(12.5),
                                            ),
                                            child: _imageUrl == null
                                                ? Image.asset(
                                                    'assets/img/profile.png',
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.network(
                                                    _imageUrl!,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil.horizontalScale(5),
                                        ),
                                        Consumer<UserDataProvider>(
                                          builder: (context, userData, child) =>
                                              userData.userName != ""
                                                  ? Text(
                                                      // 'Hi, Nick',
                                                      'Hi, ${userData.userName}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: ScreenUtil
                                                            .horizontalScale(8),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        height: 1,
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil.horizontalScale(2),
                                        ),
                                        Text(
                                          "Here's your profile",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                ScreenUtil.horizontalScale(5.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: media.height / 2.64,
                          width: media.width,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: ClipPath(
                              clipper: DiagonalClipper(),
                              child: Container(
                                height: media.height / 11,
                                width: media.width / 6,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: media.height / 2.65,
                    bottom: ScreenUtil.verticalScale(15),
                  ),
                  child: Container(
                    width: media.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(ScreenUtil.verticalScale(6)),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil.horizontalScale(6),
                            vertical: ScreenUtil.verticalScale(3),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: ScreenUtil.verticalScale(2),
                              ),
                              settingsButton(
                                'Re-watch the tutorial',
                                Icons.play_circle_outline,
                                () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const WatchTutorial(
                                        vimeoId: '953289606'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil.horizontalScale(4.5),
                              ),
                              settingsButton(
                                  'My Profile',
                                  Icons.person,
                                  () => Navigator.pushNamed(
                                      context, '/myprofile')),
                              SizedBox(
                                height: ScreenUtil.horizontalScale(4.5),
                              ),
                              settingsButton(
                                  'Settings', Icons.settings, () => {}),
                              SizedBox(
                                height: ScreenUtil.horizontalScale(4.5),
                              ),
                              settingsButton('Subscription', Icons.refresh,
                                  () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                String? token = prefs.getString('authToken');

                                Uri url = Uri.parse('https://bbbdev1.wpenginepowered.com/?token=$token');

                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                              SizedBox(
                                height: ScreenUtil.horizontalScale(4.5),
                              ),
                              settingsButton('Language',
                                  Icons.chat_bubble_outline, () => {}),
                              SizedBox(
                                height: ScreenUtil.horizontalScale(4.5),
                              ),
                              settingsButton('Support', Icons.handshake,
                                  () => {toSupportPage()}),
                              SizedBox(
                                height: ScreenUtil.horizontalScale(4.5),
                              ),
                              SizedBox(
                                height: ScreenUtil.horizontalScale(4.5),
                              ),
                              settingsButton(
                                  'Legal', Icons.description, () => {}),
                              SizedBox(
                                height: ScreenUtil.horizontalScale(4.5),
                              ),
                              settingsButton('Log Out', Icons.logout,
                                  () => {_handleLogout(context)}),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget settingsButton(String title, IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil.horizontalScale(5),
          vertical: ScreenUtil.verticalScale(2),
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.all(
            Radius.circular(
              ScreenUtil.verticalScale(7),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.primaryColor,
                  size: ScreenUtil.verticalScale(4),
                ),
                SizedBox(
                  width: ScreenUtil.verticalScale(3),
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: ScreenUtil.horizontalScale(4.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(ScreenUtil.verticalScale(0.3)),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
                size: ScreenUtil.verticalScale(3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
