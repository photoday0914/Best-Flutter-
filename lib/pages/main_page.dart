import 'package:bbb/pages/dashboard_page.dart';
import 'package:bbb/pages/MonthlyView/monthly_view_page.dart';
import 'package:bbb/pages/ProfileAndSettings/profile_settings_page.dart';
import 'package:bbb/pages/Tools/tools_page.dart';
import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/data_provider.dart';
import '../providers/user_data_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late UserDataProvider userData;

  // PageController for PageView
  late PageController _pageController;

  // List of pages
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    userData = Provider.of<UserDataProvider>(
      context,
      listen: false,
    );

    _pageController = PageController(initialPage: userData.activeTab);

    // Initialize pages list with the callback
    _pages = [
      DashboardPage(
        onNavigateToMonthlyView: () => navigateToMonthlyView(),
      ),
      MonthlyViewPage(
        onNavigateToHomeView: () => navigateToHomeView(),
      ),
      const ToolsPage(),
      const ProfileSettingsPage(),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // This method updates the selected tab index and navigates to the respective page
  void navigateBottomNavBar(int index) {
    userData.activeTab = index;
    userData.notifyListeners();
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void navigateToMonthlyView() {
    navigateBottomNavBar(1);
  }

  void navigateToHomeView() {
    navigateBottomNavBar(0);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // fully transparent status bar
        statusBarIconBrightness: Brightness.light, // dark icons for light background
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil.horizontalScale(15),
            vertical: ScreenUtil.verticalScale(2),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil.verticalScale(1),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ScreenUtil.verticalScale(5)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    navigateBottomNavBar(0);
                  },
                  icon: Consumer<UserDataProvider>(
                    builder: (context, userData, child) =>
                      SvgPicture.asset(
                      'assets/img/1-home.svg',
                      color: userData.activeTab == 0
                          ? AppColors.primaryColor
                          : Colors.grey,
                      width: ScreenUtil.horizontalScale(8.5),
                      height: ScreenUtil.horizontalScale(8.5),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    navigateBottomNavBar(1);
                  },
                  icon: Consumer<UserDataProvider>(
                    builder: (context, userData, child) =>
                        SvgPicture.asset(
                      'assets/img/2-calendar.svg',
                      color: userData.activeTab == 1
                          ? AppColors.primaryColor
                          : Colors.grey,
                      width: ScreenUtil.horizontalScale(8.5),
                      height: ScreenUtil.horizontalScale(8.5),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    navigateBottomNavBar(2);
                  },
                  icon: Consumer<UserDataProvider>(
                    builder: (context, userData, child) =>
                        SvgPicture.asset(
                      'assets/img/3-statistics.svg',
                      color: userData.activeTab == 2
                          ? AppColors.primaryColor
                          : Colors.grey,
                      width: ScreenUtil.horizontalScale(8.5),
                      height: ScreenUtil.horizontalScale(8.5),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    navigateBottomNavBar(3);
                  },
                  icon: Consumer<UserDataProvider>(
                    builder: (context, userData, child) =>
                        SvgPicture.asset(
                      'assets/img/4-account.svg',
                      color: userData.activeTab == 3
                          ? AppColors.primaryColor
                          : Colors.grey,
                      width: ScreenUtil.horizontalScale(9),
                      height: ScreenUtil.horizontalScale(9),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
              userData.activeTab = index;
              userData.notifyListeners();
          },
          physics: const NeverScrollableScrollPhysics(),
          children: _pages,
        ),
      ),
    );
  }
}
