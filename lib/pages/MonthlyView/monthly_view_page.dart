import 'package:bbb/components/button_widget.dart';
import 'package:bbb/components/weekly_track_card.dart';
import 'package:bbb/components/select_dropdown.dart';
import 'package:bbb/components/select_dropdown1.dart';
import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:bbb/values/clip_path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bbb/pages/video_intro_page.dart';
import 'package:bbb/providers/data_provider.dart';
import 'package:bbb/routes/fade_page_route.dart';
import 'package:bbb/providers/user_data_provider.dart';

class MonthlyViewPage extends StatefulWidget {
  const MonthlyViewPage({
    super.key,
    required this.onNavigateToHomeView,
  });

  final VoidCallback onNavigateToHomeView;


  @override
  State<MonthlyViewPage> createState() => _MonthlyViewPageState();
}

class _MonthlyViewPageState extends State<MonthlyViewPage> {
  final today = DateTime.now();
  DataProvider? dataProvider;
  UserDataProvider? userData;
  int? week;
  int? day;

  void _navigateToHomeView() {
    widget.onNavigateToHomeView();
  }

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

    DateTime startTime =
        DateTime.parse(dataProvider?.workout?.startDate as String);
    int dayDelta = today.difference(startTime).inDays;
    week = (dayDelta ~/ 7) + 1;
    day = dayDelta % 7 + 1;

