import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bbb/providers/user_data_provider.dart';

class SelectDropdown1 extends StatefulWidget {
  final Function(String) onChange; // Callback function to be passed in

  const SelectDropdown1({super.key, required this.onChange});

  @override
  State<SelectDropdown1> createState() => _SelectDropdown1State();
}

class _SelectDropdown1State extends State<SelectDropdown1> {
  String _selectedEquipment = '3 Days per Week';
  UserDataProvider? userData;

  @override
  void initState() {
    userData = Provider.of<UserDataProvider>(
      context,
      listen: false,
    );

    _selectedEquipment =
    userData!.selectedDaySplit == "3" ? '3 Days per Week' :
    userData!.selectedDaySplit == "4" ? '4 Days per Week' : '5 Days per Week';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil.horizontalScale(3),
        vertical: ScreenUtil.verticalScale(0.2),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ScreenUtil.verticalScale(4)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x20888888),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: _selectedEquipment,
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        iconSize: ScreenUtil.verticalScale(4),
        iconEnabledColor: Colors.grey[400],
        elevation: 16,
        isExpanded: true,
        style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil.verticalScale(2),
        ),
        underline: Container(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedEquipment = newValue!;
            widget.onChange(
                newValue == '3 Days per Week'
                    ? '3'
                    : newValue == '4 Days per Week'
                    ? '4'
                    : '5'
            ); // Trigger the onChange callback
          });
        },
        items: <String>['3 Days per Week', '4 Days per Week', '5 Days per Week']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: ScreenUtil.verticalScale(2),
                  child: Text(
                    value == '3 Days per Week' ? '3' :
                    value == '4 Days per Week' ? '4' : '5',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil.verticalScale(2.5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  value,
                  style: TextStyle(
                    color: const Color(0xBB888888),
                    fontSize: ScreenUtil.verticalScale(1.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
