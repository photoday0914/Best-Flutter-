import 'package:bbb/components/button_widget.dart';
import 'package:bbb/components/time_line.dart';
import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:bbb/values/clip_path.dart';
import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:bbb/providers/data_provider.dart';
import 'package:bbb/providers/user_data_provider.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

import '../components/app_alert_dialog.dart';
import '../components/timer_with_progress.dart';
import '../values/app_constants.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  DataProvider? dataProvider;
  UserDataProvider? userData;
  VimeoVideoPlayer? vimeoVideoPlayer;

  int weight = 20;
  int reps = 5;
  int sets = 5;
  int rest = 20;
  int exerciseIndex = 0;

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

    vimeoVideoPlayer = const VimeoVideoPlayer(
        url: 'https://player.vimeo.com/video/953289606', autoPlay: true);

    try {
      debugPrint("============ Debug Print ===============");
      debugPrint(userData?.currentExercise!.weight.toString());
      debugPrint(userData?.currentExercise!.reps.toString());
      debugPrint(userData?.currentExercise!.sets.toString());

      weight = userData?.currentExercise!.weight as int;
      reps = userData?.currentExercise!.reps as int;
      sets = userData?.currentExercise!.sets as int;
      rest = userData?.currentExercise!.rest as int;

      if (userData!.currentDayObj.warmups.isNotEmpty) {
        userData?.fetchWarmUp(userData!.currentDayObj.warmups[0].id);
      }
      userData?.fetchCurrentEx(userData!.currentExercise!.id);
    } catch (e) {
      print('The late variable has not been initialized.');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    final params = ModalRoute.of(context)!.settings.arguments as List<String>;
    final exerciseName = params[0];
    final isExercise = int.parse(params[1]);
    exerciseIndex = int.parse(params[2]);

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
                        // Container(
                        //   height: media.height / 1.1,
                        //   width: media.width,
                        //   decoration: const BoxDecoration(
                        //     image: DecorationImage(
                        //       image: AssetImage('assets/img/pp_4.png'),
                        //       fit: BoxFit.cover,
                        //       opacity: 1,
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: media.height / 1.1,
                        //   width: media.width,
                        //   child: vimeoVideoPlayer,
                        // ),

                        Container(
                            color: Colors.black,
                            child: Column(children: [
                              SizedBox(
                                // height: media.height / 1.185,
                                height: media.height / 1.1,
                                width: media.width,
                                child: vimeoVideoPlayer,
                              ),
                              SizedBox(
                                height: media.height / 5,
                                width: media.width,
                              ),
                            ])),
                        Container(
                          // height: media.height / 1.1,
                          width: media.width,
                          decoration: const BoxDecoration(),
                          child: SafeArea(
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 40.0,
                                            height: 40.0,
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.9),
                                              shape: BoxShape.circle,
                                            ),
                                            child: IconButton(
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_left,
                                                  color: Colors.white),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              iconSize:
                                                  ScreenUtil.verticalScale(3),
                                            ),
                                          ),
                                          Container(
                                            width: 40.0,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.9),
                                              shape: BoxShape.circle,
                                            ),
                                            child: IconButton(
                                              icon: const Icon(Icons.close,
                                                  color: Colors.white),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              iconSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              color: Colors.black12,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(20),
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
                                            icon: const Icon(
                                              Icons.notifications_none,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: media.height / 1.199,
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
                  margin: EdgeInsets.only(top: media.height / 1.2),
                  child: Container(
                    width: media.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: media.height / 35),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            // padding: const EdgeInsets.only(top: 40),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 30,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            exerciseName,
                                            style: const TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons
                                                    .insert_chart_outlined_sharp,
                                                color: AppColors.primaryColor,
                                                size: 30,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: AppColors.primaryColor,
                                                  size: 30,
                                                ),
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled:
                                                        true, // This makes the modal expand fully
                                                    builder:
                                                        (BuildContext context) {
                                                      return AddNoteBottomSheet();
                                                    },
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Consumer<UserDataProvider>(
                                        builder: (context, userData, child) =>
                                            Text(
                                          (isExercise == 1)
                                              ? (userData!.currentExercise!
                                                          .guide ==
                                                      ""
                                                  ? "Exercise GuideLines will be displayed here."
                                                  : userData!
                                                      .currentExercise!.guide)
                                              : (userData!.currentWarmup
                                                          .description ==
                                                      ""
                                                  ? "Warm-Up GuideLines will be displayed here."
                                                  : userData!.currentWarmup
                                                      .description),
                                          style: const TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                if (isExercise == 1) ...[
                                  for (int i = 0; i < sets; i++) ...[
                                    Consumer<UserDataProvider>(
                                      builder: (context, userData, child) {
                                        var exerciseDataMatch =
                                            userData!.exerciseData.firstWhere(
                                          (data) =>
                                              int.parse((data['monthIndex'])
                                                      .toString()) ==
                                                  userData?.currentMonth &&
                                              int.parse((data['weekIndex'])
                                                      .toString()) ==
                                                  userData?.currentWeek &&
                                              data['daySplit'].toString() ==
                                                  userData?.selectedDaySplit &&
                                              data['gymAccess'].toString() ==
                                                  userData
                                                      ?.selectedExerciseFormatAlternate &&
                                              data['exerciseIndex']
                                                      .toString() ==
                                                  exerciseIndex.toString() &&
                                              data['setIndex'].toString() ==
                                                  i.toString() &&
                                              data['dayIndex'].toString() ==
                                                  userData?.currentDay
                                                      .toString(),
                                          orElse: () => null,
                                        );

                                        return exerciseDataMatch != null
                                            ? ExerciseSetCard(
                                                title: "Set ${i + 1}",
                                                isOpened: i == 0,
                                                exercise: exerciseIndex,
                                                set: i,
                                                weight: int.parse(
                                                    exerciseDataMatch['weight']
                                                        .toString()),
                                                reps: int.parse(
                                                    exerciseDataMatch['reps']
                                                        .toString()),
                                                repsInReverse: int.parse(
                                                    exerciseDataMatch[
                                                            'repsInReverse']
                                                        .toString()),
                                                restDuration: rest,
                                              )
                                            : ExerciseSetCard(
                                                title: "Set ${i + 1}",
                                                isOpened: i == 0,
                                                exercise: exerciseIndex,
                                                set: i,
                                                weight: weight,
                                                reps: reps,
                                                repsInReverse: 0,
                                                restDuration: rest,
                                              );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                  for (int i = sets;
                                      i <=
                                          (userData!.exerciseData
                                              .where((data) =>
                                                  int.parse((data['monthIndex']).toString()) ==
                                                      userData?.currentMonth &&
                                                  int.parse((data['weekIndex']).toString()) ==
                                                      userData?.currentWeek &&
                                                  data['daySplit'].toString() ==
                                                      userData
                                                          ?.selectedDaySplit &&
                                                  data['gymAccess'].toString() ==
                                                      userData
                                                          ?.selectedExerciseFormatAlternate &&
                                                  data['exerciseIndex'].toString() ==
                                                      exerciseIndex
                                                          .toString() &&
                                                  data['dayIndex'].toString() ==
                                                      userData?.currentDay
                                                          .toString())
                                              .map((data) => int.parse(
                                                  data['setIndex'].toString()))
                                              .fold<int>(
                                                  0,
                                                  (prev, element) => element > prev
                                                      ? element
                                                      : prev));
                                      i++) ...[
                                    Consumer<UserDataProvider>(
                                        builder: (context, userData, child) {
                                      var exerciseDataMatch =
                                          userData!.exerciseData.firstWhere(
                                        (data) =>
                                            int.parse((data['monthIndex'])
                                                    .toString()) ==
                                                userData?.currentMonth &&
                                            int.parse((data['weekIndex'])
                                                    .toString()) ==
                                                userData?.currentWeek &&
                                            data['daySplit'].toString() ==
                                                userData?.selectedDaySplit &&
                                            data['gymAccess'].toString() ==
                                                userData
                                                    ?.selectedExerciseFormatAlternate &&
                                            data['exerciseIndex'].toString() ==
                                                exerciseIndex.toString() &&
                                            data['setIndex'].toString() ==
                                                i.toString() &&
                                            data['dayIndex'].toString() ==
                                                userData?.currentDay.toString(),
                                        orElse: () => null,
                                      );

                                      return exerciseDataMatch != null
                                          ? ExerciseSetCard(
                                              title: "Set ${i + 1}",
                                              isOpened: i == 0,
                                              exercise: exerciseIndex,
                                              set: i,
                                              weight: int.parse(
                                                  exerciseDataMatch['weight']
                                                      .toString()),
                                              reps: int.parse(
                                                  exerciseDataMatch['reps']
                                                      .toString()),
                                              repsInReverse: int.parse(
                                                  exerciseDataMatch[
                                                          'repsInReverse']
                                                      .toString()),
                                              restDuration: rest,
                                            )
                                          : const SizedBox();
                                    }),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                  const SizedBox(height: 20),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        userData?.updateOrAddExerciseData(
                                            exerciseIndex,
                                            sets,
                                            weight,
                                            reps,
                                            0);
                                        sets = sets + 1;
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(
                                        35), // Matches the container's border radius
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.primaryColor
                                                .withOpacity(0.9),
                                            AppColors.primaryColor
                                                .withOpacity(0.7),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(35),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 45,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  Container(
                                    height: 0.5,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    width: media.width,
                                    color: Colors.black12,
                                  ),
                                  const SizedBox(height: 40),
                                  ButtonWidget(
                                    text: "Skip the exercise",
                                    textColor: const Color(0xFFFFFFFF),
                                    color: AppColors.secondColor,
                                    onPress: () {
                                      userData?.updateOrAddExerciseHistory(
                                          AppConstants.STATE_SKIPPED);
                                      vimeoVideoPlayer = null;
                                      Navigator.pushNamed(context, '/today');
                                      // Navigator.pushNamed(context, '/today');
                                    },
                                    isLoading: false,
                                  ),
                                  const SizedBox(height: 10),
                                  ButtonWidget(
                                    text: "Finish & Next",
                                    textColor: Colors.white,
                                    onPress: () {
                                      // userData?.updateOrAddDayHistory(AppConstants.STATE_FINISHED);
                                      userData?.updateOrAddExerciseHistory(
                                          AppConstants.STATE_FINISHED);
                                      // userData?.finishCurrentExercise();
                                      // tempData?.completeCurrentExercise();
                                      // Navigator.pushNamed(context, '/today');
                                      vimeoVideoPlayer = null;
                                      Navigator.pushNamed(context, '/today');
                                    },
                                    color: AppColors.primaryColor,
                                    isLoading: false,
                                  ),
                                  const SizedBox(height: 40),
                                  Container(
                                    height: 0.5,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    width: media.width,
                                    color: Colors.black12,
                                  ),
                                  const SizedBox(height: 40),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Equipment used',
                                          style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Consumer<UserDataProvider>(
                                    builder: (context, userData, child) {
                                      if (userData.allExercises.isNotEmpty) {
                                        return Column(
                                          children: List.generate(
                                            userData!
                                                .currentExerciseObj!
                                                .usedEquipments
                                                .length, // Assuming you want one card per exercise
                                            (index) => Column(
                                              children: [
                                                equipmentCard(
                                                    userData!
                                                        .currentExerciseObj!
                                                        .usedEquipments[index]
                                                        .title,
                                                    userData!
                                                        .currentExerciseObj!
                                                        .usedEquipments[index]
                                                        .description), // Replace with your actual widget logic
                                                if (index <
                                                    userData!
                                                            .currentExerciseObj!
                                                            .usedEquipments
                                                            .length -
                                                        1)
                                                  const SizedBox(height: 20),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    },
                                  ),
                                ] else ...[
                                  const SizedBox(height: 10),
                                  ButtonWidget(
                                    text: "Mark Complete",
                                    textColor: Colors.white,
                                    onPress: () {
                                      // userData?.updateOrAddDayHistory(AppConstants.STATE_FINISHED);
                                      // userData?.finishCurrentExercise();
                                      // tempData?.completeCurrentExercise();
                                      userData?.finishCurrentWarmUp();

                                      vimeoVideoPlayer = null;
                                      Navigator.pushNamed(context, '/today');
                                    },
                                    color: AppColors.primaryColor,
                                    isLoading: false,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
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

  Widget equipmentCard(String title, String description) {
    var media = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          // color: Color(0xFF000000),
          ),
      child: Stack(
        children: [
          Container(
            width: ScreenUtil.horizontalScale(100),
            height: ScreenUtil.verticalScale(11),
            margin: const EdgeInsets.symmetric(
                vertical: 15), // Padding around the background
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(ScreenUtil.verticalScale(7)),
              ),
            ),
            child: const SizedBox
                .expand(), // Ensure the background takes up all available space
          ),
          // Positioned image container on top of the background
          Positioned(
            left: 15, // Adjust as needed
            top: 5, // Adjust as needed
            child: Container(
              height: ScreenUtil.verticalScale(11) + 20, // Size of the image
              width: ScreenUtil.verticalScale(11) + 20,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/img/pp_4.png'),
                  fit: BoxFit.cover,
                  opacity: 1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(ScreenUtil.verticalScale(2)),
                ),
              ),
            ),
          ),
          // Text content or other widgets if needed
          Positioned(
            left: ScreenUtil.verticalScale(11) +
                45, // Adjust position based on image size and padding
            top: ScreenUtil.verticalScale(3.5) + 5, // Adjust as needed
            child: SizedBox(
              width: media.width / 2.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil.verticalScale(2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil.verticalScale(2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExerciseSetCard extends StatefulWidget {
  const ExerciseSetCard({
    super.key,
    required this.title,
    required this.isOpened,
    required this.exercise,
    required this.set,
    required this.weight,
    required this.reps,
    required this.repsInReverse,
    required this.restDuration,
  });

  final String title;
  final bool isOpened;
  final int exercise;
  final int set;
  final int weight;
  final int reps;
  final int repsInReverse;
  final int restDuration;

  @override
  State<ExerciseSetCard> createState() => _ExerciseSetCardState();
}

class _ExerciseSetCardState extends State<ExerciseSetCard> {
  int curExpandedIdx = 0;
  bool _isExpanded = false;
  bool _timerCompleted = false;
  int weight = 5;
  int reps = 5;
  int effort = 0;
  int _restDuration = 30;
  bool _showTimer = false;

  UserDataProvider? userData;

  List<String> effortValue = ["0", "1", "2", "3", "4+"];

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isOpened;
    userData = Provider.of<UserDataProvider>(context, listen: false);
    _showTimer = (userData?.showTimerIndex == widget.set);
    weight = widget.weight;
    reps = widget.reps;
    effort = widget.repsInReverse;
    _restDuration = widget.restDuration;
  }

  void _handleTimerComplete() {
    setState(() {
      _timerCompleted = true;
    });
  }

  void incrementWeight() {
    setState(() {
      weight = weight + 5;
    });
  }

  void decrementWeight() {
    setState(() {
      weight = (weight > 5) ? weight - 5 : 0;
    });
  }

  void incrementReps() {
    setState(() {
      reps = reps + 5;
    });
  }

  void decrementReps() {
    setState(() {
      reps = (reps > 5) ? reps - 5 : 0;
    });
  }

  void selectEffort(int value) {
    setState(() {
      effort = value;
    });
  }

  void _handleCloseTimer() {
    setState(() {
      _showTimer = false;
      userData?.setShowTimerIndex(-1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        ExpansionTileGroup(
          toggleType: ToggleType.expandOnlyCurrent,
          spaceBetweenItem: 15,
          onExpansionItemChanged: (idx, isExpand) {
            curExpandedIdx = idx;
          },
          children: [
            ExpansionTileItem(
              tilePadding: EdgeInsets.symmetric(
                horizontal: ScreenUtil.horizontalScale(4),
                vertical: ScreenUtil.verticalScale(0.3),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          widget.title,
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.primaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 50),
                        if (!_isExpanded)
                          Text(
                            '${widget.weight} lbs       ${widget.reps} reps',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.black38,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (_timerCompleted)
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.all(
                          ScreenUtil.verticalScale(0.5),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: 3,
                          ),
                          color: AppColors.primaryColor,
                        ),
                        child: Icon(
                          Icons.check,
                          size: ScreenUtil.verticalScale(2.2),
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              backgroundColor: const Color(0xFF0D0D0D),
              collapsedBackgroundColor: const Color(0xFF0D0D0D),
              decoration: _showTimer
                  ? BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft:
                            Radius.zero, // Set the bottom-left radius to zero
                        bottomRight:
                            Radius.zero, // Set the bottom-right radius to zero
                      ),
                      color: const Color.fromARGB(255, 248, 248, 248),
                    )
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 248, 248, 248),
                    ),
              iconColor: const Color(0xFFFAFAFA),
              collapsedIconColor: AppColors.primaryColor,
              initiallyExpanded: _isExpanded,
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _isExpanded = expanded;
                });
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up_outlined
                          : Icons.keyboard_arrow_down_outlined,
                      color: Colors.white,
                      size: 33,
                    ),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'WEIGHT (LB)',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 13),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.03),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil.horizontalScale(1.5),
                                  vertical: ScreenUtil.verticalScale(0.3),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      color: AppColors.primaryColor,
                                      onPressed: decrementWeight,
                                    ),
                                    SizedBox(
                                      width: 25,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            weight =
                                                int.tryParse(value) ?? weight;
                                          });
                                        },
                                        controller: TextEditingController()
                                          ..text = '$weight',
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      color: AppColors.primaryColor,
                                      onPressed: incrementWeight,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'REPS',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 13),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil.horizontalScale(1.5),
                                  vertical: ScreenUtil.verticalScale(0.3),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.03),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      color: AppColors.primaryColor,
                                      onPressed: decrementReps,
                                    ),
                                    SizedBox(
                                      width: 25,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            reps = int.tryParse(value) ?? reps;
                                          });
                                        },
                                        controller: TextEditingController()
                                          ..text = '$reps',
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      color: AppColors.primaryColor,
                                      onPressed: incrementReps,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'REPS IN RESERVE',
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(5, (index) {
                          return ChoiceChip(
                            label: Text(effortValue[index]),
                            selected: effort == index,
                            onSelected: (bool selected) {
                              selectEffort(selected ? index : 0);
                            },
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil.horizontalScale(2),
                              vertical: ScreenUtil.verticalScale(1),
                            ),
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white),
                            ),
                            backgroundColor: Colors.white,
                            selectedColor: AppColors.primaryColor,
                            labelStyle: TextStyle(
                              color:
                                  effort == index ? Colors.white : Colors.black,
                            ),
                            checkmarkColor: Colors
                                .white, // Set checkmark (icon) color to white when selected
                            showCheckmark:
                                true, // Ensure the checkmark is displayed when selected
                          );
                        }),
                      ),
                      const SizedBox(height: 15),
                      ButtonWidget(
                        text: "Save & start rest timer",
                        textColor: Colors.white,
                        onPress: () {
                          setState(() {
                            userData?.updateOrAddExerciseData(widget.exercise,
                                widget.set, weight, reps, effort);
                            userData?.setShowTimerIndex(widget.set);
                            _showTimer = true;
                          });
                        },
                        color: AppColors.primaryColor,
                        isLoading: false,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil.verticalScale(2),
                ),
              ],
            ),
          ],
        ),
        if (_showTimer) ...[
          TimerWithProgressBar(
            initialDuration: _restDuration,
            onClose: _handleCloseTimer,
            onComplete: _handleTimerComplete,
          ),
        ],
      ]),
    );
  }
}

