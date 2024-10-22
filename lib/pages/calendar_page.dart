import 'package:bbb/components/weekly_track_card.dart';
import 'package:bbb/models/month.dart';
import 'package:bbb/providers/data_provider.dart';
import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:bbb/values/clip_path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bbb/pages/MonthlyView/monthly_view_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DataProvider? dataProvider;
  late Month thisMonthWorkout;
  // List<dynamic> monthlyWorkOutSchedule = [];
  int currentMonth = 0;

  List monthOverView = [
    {"month": 'January', "year": "2024"},
    {"month": 'February', "year": "2024"},
    {"month": 'March', "year": "2024"},
    {"month": 'April', "year": "2024"},
    {"month": 'May', "year": "2024"},
    {"month": 'June', "year": "2024"},
    {"month": 'July1', "year": "2024"},
    {"month": 'July2', "year": "2024"},
    {"month": 'August', "year": "2024"},

  ];

  @override
  void initState() {
    // dataProvider = Provider.of<DataProvider>(
    //   context,
    //   listen: false,
    // );
    // monthlyWorkOutSchedule = dataProvider!.monthlyWorkOutSchedule;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    DataProvider? dataProvider = Provider.of<DataProvider>(
      context,
      listen: false,
    );
    thisMonthWorkout = dataProvider.workout;

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
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: ScreenUtil.horizontalScale(9),
                                        height: ScreenUtil.horizontalScale(9),
                                        decoration: const BoxDecoration(
                                          color: Color(0XFFd18a9b),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () =>
                                                {Navigator.pop(context)},
                                            icon: Icon(
                                              Icons.arrow_back_ios_new,
                                              size:
                                                  ScreenUtil.verticalScale(2.5),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            height:
                                                ScreenUtil.verticalScale(2.5),
                                            width:
                                                ScreenUtil.verticalScale(2.5),
                                            decoration: BoxDecoration(
                                              color: Colors.black12,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    ScreenUtil.verticalScale(
                                                        2)),
                                              ),
                                              border: Border.all(
                                                  color: Colors.white),
                                            ),
                                            child: const Text(
                                              '0',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/streak');
                                            },
                                            child: Icon(
                                              Icons
                                                  .local_fire_department_outlined,
                                              color: Colors.white,
                                              size: ScreenUtil.verticalScale(3),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.notifications_none,
                                              color: Colors.white,
                                              size:
                                                  ScreenUtil.verticalScale(3.5),
                                            ),
                                          )
                                        ],
                                      )
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
                                        '${monthOverView[currentMonth]['month']}, ${monthOverView[currentMonth]['year']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              ScreenUtil.verticalScale(2.7),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Month',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil.verticalScale(4),
                                          fontWeight: FontWeight.bold,
                                          height: 1,
                                        ),
                                      ),
                                      Text(
                                        'Overview',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil.verticalScale(4),
                                          fontWeight: FontWeight.bold,
                                          height: 1.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil.verticalScale(2),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil.horizontalScale(7),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (currentMonth > 0) {
                                            setState(() {
                                              currentMonth--;
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ScreenUtil.verticalScale(2),
                                            vertical:
                                                ScreenUtil.verticalScale(1),
                                          ),
                                          decoration: BoxDecoration(
                                              color: currentMonth > 0
                                                  ? Colors.white
                                                  : Colors.grey
                                                      .withOpacity(0.7),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  ScreenUtil.verticalScale(3),
                                                ),
                                              )
                                              // shape: BoxShape.circle,
                                              ),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.arrow_back,
                                                  size:
                                                      ScreenUtil.verticalScale(
                                                    2,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: ScreenUtil
                                                      .horizontalScale(0.5),
                                                ),
                                                Text(
                                                  'Prev',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: ScreenUtil
                                                        .verticalScale(2),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (currentMonth <
                                              monthOverView.length - 1) {
                                            setState(() {
                                              currentMonth++;
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ScreenUtil.verticalScale(2),
                                            vertical:
                                                ScreenUtil.verticalScale(1),
                                          ),
                                          decoration: BoxDecoration(
                                              color: currentMonth <
                                                      monthOverView.length - 1
                                                  ? Colors.white
                                                  : Colors.grey
                                                      .withOpacity(0.7),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  ScreenUtil.verticalScale(3),
                                                ),
                                              )),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Next',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: ScreenUtil
                                                        .verticalScale(2),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: ScreenUtil
                                                      .horizontalScale(0.5),
                                                ),
                                                Icon(
                                                  Icons.arrow_forward,
                                                  size:
                                                      ScreenUtil.verticalScale(
                                                    2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: media.height / 2.84,
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
                    top: media.height / 2.85,
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
                            horizontal: ScreenUtil.horizontalScale(6),
                            vertical: ScreenUtil.verticalScale(5),
                          ),
                          child: Column(
                            children: [
                              for (int i = 0;
                              i < (thisMonthWorkout != null ? thisMonthWorkout?.weeks.length as num : 0);
                              i++) ...[
                                WeeklyTrackCard(
                                    title: thisMonthWorkout?.weeks[i].title,
                                    weekIndex: i,
                                    thisWeek: false,
                                    isOpened: i == 0,
                                    isCompleted: false,
                                    startDate: DateTime.parse(thisMonthWorkout.startDate),
                                    cardData: thisMonthWorkout?.weeks[i],
                                    daySplit: "3",
                                    expandedVal: false
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
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
}
