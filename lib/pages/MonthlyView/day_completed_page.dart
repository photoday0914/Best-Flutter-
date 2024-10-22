import 'package:bbb/components/activity_line_chart.dart';
import 'package:bbb/components/button_widget.dart';
import 'package:bbb/components/icon_row_with_dot.dart';
// import 'package:bbb/storage/userdata_manager.dart';
import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:bbb/values/clip_path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:bbb/providers/data_provider.dart';
import 'package:bbb/providers/user_data_provider.dart';
import 'package:flutter/widgets.dart';

class DayCompletedPage extends StatefulWidget {
  const DayCompletedPage({super.key});

  @override
  State<DayCompletedPage> createState() => _DayCompletedPageState();
}

class _DayCompletedPageState extends State<DayCompletedPage> {
  UserDataProvider? userData;
  late int totalWeight = 0;

  @override
  void initState() {
    super.initState();
    _loadValue();
  }

  Future<void> _loadValue() async {
    userData = Provider.of<UserDataProvider>(context, listen: false); // Use listen: false here
    totalWeight = await userData!.calculateTotalWeightForDay(); // Awaiting the Future<int>
    setState(() {}); // Update the state to reflect changes
  }

  @override
  Widget build(BuildContext context) {
    final currentDay = ModalRoute.of(context)!.settings.arguments as int;
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
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        decoration: const BoxDecoration(
                                          color: Color(0XFFd18a9b),
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          icon: const Icon(Icons.keyboard_arrow_left,
                                              color: Colors.white),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          iconSize: ScreenUtil.verticalScale(4),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(ScreenUtil.verticalScale(0.5)),
                                            decoration: BoxDecoration(
                                              color: Colors.black12,
                                              shape: BoxShape.circle,
                                              border: Border.all(color: Colors.white),
                                            ),
                                            child: Text(
                                              '0',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: ScreenUtil.verticalScale(1),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context, '/streak');
                                            },
                                            child: Icon(
                                              Icons.local_fire_department_outlined,
                                              color: Colors.white,
                                              size: ScreenUtil.verticalScale(3),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.notifications_none,
                                              color: Colors.white,
                                              size: ScreenUtil.verticalScale(3),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil.horizontalScale(5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: ScreenUtil.horizontalScale(10)),
                                      Text(
                                        'Congratulations!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil.horizontalScale(8.5),
                                          fontWeight: FontWeight.bold,
                                          height: 1,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'You completed Day $currentDay',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil.verticalScale(2.4),
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
                          height: media.height / 2.79,
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
                  margin: EdgeInsets.only(top: media.height / 2.8),
                  child: Container(
                    width: media.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(ScreenUtil.horizontalScale(15)),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: media.height / 19),
                      child: Column(
                        children: [
                          const IconRowWithDot(),
                          SizedBox(height: ScreenUtil.horizontalScale(6)),
                          Text(
                            "Here's an overview of your today's workout.",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: ScreenUtil.horizontalScale(3.6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Now recover and get ready for tomorrow",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: ScreenUtil.horizontalScale(3.6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: ScreenUtil.horizontalScale(3)),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil.horizontalScale(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(ScreenUtil.verticalScale(2)),
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
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.bolt,
                                              color: Colors.black38,
                                              size: ScreenUtil.horizontalScale(5),
                                            ),
                                            Text(
                                              "Today's Activity",
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: ScreenUtil.horizontalScale(3.3),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: ScreenUtil.horizontalScale(2)),
                                        const ActivityLineChart(),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil.verticalScale(3.5),
                                        vertical: ScreenUtil.verticalScale(2),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(ScreenUtil.verticalScale(3)),
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Weight Lifted',
                                            style: TextStyle(color: Colors.black54),
                                          ),
                                          SizedBox(height: 10),                                          
                                          Text(
                                            '$totalWeight Kg', // Display totalWeight
                                            style: TextStyle(
                                              color: Color(0xFFDD1166),
                                              fontSize: 20,
                                            ),
                                          ),                                                 
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            ScreenUtil.verticalScale(3.5),
                                        vertical: ScreenUtil.verticalScale(2),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            ScreenUtil.verticalScale(3),
                                          ),
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Weight Lifted',
                                            style: TextStyle(
                                              color: Colors.black54,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            '55 Kg',
                                            style: TextStyle(
                                              color: Color(0xFFDD1166),
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                           Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ScreenUtil.horizontalScale(7)),
                            child: ButtonWidget(
                              text: "Back to Dashboard",
                              textColor: const Color(0x40000000),
                              onPress: () {
                                Navigator.pushNamed(context, '/home');
                              },
                              color: const Color(0xC0FFFFFF),
                              isLoading: false,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ScreenUtil.horizontalScale(7)),
                            child: ButtonWidget(
                              text: "Next Workout",
                              textColor: Colors.white,
                              onPress: () {
                                Navigator.pushNamed(context, '/home');
                              },
                              color: AppColors.primaryColor,
                              isLoading: false,
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
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.black54),
          const SizedBox(width: 8),
          Container(
            constraints: BoxConstraints(maxWidth: media.width / 1.4),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}