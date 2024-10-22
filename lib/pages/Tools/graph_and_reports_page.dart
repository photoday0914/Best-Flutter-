import 'package:bbb/components/bar_chart_widget.dart';
import 'package:bbb/components/button_widget.dart';
import 'package:bbb/components/comparison_chart.dart';
import 'package:bbb/components/rep_line_chart.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:bbb/values/clip_path.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:bbb/components/back_arrow_widget.dart';

import '../../utils/screen_util.dart';

class GraphAndReportsPage extends StatefulWidget {
  const GraphAndReportsPage({super.key});

  @override
  State<GraphAndReportsPage> createState() => _GraphAndReportsPageState();
}

class _GraphAndReportsPageState extends State<GraphAndReportsPage> {
  String _selectExercise = "Select Exercise";
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
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BackArrowWidget(
                                          onPress: () =>
                                              {Navigator.pop(context)}),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: ScreenUtil.horizontalScale(8),
                                            top: ScreenUtil.horizontalScale(8)),
                                        child: Text(
                                          'Hi, Nick',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                ScreenUtil.horizontalScale(5.5),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            height: 22,
                                            width: 22,
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
                                              size: 25,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          ScreenUtil.horizontalScale(7)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(children: [
                                        const SizedBox(height: 4),
                                        SizedBox(
                                          width: media.width * 0.4,
                                          child: Text(
                                            "Here's some fun graphs for you",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  ScreenUtil.horizontalScale(
                                                      4.5),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil.horizontalScale(4),
                                        ),
                                      ]),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ScreenUtil.horizontalScale(2),
                                          vertical:
                                              ScreenUtil.horizontalScale(0.5),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil.verticalScale(5)),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black12,
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              offset: Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: DropdownButton<String>(
                                          value: _selectExercise,
                                          dropdownColor: Colors.white,
                                          icon: const Icon(Icons
                                              .keyboard_arrow_down_outlined),
                                          iconSize:
                                              ScreenUtil.horizontalScale(9),
                                          iconEnabledColor: Colors.grey[400],
                                          elevation: 16,
                                          isExpanded: true,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                ScreenUtil.horizontalScale(4.2),
                                          ),
                                          underline: Container(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _selectExercise = newValue!;
                                            });
                                          },
                                          items: <String>[
                                            'Select Exercise',
                                            'Chest Workout',
                                            'Leg Workout',
                                            'Arm Workout',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Row(
                                                children: [
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    value,
                                                    style: const TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: media.height / 3.35,
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
                  margin: EdgeInsets.only(top: media.height / 3.36),
                  child: Container(
                    width: media.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(ScreenUtil.horizontalScale(15)),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: ScreenUtil.horizontalScale(7)),
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: ScreenUtil.horizontalScale(3),
                            horizontal: ScreenUtil.horizontalScale(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Effort Per Day",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: ScreenUtil.verticalScale(2.3),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                height: ScreenUtil.verticalScale(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    ScreenUtil.verticalScale(2),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    items: [
                                      "Week 1",
                                      "Week 2",
                                      "Week 3",
                                      "Week 4"
                                    ]
                                        .map((name) => DropdownMenuItem(
                                              value: name,
                                              child: Text(
                                                name,
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xA09F9F9F),
                                                  fontSize: ScreenUtil
                                                      .horizontalScale(
                                                    3,
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {},
                                    icon: Icon(
                                      Icons.expand_more,
                                      color: const Color(0xA09F9F9F),
                                      size: ScreenUtil.verticalScale(3),
                                    ),
                                    hint: Text(
                                      "Week 1",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color(0xA09F9F9F),
                                        fontSize: ScreenUtil.verticalScale(2),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil.horizontalScale(10),
                          ),
                          child: BarChartWidget(),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: ScreenUtil.verticalScale(1.5),
                            horizontal: ScreenUtil.horizontalScale(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "1 Rep Max",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: ScreenUtil.verticalScale(2.3),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                height: ScreenUtil.verticalScale(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil.verticalScale(2)),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    items: [
                                      "Week 1",
                                      "Week 2",
                                      "Week 3",
                                      "Week 4"
                                    ]
                                        .map((name) => DropdownMenuItem(
                                              value: name,
                                              child: Text(
                                                name,
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xA09F9F9F),
                                                  fontSize:
                                                      ScreenUtil.verticalScale(
                                                          1.5),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {},
                                    icon: const Icon(
                                      Icons.expand_more,
                                      color: Color(0xA09F9F9F),
                                      size: 25,
                                    ),
                                    hint: Text(
                                      "Week",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: const Color(0xA09F9F9F),
                                          fontSize:
                                              ScreenUtil.verticalScale(2)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil.horizontalScale(10),
                          ),
                          child: const RepLineChart(),
                        ),
                        const SizedBox(height: 40),
                        Container(
                          margin: EdgeInsets.only(
                              left: ScreenUtil.horizontalScale(8)),
                          width: media.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Comparison Chart',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: ScreenUtil.horizontalScale(5),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Aggregate',
                                style: TextStyle(
                                  color: Color(0xFFDD1166),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil.horizontalScale(8),
                          ),
                          child: const ComparisonChart(),
                        ),
                        const SizedBox(height: 40),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil.horizontalScale(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: ScreenUtil.horizontalScale(3),
                                    right: ScreenUtil.horizontalScale(5),
                                    top: ScreenUtil.verticalScale(2),
                                    bottom: ScreenUtil.verticalScale(2),
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Weight Lifted',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize:
                                                ScreenUtil.horizontalScale(
                                                    3.6)),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '55 Kg',
                                        style: TextStyle(
                                          color: const Color(0xFFDD1166),
                                          fontSize:
                                              ScreenUtil.horizontalScale(5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: ScreenUtil.horizontalScale(3),
                                    right: ScreenUtil.horizontalScale(5),
                                    top: ScreenUtil.verticalScale(2),
                                    bottom: ScreenUtil.verticalScale(2),
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Weight Lifted',
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize:
                                              ScreenUtil.horizontalScale(3.6),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '55 Kg',
                                        style: TextStyle(
                                          color: const Color(0xFFDD1166),
                                          fontSize:
                                              ScreenUtil.horizontalScale(5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: media.width,
                          margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil.horizontalScale(8)),
                          child: Column(
                            children: [
                              ButtonWidget(
                                text: "Back To Tools",
                                textColor: const Color(0x30000000),
                                onPress: () {},
                                color: const Color(0xC8FFFFFF),
                                isLoading: false,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ButtonWidget(
                                text: 'Continue Workout',
                                textColor: Colors.white,
                                color: AppColors.primaryColor,
                                onPress: () {},
                                isLoading: false,
                              ),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
