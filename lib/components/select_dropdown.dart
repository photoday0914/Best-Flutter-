import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bbb/providers/user_data_provider.dart';



class SelectDropdown extends StatefulWidget {
  final Function(String) onChange; // Callback function for when the value changes

  const SelectDropdown({Key? key, required this.onChange}) : super(key: key);

  @override
  State<SelectDropdown> createState() => _SelectDropdownState();
}

class _SelectDropdownState extends State<SelectDropdown> {
  String _selectedEquipment = 'Full Gym Access';

  UserDataProvider? userData;

  @override
  void initState() {
    userData = Provider.of<UserDataProvider>(
      context,
      listen: false,
    );

    _selectedEquipment =
        userData!.selectedExerciseFormat == "A" ? 'Full Gym Access' :
        userData!.selectedExerciseFormat == "B" ? 'Partial Gym Access' : 'No Gym Access';
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
          });
          widget.onChange(
              newValue == 'Full Gym Access'
              ? 'A'
              : newValue == 'Partial Gym Access'
              ? 'B'
              : 'C'
          ); // Trigger the onChange callback
        },
        items: <String>['Full Gym Access', 'Partial Gym Access', 'No Gym Access']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: ScreenUtil.verticalScale(2),
                  child: Text(
                    value == 'Full Gym Access'
                        ? 'A'
                        : value == 'Partial Gym Access'
                        ? 'B'
                        : 'C',
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
