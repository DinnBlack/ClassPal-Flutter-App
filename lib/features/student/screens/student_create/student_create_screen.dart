import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_class_pal/core/constants/constant.dart';
import 'package:flutter_class_pal/core/utils/app_text_style.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/custom_button.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/custom_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/state/app_state.dart';
import '../../../../core/widgets/common_widget/loading_dialog.dart';
import '../../../../core/widgets/normal_widget/custom_button_camera.dart';
import '../../bloc/student/student_bloc.dart';

class StudentCreateScreen extends StatefulWidget {
  const StudentCreateScreen({super.key});

  @override
  State<StudentCreateScreen> createState() => _StudentCreateScreenState();
}

class _StudentCreateScreenState extends State<StudentCreateScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  bool _isValid = false;
  File? _selectedImage;

  @override
  void dispose() {
    _fullNameController.dispose();
    _genderController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  // Validation function
  bool _validateInputs() {
    final fullName = _fullNameController.text.trim();
    final gender = _genderController.text.trim();
    final dob = _dobController.text.trim();
    return fullName.isNotEmpty && gender.isNotEmpty && dob.isNotEmpty;
  }

  // Upload image to Firebase Storage
  Future<String?> _uploadImage(File image) async {
    try {
      // Generate a unique file name
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = FirebaseStorage.instance.ref().child('${AppState.getClass()?.classId}/$fileName');

      // Upload the file
      await storageRef.putFile(image);

      // Get the download URL
      String downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kPaddingLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(kBorderRadiusMd)),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  child: const FaIcon(FontAwesomeIcons.xmark),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Center(
                child: Text(
                  'Thêm học sinh',
                  style: AppTextStyle.bold(kTextSizeLg),
                ),
              ),
            ],
          ),
          const SizedBox(height: kMarginXl),
          CustomButtonCamera(
            onImagePicked: (image) {
              setState(() {
                _selectedImage = image;
              });
            },
          ),
          const SizedBox(height: kMarginMd),

          // Full Name Field
          CustomTextField(
            controller: _fullNameController,
            text: 'Họ và tên',
            autofocus: true,
            onChanged: (value) {
              setState(() {
                _isValid = _validateInputs();
              });
            },
          ),
          const SizedBox(height: kMarginMd),

          // Gender Field
          CustomTextField(
            controller: _genderController,
            text: 'Giới tính',
            options: ["Nam", "Nữ"],
            onChanged: (value) {
              setState(() {
                _isValid = _validateInputs();
              });
            },
          ),
          const SizedBox(height: kMarginMd),

          // Date of Birth Field
          CustomTextField(
            controller: _dobController,
            text: 'Ngày sinh',
            isDateTimePicker: true,
            onChanged: (value) {
              setState(() {
                _isValid = _validateInputs();
              });
            },
          ),
          const SizedBox(height: kMarginMd),

          // Button to Create Student
          BlocConsumer<StudentBloc, StudentState>(
            listener: (context, state) {
              if (state is StudentCreateInProgress) {
                LoadingDialog.showLoadingDialog(context);
              } else if (state is StudentCreateSuccess ||
                  state is StudentCreateFailure) {
                LoadingDialog.hideLoadingDialog(context);

                if (state is StudentCreateSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Học sinh đã được tạo thành công')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tạo học sinh thất bại')),
                  );
                }

                Navigator.pop(context);
                context.read<StudentBloc>().add(StudentResetStarted());
              }
            },
            builder: (context, state) {
              return CustomButton(
                text: 'Tạo',
                onPressed: _isValid
                    ? () async {
                  final fullName = _fullNameController.text.trim();
                  final gender = _genderController.text.trim();
                  final dob = _dobController.text.trim();

                  if (fullName.isNotEmpty &&
                      gender.isNotEmpty &&
                      dob.isNotEmpty) {
                    String? imageUrl;
                    if (_selectedImage != null) {
                      imageUrl = await _uploadImage(_selectedImage!);
                    }

                    context.read<StudentBloc>().add(StudentCreateStarted(
                      name: fullName,
                      gender: gender,
                      birthDate: dob,
                      image: imageUrl,
                    ));
                  }
                }
                    : null,
                backgroundColor:
                _isValid ? kPrimaryColor : kPrimaryColor.withOpacity(0.5),
              );
            },
          ),
        ],
      ),
    );
  }
}
