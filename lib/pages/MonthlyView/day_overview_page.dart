import 'package:bbb/components/button_widget.dart';
import 'package:bbb/components/select_dropdown.dart';
import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:bbb/values/clip_path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bbb/models/day.dart';
import 'package:bbb/models/week.dart';
import 'package:bbb/providers/data_provider.dart';
import 'package:bbb/providers/user_data_provider.dart';
import 'package:bbb/routes/fade_page_route.dart';
import 'package:bbb/pages/video_intro_page.dart';

import '../../values/app_constants.dart';

class DayOverviewPage extends StatefulWidget {
  const DayOverviewPage({super.key});

  @override
  State<DayOverviewPage> createState() => _DayOverviewPageState();
}

class _DayOverviewPageState extends State<DayOverviewPage> {
  final today = DateTime.now();
  DataProvider? dataProvider;
  UserDataProvider? userData;
  int? week;
  int? day;

  bool isToday = true;
  bool isThisWeek = true;
  bool isSkipped = false;
  bool isCompleted = false;

  @override
  void initState() {
    dataProvider = Provider.of<DataProvider>(
      context,
      listen: false,
    );

    userData = Provider.of<UserDataProvider>(
      context,
      listen: false,
    );

    isSkipped = (userData!
        .dayHistory)
        .any((element) =>
        ('${element['monthIndex']} ${element['weekIndex']} ${element['daySplit']} ${element['dayIndex']} ${element['state']}') ==
        ('${userData!.currentMonth} ${userData!.currentWeek} ${userData!.selectedDaySplit} ${userData!.currentDay} ${AppConstants.STATE_SKIPPED}'));

    isCompleted = (userData!
        .dayHistory)
        .any((element) =>
        ('${element['monthIndex']} ${element['weekIndex']} ${element['daySplit']} ${element['dayIndex']} ${element['state']}') ==
        ('${userData!.currentMonth} ${userData!.currentWeek} ${userData!.selectedDaySplit} ${userData!.currentDay} ${AppConstants.STATE_FINISHED}'));

    DateTime startTime = DateTime.parse(dataProvider?.workout?.startDate as String);
    int dayDelta = today.difference(startTime).inDays;
    week = (dayDelta ~/ 7);
    day = dayDelta % 7;

    if (dataProvider!.workout.weeks.length >= userData!.currentWeek) {
      Week firstWeek = dataProvider?.workout?.weeks[userData!.currentWeek - 1] as Week;

      if (firstWeek.days.length > userData!.currentDay) {
        Day dayObj = firstWeek.days[userData!.currentDay - 1] as Day;
        userData?.currentDayObj = dayObj;
      }

      if (firstWeek.restdayId.isNotEmpty) {
        userData?.fetchRestDay(firstWeek.restdayId);
      }
    }

    isToday = ((week! + 1 == userData!.currentWeek) && (day! + 1 == userData!.currentDay));
    isThisWeek = (week! + 1 == userData!.currentWeek);

    super.initState();
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
                          height: media.height / 2.35,
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
                          height: media.height / 1.8,
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
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: ScreenUtil.horizontalScale(4),
                                        ),
                                        decoration: const BoxDecoration(
                                          color: Color(0XFFd18a9b),
                                          shape: BoxShape.circle,
                                        ),
                                        child: SizedBox(
                                          width: ScreenUtil.horizontalScale(
                                              10), // Size of the circle
                                          height:
                                              ScreenUtil.horizontalScale(10),
                                          child: IconButton(
                                            padding: EdgeInsets
                                                .zero, // Removes the default padding
                                            icon: const Icon(
                                              Icons.keyboard_arrow_left,
                                              color: Colors.white,
                                            ),
                                            onPressed: () => Navigator.pop(context),
                                            iconSize: ScreenUtil.verticalScale(
                                                4), // Icon size remains the same
                                          ),
                                        ),
                                      ),
                                        ],
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
                                      //     SizedBox(
                                      //       width: ScreenUtil.horizontalScale(1),
                                      //     ),
                                      //     Container(
                                      //       padding: EdgeInsets.all(
                                      //         ScreenUtil.verticalScale(0.5),
                                      //       ),
                                      //       decoration: BoxDecoration(
                                      //         color: Colors.black12,
                                      //         shape: BoxShape.circle,
                                      //         border: Border.all(
                                      //           color: Colors.white,
                                      //         ),
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
                                      //     IconButton(
                                      //       onPressed: () {},
                                      //       icon: Icon(
                                      //         Icons.notifications_none,
                                      //         color: Colors.white,
                                      //         size: ScreenUtil.verticalScale(3),
                                      //       ),
                                      //     )
                                      //   ],
                                      // )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          ScreenUtil.horizontalScale(7)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Aug, 2024',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil.verticalScale(2.5),
                                        ),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil.verticalScale(1.5),
                                      ),
                                      Consumer<UserDataProvider>(
                                        builder: (context, userData, child) =>
                                        userData?.currentWeek != null ?
                                        Text(
                                          "WEEK ${userData?.currentWeek}, DAY ${userData?.currentDay},",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil.verticalScale(3.7),
                                            fontWeight: FontWeight.bold,
                                            height: 1,
                                          ),
                                        ) : const SizedBox(),
                                      ),
                                      Consumer<UserDataProvider>(
                                        builder: (context, userData, child) =>
                                        userData?.currentRestDay.id != '' ?
                                        Text(
                                          userData!.currentDayObj.formats.contains(userData?.selectedDaySplit)
                                              ? 'Option ${userData!.selectedExerciseFormat}'
                                              : userData?.currentRestDay?.title ?? "Rest Day",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil.verticalScale(4),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ) : const SizedBox(),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: ScreenUtil.verticalScale(1.5)),
                                // SizedBox(height: ScreenUtil.verticalScale(6)),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil.horizontalScale(10),
                                  ),
                                  child: ButtonWidget(
                                    text: !userData!.currentDayObj.formats.contains(userData?.selectedDaySplit) ? "Watch Video" : "Watch Video Intro",
                                    color: const Color(0xEEFFFFFF),
                                    onPress: () {
                                      Navigator.of(context).push(
                                        FadePageRoute(page: const VideoIntroWidget(vimeoId: '953289606')),
                                      );
                                    },
                                    textColor: AppColors.primaryColor,
                                    isLoading: false,
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.symmetric(
                                //     horizontal: ScreenUtil.horizontalScale(6),
                                //   ),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.end,
                                //     children: [
                                //       const SizedBox(
                                //         width: 15,
                                //       ),
                                //       ElevatedButton(
                                //         style: ElevatedButton.styleFrom(
                                //           foregroundColor: Colors.transparent,
                                //           backgroundColor:
                                //               Colors.white.withOpacity(0.2),
                                //           shadowColor: Colors.transparent,
                                //           shape: const CircleBorder(),
                                //           padding: const EdgeInsets.all(0),
                                //         ),
                                //         onPressed: () {},
                                //         child: Ink(
                                //           decoration: BoxDecoration(
                                //             color: Colors.transparent,
                                //             shape: BoxShape.circle,
                                //             border: Border.all(
                                //               color: Colors.white,
                                //               width: 2,
                                //             ),
                                //           ),
                                //           child: Container(
                                //             width: ScreenUtil.verticalScale(7.5),
                                //             height: ScreenUtil.verticalScale(7.5),
                                //             alignment: Alignment.center,
                                //             child: Icon(
                                //               Icons.play_arrow,
                                //               color: Colors.white,
                                //               size: ScreenUtil.verticalScale(6),
                                //             ),
                                //           ),
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),
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
                    bottom: ScreenUtil.verticalScale(2),
                  ),
                  child: Container(
                    width: media.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(ScreenUtil.verticalScale(6)),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: media.height / 19),
                      child: Column(
                        children: [
                          // const IconRowWithDot(),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil.horizontalScale(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Notes',
                                  style: TextStyle(
                                    fontSize: ScreenUtil.verticalScale(3.5),
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                if (userData!.currentDayObj.formats.contains(userData?.selectedDaySplit)) ... [
                                  const BulletPoint(
                                    text: 'Ramp up the load with each set.',
                                  ),
                                  const BulletPoint(
                                    text:
                                    'If you’re unable to do 3 bodyweight reps, use assistance; if 3 reps are too easy, add weight.',
                                  ),
                                  const BulletPoint(
                                    text:
                                    'Aim for 10-15 reps. Elevate your feet to increase the difficulty.',
                                  ),
                                ]
                                else ...[
                                  Consumer<UserDataProvider>(
                                    builder: (context, userData, child) =>
                                      userData?.currentRestDay.id != '' ?
                                      BulletPoint(
                                      text: userData!.currentRestDay.description ?? "",
                                    ) : const SizedBox(),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil.verticalScale(5),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil.horizontalScale(10),
                              vertical: ScreenUtil.verticalScale(2),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if(userData!.currentDayObj.formats.contains(userData?.selectedDaySplit)) ...[
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil.verticalScale(2)),
                                    child: Text(
                                      'Choose equipent availiability',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize:
                                          ScreenUtil.verticalScale(1.5)),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SelectDropdown(
                                    onChange: (String newValue) {
                                      userData?.selectedExerciseFormatAlternate = newValue;
                                      userData?.notifyListeners();
                                    },
                                  ),
                                ]
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ScreenUtil.horizontalScale(10)),
                            child:
                            ButtonWidget(
                              text: (userData!.currentDayObj.formats.contains(userData?.selectedDaySplit))
                                  ? (isThisWeek && !isCompleted && !isSkipped ? "Start the workout" : "View the workout")
                                  : (isThisWeek && !isCompleted && !isSkipped ? "Mark Rest Day Complete" : isCompleted ? "Completed" : "Skipped"),
                              textColor: Colors.white,
                              onPress: (isThisWeek && !isCompleted && !isSkipped || userData!.currentDayObj.formats.contains(userData?.selectedDaySplit)) ? () async {
                                if ((userData!.currentDayObj.formats.contains(userData?.selectedDaySplit))) {
                                  // userData?.updateOrAddDayHistory(AppConstants.STATE_STARTED);
                                  Navigator.pushNamed(context, '/today');
                                }
                                else {
                                  // await userData?.finishCurrentDay();
                                  userData?.updateOrAddDayHistory(AppConstants.STATE_FINISHED);
                                  // Navigator.pushNamed(context, '/home');
                                  Navigator.pushNamed(
                                    context,
                                    '/dayCompleted',
                                    arguments: userData?.currentDay,
                                  );
                                }
                              } : null,
                              color: AppColors.primaryColor,
                              isLoading: false,
                            )
                            // ButtonWidget(
                            //   text: (userData!.currentDayObj.formats.contains(userData?.selectedDaySplit))
                            //       ? "Start the workout"
                            //       : "Mark Rest Day Complete",
                            //   textColor: Colors.grey,
                            //   onPress: () {
                            //   },
                            //   color: const Color.fromARGB(90, 214, 211, 211),
                            //   isLoading: false,
                            // ),
                          ),
                        ],
                      ),
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

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil.verticalScale(0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ScreenUtil.verticalScale(1.3)),
              Icon(Icons.circle,
                  size: ScreenUtil.verticalScale(0.6), color: Colors.black54),
            ]
          ),
          const SizedBox(width: 8),
          Container(
            constraints: BoxConstraints(maxWidth: media.width / 1.4),
            child: Text(
              text,
              style: TextStyle(
                fontSize: ScreenUtil.horizontalScale(4),
                color: Colors.black54,
                height: 1.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