    // week = 1;
    // day = 6;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Method to filter workouts based on selected formats
  void filterWorkouts() async {
    dataProvider?.clearAll();
    await Future.delayed(const Duration(milliseconds: 50));
    dataProvider?.filter(
        userData!.selectedExerciseFormat, userData!.selectedDaySplit);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    ScreenUtil.init(context);

    // dataProvider?.loadMonthWorkouts();

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
                          height: media.height / 2.45,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                            onPressed: (_navigateToHomeView),
                                            iconSize: ScreenUtil.verticalScale(
                                                4), // Icon size remains the same
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: ScreenUtil.horizontalScale(9),
                                        height: ScreenUtil.horizontalScale(9),
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                          shape: BoxShape.circle,
                                        ),
                                        // child: Center(
                                        //   child: IconButton(
                                        //     padding: EdgeInsets.zero,
                                        //     onPressed: () => {
                                        //       Navigator.pushNamed(
                                        //         context,
                                        //         '/calendar',
                                        //       )
                                        //     },
                                        //     icon: Icon(
                                        //       Icons.calendar_month,
                                        //       size:
                                        //       ScreenUtil.verticalScale(3),
                                        //       color: Colors.white,
                                        //     ),
                                        //   ),
                                        // ),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil.horizontalScale(1),
                                      ),
                                      // Container(
                                      //   alignment: Alignment.center,
                                      //   height: ScreenUtil.verticalScale(2.5),
                                      //   width: ScreenUtil.verticalScale(2.5),
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.black12,
                                      //     borderRadius: BorderRadius.all(
                                      //       Radius.circular(
                                      //           ScreenUtil.verticalScale(2)),
                                      //     ),
                                      //     border:
                                      //         Border.all(color: Colors.white),
                                      //   ),
                                      //   child: const Text(
                                      //     '0',
                                      //     style: TextStyle(color: Colors.white),
                                      //   ),
                                      // ),
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
                                      //     size: ScreenUtil.verticalScale(3.5),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil.horizontalScale(12),
                                  ),
                                  height: media.height * 0.15,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Aug, 2024',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              ScreenUtil.verticalScale(2.3),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Month',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              ScreenUtil.verticalScale(3.5),
                                          fontWeight: FontWeight.bold,
                                          height: 1,
                                        ),
                                      ),
                                      Text(
                                        'Overview',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              ScreenUtil.verticalScale(3.5),
                                          fontWeight: FontWeight.bold,
                                          height: 1.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: ScreenUtil.verticalScale(0.7)),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil.horizontalScale(10),
                                  ),
                                  child: ButtonWidget(
                                    text: "Watch Video Intro",
                                    color: const Color(0xEEFFFFFF),
                                    onPress: () {
                                      Navigator.of(context).push(
                                        FadePageRoute(
                                            page: const VideoIntroWidget(
                                                vimeoId: '953289606')),
                                      );
                                    },
                                    textColor: AppColors.primaryColor,
                                    isLoading: false,
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.only(
                                //       right: ScreenUtil.horizontalScale(6)),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.end,
                                //     children: [
                                //       Text(
                                //         'Video Intro',
                                //         style: TextStyle(
                                //           color: Colors.white,
                                //           fontSize: ScreenUtil.verticalScale(2),
                                //         ),
                                //       ),
                                //       const SizedBox(
                                //         width: 15,
                                //       ),
                                //       ElevatedButton(
                                //         style: ElevatedButton.styleFrom(
                                //           foregroundColor: Colors.transparent,
                                //           backgroundColor:
                                //               Colors.white.withOpacity(0.18),
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
                                //               width: 1,
                                //             ),
                                //           ),
                                //           child: Container(
                                //             width: ScreenUtil.verticalScale(7),
                                //             height: ScreenUtil.verticalScale(7),
                                //             alignment: Alignment.center,
                                //             child: Icon(
                                //               Icons.play_arrow,
                                //               color: Colors.white,
                                //               size: ScreenUtil.verticalScale(5),
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
                    bottom: ScreenUtil.verticalScale(15),
                  ),
                  child: Container(
                    width: media.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(ScreenUtil.verticalScale(7)),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil.horizontalScale(8),
                            vertical: ScreenUtil.verticalScale(3),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  left: ScreenUtil.horizontalScale(3),
                                ),
                                child: Text(
                                  'Choose workout day split',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: const Color(0xBB888888),
                                    fontSize: ScreenUtil.verticalScale(1.5),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              SelectDropdown1(
                                onChange: (String newValue) {
                                  userData?.changeDaySplit(newValue);
                                  filterWorkouts();
                                },
                              ),
                              const SizedBox(height: 32),
                              Container(
                                margin: EdgeInsets.only(
                                    left: ScreenUtil.horizontalScale(3)),
                                child: Text(
                                  'Choose equipent availiability',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: const Color(0xBB888888),
                                    fontSize: ScreenUtil.verticalScale(1.5),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SelectDropdown(
                                onChange: (String newValue) {
                                  userData!.selectedExerciseFormat = newValue;
                                  userData?.notifyListeners();
                                  filterWorkouts();
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Consumer<DataProvider>(
                          builder: (context, dataProvider, child) =>
                              dataProvider.workout != null
                                  ? Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal:
                                              ScreenUtil.horizontalScale(6)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  (dataProvider.workout != null
                                                      ? dataProvider.workout
                                                          ?.weeks.length as num
                                                      : 0);
                                              i++) ...[
                                            WeeklyTrackCard(
                                              title: dataProvider.workout
                                                          ?.weeks[i].title ==
                                                      ""
                                                  ? "Week ${i + 1}"
                                                  : dataProvider
                                                      .workout?.weeks[i].title,
                                              // isOpened: i == 0,
                                              thisWeek: ((i + 1) == week),
                                              weekIndex: i,
                                              isOpened: false,
                                              isCompleted: false,
                                              startDate: DateTime.parse(
                                                      dataProvider
                                                          .workout.startDate)
                                                  .add(Duration(days: i * 7)),
                                              cardData: dataProvider
                                                  .workout?.weeks[i],
                                              daySplit:
                                                  userData!.selectedDaySplit,
                                              expandedVal: (i + 1) == week
                                                  ? true
                                                  : false,
                                            ),
                                            //Text(dataProvider.workout?.weeks[i].title),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                          ],

                                          // Container(
                                          //   margin: EdgeInsets.symmetric(
                                          //     horizontal: ScreenUtil.horizontalScale(10),
                                          //   ),
                                          //   child: ButtonWidget(
                                          //     text: "Mark Month Complete",
                                          //     textColor: const Color(0x30000000),
                                          //     onPress: () {},
                                          //     color: const Color(0xC8FFFFFF),
                                          //     isLoading: false,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                        ),
                        const SizedBox(height: 55),
                        // Container(
                        //   margin: EdgeInsets.symmetric(
                        //     horizontal: ScreenUtil.horizontalScale(10),
                        //   ),
                        //   child: ButtonWidget(
                        //     text: "Mark Month Complete",
                        //     textColor: const Color(0x30000000),
                        //     onPress: () {},
                        //     color: const Color(0xC8FFFFFF),
                        //     isLoading: false,
                        //   ),
                        // ),
                        // const SizedBox(height: 16),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil.horizontalScale(10),
                          ),
                          child: ButtonWidget(
                            text: "Start Your Workout",
                            textColor: Colors.white,
                            onPress: () {
                              userData?.currentWeek = week!;
                              userData?.currentDay = day!;
                              userData?.notifyListeners();

                              Navigator.pushNamed(context, '/dayOverview');
                            },
                            color: AppColors.primaryColor,
                            isLoading: false,
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
