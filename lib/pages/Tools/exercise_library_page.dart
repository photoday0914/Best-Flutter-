import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:bbb/values/clip_path.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:bbb/components/back_arrow_widget.dart';

class ExerciseLibraryPage extends StatefulWidget {
  const ExerciseLibraryPage({super.key});

  @override
  State<ExerciseLibraryPage> createState() => _ExerciseLibraryPageState();
}

class _ExerciseLibraryPageState extends State<ExerciseLibraryPage> {
  final int _numPages = 20;
  int _currentPage = 0;
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
                          height: media.height / 2.2,
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
                          height: media.height / 2.2,
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
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BackArrowWidget(
                                          onPress: () =>
                                              {Navigator.pop(context)}),
                                      Text(
                                        'Exercise Library',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              ScreenUtil.horizontalScale(5.5),
                                        ),
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
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil.horizontalScale(7),
                                  ),
                                  height: media.height * 0.2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: ScreenUtil.horizontalScale(1),
                                      ),
                                      const SearchExerciseField(),
                                      SizedBox(
                                        height: ScreenUtil.horizontalScale(3),
                                      ),
                                      const FilterSortButton(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: media.height / 3.19,
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
                  margin: EdgeInsets.only(top: media.height / 3.2),
                  child: Container(
                    width: media.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
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
                                SizedBox(
                                  height: ScreenUtil.verticalScale(2),
                                ),
                                exerciseCard(
                                  'Smith Machine Glute Bridge',
                                ),
                                SizedBox(
                                  height: ScreenUtil.verticalScale(2),
                                ),
                                exerciseCard(
                                  'Smith Machine Glute Bridge',
                                ),
                                SizedBox(
                                  height: ScreenUtil.verticalScale(2),
                                ),
                                exerciseCard(
                                  'Smith Machine Glute Bridge',
                                ),
                                SizedBox(
                                  height: ScreenUtil.verticalScale(2),
                                ),
                                exerciseCard(
                                  'Smith Machine Glute Bridge',
                                ),
                                SizedBox(
                                  height: ScreenUtil.verticalScale(2),
                                ),
                                exerciseCard(
                                  'Smith Machine Glute Bridge',
                                ),
                                SizedBox(
                                  height: ScreenUtil.verticalScale(2),
                                ),
                                exerciseCard(
                                  'Smith Machine Glute Bridge',
                                ),
                                SizedBox(
                                  height: ScreenUtil.verticalScale(2),
                                ),
                                exerciseCard(
                                  'Smith Machine Glute Bridge',
                                ),
                                SizedBox(
                                  height: ScreenUtil.verticalScale(2),
                                ),
                                exerciseCard(
                                  'Smith Machine Glute Bridge',
                                ),
                                SizedBox(
                                  height: ScreenUtil.verticalScale(2),
                                ),
                                exerciseCard(
                                  'Smith Machine Glute Bridge',
                                ),
                                SizedBox(
                                  height: ScreenUtil.verticalScale(2),
                                ),
                                exerciseCard(
                                  'Smith Machine Glute Bridge',
                                ),
                                SizedBox(
                                  height: ScreenUtil.verticalScale(2),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: NumberPaginator(
                                    numberPages: _numPages,
                                    config: const NumberPaginatorUIConfig(
                                      height: 48,
                                      buttonSelectedForegroundColor:
                                          AppColors.primaryColor,
                                      buttonUnselectedForegroundColor:
                                          Colors.grey,
                                      buttonUnselectedBackgroundColor:
                                          Colors.transparent,
                                      buttonSelectedBackgroundColor:
                                          Colors.transparent,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      buttonTextStyle: TextStyle(fontSize: 15),
                                    ),
                                    onPageChange: (int index) {
                                      setState(() {
                                        _currentPage = index;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        )
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

  Widget exerciseCard(String title) {
    var media = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(right: ScreenUtil.horizontalScale(5)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(ScreenUtil.verticalScale(8)),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                height: media.width / 4,
                width: media.width / 4,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/img/library_placeholder.png'),
                    fit: BoxFit.cover,
                    opacity: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ScreenUtil.verticalScale(8)),
                    bottomLeft: Radius.circular(ScreenUtil.verticalScale(8)),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: media.width / 2.5,
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: ScreenUtil.horizontalScale(4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil.verticalScale(0.7),
              vertical: ScreenUtil.verticalScale(0.7),
            ),
            decoration: const BoxDecoration(
                color: AppColors.primaryColor, shape: BoxShape.circle),
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: ScreenUtil.verticalScale(3),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchExerciseField extends StatelessWidget {
  const SearchExerciseField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil.horizontalScale(3),
          vertical: ScreenUtil.horizontalScale(1)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ScreenUtil.verticalScale(6)),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: 'Search Exercise',
          hintStyle: TextStyle(
            color: Colors.black45,
            fontSize: ScreenUtil.verticalScale(2),
          ),
          suffixIcon: Icon(
            Icons.search,
            size: ScreenUtil.verticalScale(4),
            color: Colors.grey[300],
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            // vertical: ScreenUtil.verticalScale(1),
            horizontal: ScreenUtil.horizontalScale(2),
          ),
        ),
      ),
    );
  }
}

class FilterSortButton extends StatelessWidget {
  const FilterSortButton({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return SizedBox(
      width: media.width,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF9a354e),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScreenUtil.verticalScale(6)),
          ),
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtil.horizontalScale(3.5),
              horizontal: ScreenUtil.horizontalScale(4)),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.tune,
              color: Colors.white70,
              size: 25,
            ),
            const SizedBox(width: 20),
            Container(
              height: 35,
              width: 0.5,
              decoration: const BoxDecoration(color: Colors.white70),
            ),
            const SizedBox(width: 65),
            const Text(
              'Filter & Sort',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
