import 'package:bbb/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bbb/components/athletes_list_widget.dart';
import 'package:bbb/components/bar_chart_widget.dart';
import 'package:bbb/components/join_challenge_widget.dart';
import 'package:bbb/components/button_widget.dart';
import 'package:bbb/components/collection_grid.dart';
import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:bbb/values/clip_path.dart';
import 'package:bbb/providers/data_provider.dart';
import 'package:bbb/providers/user_data_provider.dart';

import '../values/app_constants.dart';

class DashboardPage extends StatefulWidget {
  final VoidCallback onNavigateToMonthlyView;

  const DashboardPage({
    super.key,
    required this.onNavigateToMonthlyView,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final today = DateTime.now();
  UserDataProvider? userData;
  DataProvider? dataProvider;
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  void _navigateToMonthlyView() {
    widget.onNavigateToMonthlyView();
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

    loadUserInfo();
    loadMonths();
    super.initState();
  }

  void loadUserInfo() async {
    userData?.loadUserInfo();
  }

  void loadMonths() async {
    await dataProvider?.fetchMonthWorkouts(3);
    setDateTime();
  }

  void setDateTime() {
    debugPrint(dataProvider?.workout?.startDate as String);
    DateTime startTime =
        DateTime.parse(dataProvider?.workout?.startDate as String);
    int dayDelta = today.difference(startTime).inDays;
    userData?.currentWeek = (dayDelta ~/ 7) + 1;
    userData?.currentDay = dayDelta % 7 + 1;
    userData?.currentMonth = dataProvider!.workout.index;
    userData?.notifyListeners();

    dataProvider?.dataLoaded = true;
    dataProvider?.notifyListeners();
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
                            height: media.height / 2,
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
                            height: media.height / 2,
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
                                    margin: const EdgeInsets.only(
                                        right: 10, bottom: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: ScreenUtil.horizontalScale(8),
                                            top: ScreenUtil.verticalScale(0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Consumer<UserDataProvider>(
                                                  builder: (context, userData,
                                                          child) =>
                                                      userData.userName != ""
                                                          ? Text(
                                                              // 'Hi, Nick',
                                                              'Hi, ${userData?.userName},',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: ScreenUtil
                                                                    .verticalScale(
                                                                        2.9),
                                                                height: 2,
                                                              ),
                                                            )
                                                          : const SizedBox()),
                                            ],
                                          ),
                                        ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.start,
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
                                        //                 ScreenUtil.verticalScale(3),
                                        //             color: Colors.white,
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     SizedBox(
                                        //       width: ScreenUtil.horizontalScale(1),
                                        //     ),
                                        //     Container(
                                        //       alignment: Alignment.center,
                                        //       height: ScreenUtil.verticalScale(2.3),
                                        //       width: ScreenUtil.verticalScale(2.3),
                                        //       decoration: BoxDecoration(
                                        //         color: Colors.black12,
                                        //         borderRadius: BorderRadius.all(
                                        //           Radius.circular(
                                        //               ScreenUtil.verticalScale(
                                        //                   1.8)),
                                        //         ),
                                        //         border:
                                        //             Border.all(color: Colors.white),
                                        //       ),
                                        //       child: const Text(
                                        //         '0',
                                        //         style:
                                        //             TextStyle(color: Colors.white),
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
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil.horizontalScale(8),
                                      vertical: ScreenUtil.verticalScale(2),
                                    ),
                                    height: media.height * 0.22,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          child: Column(
                                            children: [
                                              Text(
                                                'Your current workout:',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      ScreenUtil.verticalScale(
                                                          2),
                                                ),
                                              ),
                                              Consumer<DataProvider>(
                                                builder: (context, dataProvider,
                                                        child) =>
                                                    dataProvider.dataLoaded ==
                                                            true
                                                        ? Text(
                                                            '${months[today.month - 1]}: Day ${userData!.currentDay}',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: ScreenUtil
                                                                  .verticalScale(
                                                                      4),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Consumer<UserDataProvider>(
                                          builder: (context, userData, child) =>
                                              userData.userName != ""
                                                  ? ButtonWidget(
                                                      text: userData!
                                                                  .getCurrentDayState() ==
                                                              AppConstants
                                                                  .STATE_FINISHED
                                                          ? 'Completed'
                                                          : userData!.getCurrentDayState() ==
                                                                  AppConstants
                                                                      .STATE_SKIPPED
                                                              ? 'Skipped, Unskip?'
                                                              : userData!.getCurrentDayState() ==
                                                                      AppConstants
                                                                          .STATE_STARTED
                                                                  ? 'Continue Workout'
                                                                  : 'Start Workout',
                                                      textColor: AppColors
                                                          .primaryColor,
                                                      color: userData!.getCurrentDayState() ==
                                                                  AppConstants
                                                                      .STATE_FINISHED ||
                                                              userData!
                                                                      .getCurrentDayState() ==
                                                                  AppConstants
                                                                      .STATE_SKIPPED
                                                          ? Colors.white70
                                                          : Colors.white,
                                                      onPress: !(userData!
                                                                  .getCurrentDayState() ==
                                                              AppConstants
                                                                  .STATE_FINISHED)
                                                          ? () {
                                                              userData.updateOrAddDayHistory(
                                                                  AppConstants
                                                                      .STATE_STARTED);
                                                              Navigator
                                                                  .pushNamed(
                                                                context,
                                                                "/today",
                                                              );
                                                            }
                                                          : () {},
                                                      isLoading: false,
                                                    )
                                                  : const SizedBox(),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: media.height / 2.54,
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
                      // Extra content below the Stack if needed
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: media.height / 2.55,
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
                            margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil.horizontalScale(10),
                              vertical: ScreenUtil.verticalScale(2),
                            ),
                            child: Consumer2<UserDataProvider, DataProvider>(
                              builder:
                                  (context, userData, dataProvider, child) {
                                return userData.totalCompletedDays != -1 &&
                                        dataProvider.totalDays != 0
                                    ? Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${userData.totalCompletedDays}/${dataProvider.totalDays} days tracked',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize:
                                                      ScreenUtil.verticalScale(
                                                          1.5),
                                                ),
                                              ),
                                              Text(
                                                '${userData.totalCompletedDays * 100 ~/ dataProvider.totalDays}% Complete',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize:
                                                      ScreenUtil.verticalScale(
                                                          1.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Stack(
                                            children: [
                                              Container(
                                                width: media.width,
                                                height:
                                                    ScreenUtil.verticalScale(
                                                        0.5),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300]),
                                              ),
                                              Container(
                                                width: (ScreenUtil
                                                        .horizontalScale(80)) /
                                                    (dataProvider.totalDays /
                                                        userData
                                                            .totalCompletedDays),
                                                height:
                                                    ScreenUtil.verticalScale(
                                                        0.5),
                                                decoration: const BoxDecoration(
                                                    color:
                                                        AppColors.primaryColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : const SizedBox();
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil.horizontalScale(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: (_navigateToMonthlyView),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 18),
                                    ),
                                    child: Text(
                                      'Month View',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil.verticalScale(2),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                // const SizedBox(width: 15),
                                // Expanded(
                                //   child: ElevatedButton(
                                //     onPressed: () {},
                                //     style: ElevatedButton.styleFrom(
                                //       backgroundColor: Colors.white,
                                //       padding: const EdgeInsets.symmetric(
                                //         vertical: 20,
                                //       ),
                                //       side: const BorderSide(
                                //         color:
                                //             AppColors.primaryColor, // Border color
                                //         width: 2, // Border width
                                //       ),
                                //     ),
                                //     child: Text(
                                //       'Edit Schedule',
                                //       style: TextStyle(
                                //         color: AppColors.primaryColor,
                                //         fontSize: ScreenUtil.verticalScale(2),
                                //         fontWeight: FontWeight.bold,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil.horizontalScale(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Recent Activity",
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: ScreenUtil.horizontalScale(5.2),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Container(
                                  height: media.height * 0.05,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      items: [
                                        "Session Score",
                                        "Average RiR",
                                        "Time Spent",
                                        "Workouts Done",
                                      ]
                                          .map(
                                            (name) => DropdownMenuItem(
                                              value: name,
                                              child: Text(
                                                name,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize:
                                                      ScreenUtil.verticalScale(
                                                          2),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (value) {},
                                      icon: Icon(
                                        Icons.expand_more,
                                        color: Colors.grey,
                                        size: ScreenUtil.verticalScale(3.5),
                                      ),
                                      hint: Text(
                                        "Session Score",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: ScreenUtil.verticalScale(2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil.horizontalScale(10),
                            ),
                            child: BarChartWidget(),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil.horizontalScale(10),
                            ),
                            child: ButtonWidget(
                              text: 'See all progress reports',
                              textColor: Colors.white,
                              color: AppColors.primaryColor,
                              onPress: () {
                                Navigator.pushNamed(
                                    context, "/graphAndReports");
                              },
                              isLoading: false,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              // horizontal: ScreenUtil.horizontalScale(5),
                              vertical: ScreenUtil.verticalScale(5),
                            ),
                            child: const JoinChallengeWidget(),
                          ),
                          Container(
                            width: media.width,
                            margin: EdgeInsets.symmetric(
                              vertical: ScreenUtil.verticalScale(3),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const PageScrollPhysics(),
                              child: Row(children: [
                                SizedBox(
                                  width: ScreenUtil.horizontalScale(3),
                                ),
                                AthletesListWidget(
                                  height: ScreenUtil.verticalScale(38),
                                  width: ScreenUtil.horizontalScale(60),
                                ),
                                AthletesListWidget(
                                  height: ScreenUtil.verticalScale(38),
                                  width: ScreenUtil.horizontalScale(60),
                                ),
                                AthletesListWidget(
                                  height: ScreenUtil.verticalScale(38),
                                  width: ScreenUtil.horizontalScale(60),
                                ),
                              ]),
                            ),
                          ),
                          Container(
                            width: media.width,
                            margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil.horizontalScale(5),
                              vertical: ScreenUtil.verticalScale(4),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: media.width,
                                  margin: const EdgeInsets.only(
                                      bottom: 20, left: 6),
                                  child: Text(
                                    "Featured Collections",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: ScreenUtil.verticalScale(2.4),
                                      fontWeight: FontWeight.w800,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: CollectionGrid(
                                      topText: 'BBB',
                                      bottomText: 'Outfits',
                                    )),
                                    Expanded(
                                        child: CollectionGrid(
                                      topText: 'Perfect',
                                      bottomText: 'Warm-ups',
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: CollectionGrid(
                                      topText: 'Guide',
                                      bottomText: 'to Split',
                                    )),
                                    Expanded(
                                        child: CollectionGrid(
                                      topText: 'All the',
                                      bottomText: 'Equipment',
                                    )),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: media.width,
                            child: Column(
                              children: [
                                Container(
                                  width: media.width,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil.horizontalScale(10),
                                    vertical: ScreenUtil.verticalScale(2),
                                  ),
                                  child: Text(
                                    "Meet our staff",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: ScreenUtil.verticalScale(2.3),
                                      fontWeight: FontWeight.w800,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(children: [
                                    SizedBox(
                                      width: ScreenUtil.horizontalScale(2.5),
                                    ),
                                    AthletesListWidget(
                                      height: ScreenUtil.verticalScale(37),
                                      width: ScreenUtil.horizontalScale(62),
                                    ),
                                    AthletesListWidget(
                                      height: ScreenUtil.verticalScale(37),
                                      width: ScreenUtil.horizontalScale(62),
                                    ),
                                    AthletesListWidget(
                                      height: ScreenUtil.verticalScale(37),
                                      width: ScreenUtil.horizontalScale(62),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
