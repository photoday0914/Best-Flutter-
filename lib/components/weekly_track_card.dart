import 'package:bbb/components/button_widget.dart';
import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:bbb/models/day.dart';
import 'package:bbb/models/week.dart';
import 'package:bbb/providers/user_data_provider.dart';

import '../values/app_constants.dart';

class WeeklyTrackCard extends StatefulWidget {
  const WeeklyTrackCard({
    super.key,
    required this.title,
    required this.thisWeek,
    required this.weekIndex,
    required this.isOpened,
    required this.isCompleted,
    required this.startDate,
    required this.cardData,
    required this.daySplit,
    required this.expandedVal,
  });

  final String title;
  final bool thisWeek;
  final int weekIndex;
  final bool isOpened;
  final bool isCompleted;
  final DateTime startDate;
  final Week cardData;
  final String daySplit;
  final bool expandedVal;

  @override
  State<WeeklyTrackCard> createState() => _WeeklyTrackCardState();
}

class _WeeklyTrackCardState extends State<WeeklyTrackCard> {
  List<String> moreOptions = ["None", "Recommended", "Last Visited"];
  UserDataProvider? userData;

  int curExpandedIdx = 0;
  bool ischecked = false;
  bool _isExpanded = false;
  bool thisWeek = false;
  int totalExercises = 0;
  List cardDataArr = [];

