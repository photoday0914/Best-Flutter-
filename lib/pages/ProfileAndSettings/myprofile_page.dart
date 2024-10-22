import 'dart:io';

import 'package:bbb/utils/screen_util.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:bbb/values/clip_path.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:bbb/components/button_widget.dart';
import 'package:bbb/components/back_arrow_widget.dart';

import 'package:bbb/providers/user_data_provider.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  String? _imageUrl;
  DateTime? selectedDate;
  String? selectedWeight;
  String? selectedGender;
  String? selectedHeight;
  String? selectedLocation;
  String? _id;

  UserDataProvider? userData;

  final List<String> weightOptions = [
    '100 lbs',
    '110 lbs',
    '121 lbs',
    '130 lbs',
    '140 lbs',
  ];

  final List<String> genderOptions = ['Female', 'Male', 'Other'];
  final List<String> heightOptions = [
    '5\'0"',
    '5\'5"',
    '6\'0"',
    '6\'5"'
  ]; // Example heights
  final List<String> locationOptions = [
    'New York',
    'Los Angeles',
    'Chicago'
  ]; // Example locations

  @override
  void initState() {
    _fetchUserData();
    super.initState();
  }

  Future<void> _fetchUserData() async {
    try {
      final userData = await UserDataProvider().fetchUserInfo();
      debugPrint(userData.toString());
      setState(() {
        selectedDate = DateTime.parse(userData['dob']);
        selectedWeight = '${userData['weight']} lbs';
        selectedGender = genderOptions[userData['sex']];
        selectedHeight = '${userData['height']}\'0"';
        selectedLocation = userData['location'];
        _imageUrl = userData['avatarUrl'];
        _id = userData['_id'];
      });
    } catch (e) {
      print('Failed to load user data: $e');
    }
  }

  Future<void> _saveUserData() async {
    final userDetails = {
      'firstName': 'Nick',
      'lastName': 'Vlacic',
      'sex': genderOptions.indexOf(selectedGender!),
      'dob': selectedDate!.toIso8601String(),
      'weight': int.parse(selectedWeight!.split(' ')[0]),
      'height': int.parse(selectedHeight!.split('\'')[0]),
      'location': selectedLocation,
      'avatarUrl': _imageUrl ?? '',
    };
    print('HERE IS USERDETAIL##, $userDetails');

    if (_id != null) {
      await UserDataProvider().updateUserInfo(_id!, userDetails);
    } else {
      print("Error: User ID is null");
    }
  }

  Future<void> _pickAndUploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File file = File(image.path);
      String fileName = basename(image.path);

      try {
        Reference storageRef =
            FirebaseStorage.instance.ref().child('profile_images/$fileName');
        await storageRef.putFile(file);
        String downloadUrl = await storageRef.getDownloadURL();

        setState(() {
          _imageUrl = downloadUrl;
        });
      } catch (e) {
        print("Error uploading image: $e");
      }
    }
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
                          height: media.height / 1.5,
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
                          height: media.height / 1.5,
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
                                  margin: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil.horizontalScale(3),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BackArrowWidget(
                                          onPress: () =>
                                              {Navigator.pop(context)}),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _pickAndUploadImage,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal:
                                          ScreenUtil.horizontalScale(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height:
                                              ScreenUtil.horizontalScale(25),
                                          width: ScreenUtil.horizontalScale(25),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                ScreenUtil.horizontalScale(
                                                    12.5),
                                              ),
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              ScreenUtil.horizontalScale(12.5),
                                            ),
                                            child: _imageUrl == null
                                                ? Image.asset(
                                                    'assets/img/profile.png',
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.network(
                                                    _imageUrl!,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil.horizontalScale(5),
                                        ),
                                        Text(
                                          'Nick Vlacic',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                ScreenUtil.horizontalScale(8),
                                            fontWeight: FontWeight.bold,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: media.height / 2.64,
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
                    top: media.height / 2.65,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProfileField(
                          context: context,
                          label: 'Birthday',
                          value: selectedDate != null
                              ? DateFormat('MM/dd/yyyy').format(selectedDate!)
                              : '9/21/1998',
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime(1998, 9, 21),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null &&
                                pickedDate != selectedDate) {
                              setState(() {
                                selectedDate = pickedDate;
                              });
                            }
                          },
                        ),
                        _buildDropdownField(
                          context: context,
                          label: 'Gender',
                          value: selectedGender,
                          options: genderOptions,
                          hint: 'Female',
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedGender = newValue!;
                            });
                          },
                        ),
                        _buildDropdownField(
                          context: context,
                          label: 'Location',
                          value: selectedLocation,
                          options: locationOptions,
                          hint: 'Location',
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLocation = newValue!;
                            });
                          },
                        ),
                        _buildDropdownField(
                          context: context,
                          label: 'Height',
                          value: selectedHeight,
                          options: heightOptions,
                          hint: '6\'0"',
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedHeight = newValue!;
                            });
                          },
                        ),
                        _buildDropdownField(
                          context: context,
                          label: 'Weight',
                          value: selectedWeight,
                          options: weightOptions,
                          hint: '81 lbs',
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedWeight = newValue!;
                            });
                          },
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: ScreenUtil.verticalScale(4),
                            horizontal: ScreenUtil.horizontalScale(10),
                          ),
                          child: ButtonWidget(
                            text: "Save",
                            textColor: Colors.white,
                            onPress: _saveUserData,
                            color: AppColors.primaryColor,
                            isLoading: false,
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

// Profile Field for Birthday and Other Text Inputs
  Widget _buildProfileField({
    required BuildContext context,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(
        left: ScreenUtil.horizontalScale(12),
        right: ScreenUtil.horizontalScale(12),
        bottom: ScreenUtil.verticalScale(0.8),
        top: ScreenUtil.verticalScale(3.5),
      ),
      height: ScreenUtil.verticalScale(6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil.horizontalScale(1),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    ScreenUtil.verticalScale(5),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x20888888),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Center(
                  // Center the text
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center, // Align the text at the center
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// Dropdown Field for Gender, Location, etc.
  Widget _buildDropdownField({
    required BuildContext context,
    required String label,
    required String? value,
    required List<String> options,
    required String hint,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil.horizontalScale(12),
          vertical: ScreenUtil.verticalScale(0.8)),
      height: ScreenUtil.verticalScale(6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil.horizontalScale(1),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  ScreenUtil.verticalScale(5),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x20888888),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Center(
                // Center the dropdown content
                child: DropdownButton<String>(
                  value: value,
                  hint: Text(hint),
                  isExpanded: true,
                  alignment:
                      Alignment.center, // Align the dropdown text to the center
                  items: options.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Center(
                        // Center the individual items in dropdown
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                  underline: Container(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