class AddNoteBottomSheet extends StatefulWidget {
  @override
  _AddNoteBottomSheetState createState() => _AddNoteBottomSheetState();
}

class _AddNoteBottomSheetState extends State<AddNoteBottomSheet> {
  // Move the controller to the state class so it's not recreated on every build
  TextEditingController _noteController = TextEditingController();
  UserDataProvider? userData;

  @override
  void initState() {
    userData = Provider.of<UserDataProvider>(
      context,
      listen: false,
    );
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is removed to avoid memory leaks
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close Button
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context); // Close the modal
              },
            ),
          ),
          const SizedBox(height: 10),

          // Add a New Note text
          const Center(
            child: Text(
              "Add a New Note",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Multiline Text Box
          TextField(
            controller: _noteController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Enter your note here',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),

          // Save Note Button
          ButtonWidget(
            text: "Save Note",
            textColor: Colors.white,
            onPress: () {
              if (_noteController.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AppAlertDialog(
                      title: "",
                      description: "Please enter text in the input field.",
                    );
                  },
                );
              } else {
                userData?.addNewNote(_noteController.text);
                _noteController.clear();
              }
            },
            color: AppColors.primaryColor,
            isLoading: false,
          ),
          const SizedBox(height: 20),

          _buildPreviouslyAddedNotes(),
        ],
      ),
    );
  }

  Widget _buildPreviouslyAddedNotes() {
    return Consumer<UserDataProvider>(
      builder: (context, userData, child) => userData!.notesData.isEmpty
          ? const Text("No notes added yet.")
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Previously Added Notes:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // Use a ListView.builder to display each note with its date
                // Expanded(
                //   child: SingleChildScrollView(
                //     child: Column(
                //       children: List.generate(userData!.notesData.length, (index) {
                //         final note = userData!.notesData[userData!.notesData.length - 1 - index];
                //         return _buildNoteRow(note["date"]!, note["content"]!);
                //       }),
                //     ),
                //   ),
                // ),

                SizedBox(
                  height: 150, // You can adjust this height
                  child: ListView.builder(
                    itemCount: userData!.notesData
                        .where((note) =>
                            note['exercise_id'].toString() ==
                            userData.currentExercise.id)
                        .length,
                    itemBuilder: (context, index) {
                      final note = userData.notesData
                          .where((note) =>
                              note['exercise_id'].toString() ==
                              userData.currentExercise.id)
                          .toList()[userData!.notesData
                              .where((note) =>
                                  note['exercise_id'].toString() ==
                                  userData.currentExercise.id)
                              .length -
                          1 -
                          index];
                      return _buildNoteRow(note["date"]!, note["content"]!);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  // Build each note row with date, separator, and content
  Widget _buildNoteRow(String date, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date part
          Text(
            date,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),

          // Separator
          const Text('|'),
          const SizedBox(width: 10),

          // Note content part
          Expanded(
            child: Text(content),
          ),
        ],
      ),
    );
  }
}
