import 'package:bbb/components/tools_page_button.dart';
import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:bbb/values/clip_path.dart';
import 'package:flutter/material.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage({super.key});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
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
                          height: media.height / 4.5,
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
                          height: media.height / 4.5,
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
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Tools',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil.verticalScale(2.5),
                                ),
                              ),
                              SizedBox(
                                width: media.width / 5,
                              ),
                              // Row(
                              //   children: [
                              //     Container(
                              //       width: ScreenUtil.horizontalScale(9),
                              //       height: ScreenUtil.horizontalScale(9),
                              //       decoration: const BoxDecoration(
                              //         color: Colors.transparent,
                              //         shape: BoxShape.circle,
                              //       ),
                              //       child: Center(
                              //         child: IconButton(
                              //           padding: EdgeInsets.zero,
                              //           onPressed: () => {
                              //             Navigator.pushNamed(
                              //               context,
                              //               '/calendar',
                              //             )
                              //           },
                              //           icon: Icon(
                              //             Icons.calendar_month,
                              //             size:
                              //             ScreenUtil.verticalScale(3),
                              //             color: Colors.white,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     Container(
                              //       alignment: Alignment.center,
                              //       height: ScreenUtil.verticalScale(3),
                              //       width: ScreenUtil.verticalScale(3),
                              //       decoration: BoxDecoration(
                              //         color: Colors.black12,
                              //         borderRadius: BorderRadius.all(
                              //           Radius.circular(
                              //               ScreenUtil.verticalScale(2)),
                              //         ),
                              //         border: Border.all(color: Colors.white),
                              //       ),
                              //       child: const Text(
                              //         '0',
                              //         style: TextStyle(color: Colors.white),
                              //       ),
                              //     ),
                              //     GestureDetector(
                              //       onTap: () {
                              //         Navigator.pushNamed(
                              //             context, '/streak');
                              //       },
                              //       child: Icon(
                              //         Icons
                              //             .local_fire_department_outlined,
                              //         color: Colors.white,
                              //         size: ScreenUtil.verticalScale(3),
                              //       ),
                              //     ),
                              //     const SizedBox(
                              //       width: 10,
                              //     ),
                              //     Icon(
                              //       Icons.notifications_none,
                              //       color: Colors.white,
                              //       size: ScreenUtil.verticalScale(3),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(
                                width: 20,
                              )
                            ],
                          )),
                        ),
                        SizedBox(
                          height: media.height / 7.9,
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
                    top: media.height / 8,
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
                          width: media.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(55),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil.horizontalScale(5),
                              vertical: ScreenUtil.verticalScale(2),
                            ),
                            child: Column(
                              children: [
                                const ToolsPageButton(
                                  title: 'Exercise Library',
                                  url: '/exerciseLibrary',
                                ),
                                SizedBox(
                                  height: ScreenUtil.verticalScale(1.3),
                                ),
                                const ToolsPageButton(
                                  title: 'Graphs & Reports',
                                  url: '/graphAndReports',
                                ),
                                SizedBox(
                                  height: ScreenUtil.verticalScale(1.3),
                                ),
                                const ToolsPageButton(
                                  title: 'Nutrition Calculator',
                                  url: '/nutritionCalculator',
                                ),
                                SizedBox(
                                  height: ScreenUtil.verticalScale(1.3),
                                ),
                                const ToolsPageButton(
                                  title: 'Apparel & Equipment',
                                  url: '',
                                ),
                                SizedBox(
                                  height: ScreenUtil.verticalScale(1.3),
                                ),
                                const ToolsPageButton(
                                  title: 'Bonuses',
                                  url: '',
                                ),
                                SizedBox(
                                  height: ScreenUtil.verticalScale(1.3),
                                ),
                              ],
                            ),
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
}