  @override
  void initState() {
    userData = Provider.of<UserDataProvider>(
      context,
      listen: false,
    );

    thisWeek = widget.thisWeek;
    _isExpanded = widget.expandedVal;
    cardDataArr = [...widget.cardData.days];
    for (var element in cardDataArr) {
      if ((element as Day).formats.contains(widget.daySplit)) {
        totalExercises += element.exercises.length!;
      }
    }

    for (var wObj in cardDataArr) {
      // debugPrint(
      //     (userData!.dayHistory)
      //         .any((element) =>
      //     int.parse((element['monthIndex']).toString()) ==
      //         userData!.currentMonth &&
      //         int.parse((element['weekIndex']).toString()) ==
      //             widget.cardData.index &&
      //         element['daySplit'] == int.parse(widget.daySplit) &&
      //         element['dayIndex'] == wObj.typeId) ? "true" : "false");

      for (var element in userData!.dayHistory) {
        debugPrint('S ==== ${element['monthIndex']} ${element['weekIndex']} ${element['daySplit']} ${element['dayIndex']} ${element['state']}');
        debugPrint('O ==== ${userData!.currentMonth} ${widget.cardData.index} ${widget.daySplit} ${wObj.typeId}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return totalExercises != 0
        ? Container(
            child: FilterViewList(),
          )
        : Container();
  }

  Widget FilterViewList() {
    return SingleChildScrollView(
        child: Column(children: [
      ExpansionTileGroup(
          toggleType: ToggleType.expandOnlyCurrent,
          spaceBetweenItem: 15,
          onExpansionItemChanged: (idx, isExpand) => {
                curExpandedIdx = idx,
              },
          children: [
            FilterViewItem(_isExpanded, widget.title),
          ]),
    ]));
  }

  ExpansionTileItem FilterViewItem(bool initExpanded, String title) {
    var media = MediaQuery.of(context).size;
    ScreenUtil.init(context);

    void setWeekIsComplete() {
      setState(() {});
    }

    return ExpansionTileItem(
      tilePadding: EdgeInsets.symmetric(
        horizontal: ScreenUtil.horizontalScale(5),
        vertical: ScreenUtil.verticalScale(0.5),
      ),
      title: Row(
        children: [
          Text(
            title != "" ? title : "Week",
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.primaryColor,
              fontSize: ScreenUtil.verticalScale(2),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: ScreenUtil.verticalScale(3),
          ),
          if (!_isExpanded)
            Text(
              '$totalExercises workouts',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.black38,
                fontSize: ScreenUtil.verticalScale(1.5),
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
      backgroundColor: const Color(0xFF0D0D0D),
      collapsedBackgroundColor: const Color(0xFF0D0D0D),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil.verticalScale(3)),
        color: Colors.grey[100],
      ),
      iconColor: Colors.grey[400],
      collapsedIconColor: AppColors.primaryColor,
      initiallyExpanded: initExpanded,
      onExpansionChanged: (bool expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                ischecked = !ischecked;
              });
            },
            child: Container(
              padding: EdgeInsets.all(
                ScreenUtil.verticalScale(1),
              ),
              decoration: widget.isCompleted
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: AppColors.primaryColor, width: 2),
                      color: AppColors.primaryColor,
                    )
                  : null,
              child: widget.isCompleted
                  ? Icon(
                      Icons.check,
                      size: ScreenUtil.verticalScale(2),
                      color: Colors.white,
                    )
                  : Icon(
                      null,
                      size: ScreenUtil.verticalScale(
                        2,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 3),
          InkWell(
            child: Container(
              padding: EdgeInsets.all(
                ScreenUtil.verticalScale(0.3),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2,
                ),
                color: AppColors.primaryColor,
              ),
              child: Icon(
                _isExpanded
                    ? Icons.keyboard_arrow_up_outlined
                    : Icons.keyboard_arrow_down_outlined,
                color: Colors.white,
                weight: 900,
                size: ScreenUtil.verticalScale(3),
              ),
            ),
          ),
        ],
      ),
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil.verticalScale(6))),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil.horizontalScale(1),
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      widget.cardData.description ?? "",
                      style: TextStyle(
                        fontSize: ScreenUtil.verticalScale(1.7),
                        color: const Color(0xFF888888),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil.verticalScale(3),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: cardDataArr.map((wObj) {
                        var isLast = wObj == cardDataArr.last;
                        bool isRestDay =
                            !((wObj as Day).formats.contains(widget.daySplit));
                        var index = cardDataArr.indexOf(wObj, 0);
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(
                                    ScreenUtil.verticalScale(0.5),
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Consumer<UserDataProvider>(
                                    builder: (context, userData, child) =>
                                      Container(
                                        height: ScreenUtil.verticalScale(1.4),
                                        width: ScreenUtil.verticalScale(1.4),
                                        decoration: BoxDecoration(
                                          color: (userData!
                                                      .dayHistory)
                                                  .any((element) =>
                                                      ('${element['monthIndex']} ${element['weekIndex']} ${element['daySplit']} ${element['dayIndex']} ${element['state']}') ==
                                                      ('${userData!.currentMonth} ${widget.cardData.index} ${widget.daySplit} ${wObj.typeId} ${AppConstants.STATE_FINISHED}')
                                                  )
                                              ? const Color.fromARGB(255, 0, 161, 62) :
                                                !thisWeek || (userData!
                                                    .dayHistory)
                                                    .any((element) =>
                                                    ('${element['monthIndex']} ${element['weekIndex']} ${element['daySplit']} ${element['dayIndex']} ${element['state']}') ==
                                                    ('${userData!.currentMonth} ${widget.cardData.index} ${widget.daySplit} ${wObj.typeId} ${AppConstants.STATE_SKIPPED}'))
                                              ? const Color.fromARGB(255, 0, 62, 161)
                                              : const Color(0XFFC84152),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                ),
                                if (!isLast)
                                  DottedDashedLine(
                                    height: media.width * 0.078,
                                    width: 0,
                                    dashColor: Colors.grey.withOpacity(0.5),
                                    axis: Axis.vertical,
                                  )
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                // Define your button action here
                                userData?.currentWeek = widget.weekIndex + 1;
                                userData?.currentDay = index + 1;
                                userData?.notifyListeners();

                                Navigator.pushNamed(context, '/dayOverview');
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Day ${wObj.typeId} ${wObj.title}${widget.startDate.add(Duration(days: wObj.typeId - 1)).difference(DateTime.now()).inDays <= 1 && (widget.startDate.add(Duration(days: wObj.typeId - 1))).day == DateTime.now().day ? "(Today) " : ""}${isRestDay ? "(Rest Day)" : ""}",
                                        style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: ScreenUtil.verticalScale(2),
                                          fontWeight: FontWeight.bold,
                                          height: 1,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [
                                            Text(
                                              ("${widget.startDate.add(Duration(days: wObj.typeId - 1)).month}/${widget.startDate.add(Duration(days: wObj.typeId - 1)).day}/${widget.startDate.add(Duration(days: wObj.typeId - 1)).year}"),
                                              style: TextStyle(
                                                fontSize:
                                                    ScreenUtil.verticalScale(
                                                  1.4,
                                                ),
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            if (!isRestDay) ...[
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '|',
                                                style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil.verticalScale(
                                                    1.4,
                                                  ),
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '${wObj.exercises.length.toString()} Exercises',
                                                style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil.verticalScale(
                                                    1.4,
                                                  ),
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ]
                                          ]),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    child: SizedBox(
                                      height: ScreenUtil.horizontalScale(12),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // if ((tempData!.dayHistory).any((element) =>
                                          //     element['daySplit'] == int.parse(widget.daySplit) &&
                                          //     element['monthIndex'] == tempData?.currentMonth &&
                                          //     element['weekIndex'] == widget.cardData.index &&
                                          //     element['dayIndex'] == wObj.typeId))
                                          //   InkWell(
                                          //     child: Container(
                                          //         padding: EdgeInsets.all(
                                          //           ScreenUtil.verticalScale(0.5),
                                          //         ),
                                          //         decoration: BoxDecoration(
                                          //             shape: BoxShape.circle,
                                          //             border: Border.all(
                                          //               color: AppColors
                                          //                   .primaryColor,
                                          //               width: 2,
                                          //             ),
                                          //             color: AppColors
                                          //                 .primaryColor),
                                          //         child: Icon(
                                          //           Icons.check,
                                          //           size: ScreenUtil
                                          //               .verticalScale(
                                          //             2.5,
                                          //           ),
                                          //           color: Colors.white,
                                          //         )),
                                          //   ),
                                          SizedBox(
                                            width:
                                                ScreenUtil.horizontalScale(1),
                                          ),
                                          // (widget.startDate.add(Duration(
                                          //                 days: index)))
                                          //             .isBefore(
                                          //                 DateTime.now()) ||
                                                  // widget.startDate
                                                  //             .add(Duration(
                                                  //                 days: index))
                                                  //             .difference(
                                                  //                 DateTime
                                                  //                     .now())
                                                  //             .inDays <=
                                                  //         1 &&
                                                  //     (widget.startDate.add(
                                                  //                 Duration(
                                                  //                     days:
                                                  //                         index)))
                                                  //             .day ==
                                                  //         DateTime.now().day
                                              GestureDetector(
                                                  onTap: () {
                                                    userData?.currentWeek = widget.weekIndex + 1;
                                                    userData?.currentDay =
                                                        index + 1;
                                                    userData?.notifyListeners();

                                                    Navigator.pushNamed(context,
                                                        '/dayOverview');
                                                  },
                                                  child: InkWell(
                                                    child: Container(
                                                      padding: EdgeInsets.all(
                                                        ScreenUtil
                                                            .verticalScale(0.5),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: Colors.white,
                                                          width: 2,
                                                        ),
                                                        color: Colors.white,
                                                      ),
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_arrow_right_outlined,
                                                        color: AppColors
                                                            .primaryColor,
                                                        size: ScreenUtil
                                                            .verticalScale(2.5),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              // : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
