import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_class_pal/core/constants/constant.dart';
import 'package:flutter_class_pal/core/utils/app_text_style.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/custom_list_item.dart';
import 'package:flutter_class_pal/features/class/bloc/class_bloc.dart';
import 'package:flutter_class_pal/features/student/bloc/student/student_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClassAttendanceScreen extends StatefulWidget {
  const ClassAttendanceScreen({super.key});

  @override
  State<ClassAttendanceScreen> createState() => _ClassAttendanceScreenState();
}

class _ClassAttendanceScreenState extends State<ClassAttendanceScreen> {
  final TextEditingController _classNameController = TextEditingController();

  @override
  void dispose() {
    _classNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(kPaddingLg),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.all(Radius.circular(kBorderRadiusMd)),
        ),
        child: Column(
          children: [
            // Phần tiêu đề
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: const FaIcon(FontAwesomeIcons.xmark),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Center(
                  child: Text(
                    'Điểm danh',
                    style: AppTextStyle.bold(kTextSizeLg),
                  ),
                ),
                InkWell(
                  child: const FaIcon(FontAwesomeIcons.check),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: kMarginXxl),
            Text(
              'Thứ 5, 21 tháng 11',
              style: AppTextStyle.medium(kTextSizeLg, kGreyColor),
            ),
            const SizedBox(height: kMarginLg),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ContainerAttendance(
                  title: 'Đi học',
                  value: 0,
                  valueColor: kBlueColor,
                ),
                _ContainerAttendance(
                  title: 'Đi trễ',
                  value: 0,
                  valueColor: kOrangeColor,
                ),
                _ContainerAttendance(
                  title: 'Vắng',
                  value: 0,
                  valueColor: kRedColor,
                ),
              ],
            ),
            const SizedBox(height: kMarginLg),
            Text(
              'Đánh dấu cả lớp có mặt',
              style: AppTextStyle.semibold(kTextSizeMd, kPrimaryColor),
            ),
            const SizedBox(height: kMarginLg),
            BlocBuilder<StudentBloc, StudentState>(
              builder: (context, state) {
                if (state is StudentFetchInProgress) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is StudentFetchFailure) {
                  return Center(child: Text(state.error));
                } else if (state is StudentFetchSuccess) {
                  return Column(
                    children: state.students.map((student) {
                      return Column(
                        children: [
                          CustomListItem(
                            title: student.name,
                            imageUrl: student.gender == 'Nam'
                                ? 'assets/images/boy.jpg'
                                : 'assets/images/girl.jpg',
                            customTrailingWidget: Row(
                              children: [
                                Text(
                                  'Đi học',
                                  style: AppTextStyle.semibold(
                                      kTextSizeSm, kBlueColor),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: kMarginSm),
                        ],
                      );
                    }).toList(),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ContainerAttendance extends StatelessWidget {
  final String title;
  final int value;
  final Color valueColor;

  const _ContainerAttendance({
    super.key,
    required this.title,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kPaddingMd),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(kBorderRadiusMd)),
        border: Border.all(width: 1, color: kLightGreyColor),
      ),
      width: 100,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyle.semibold(kTextSizeMd, kGreyColor),
          ),
          Text(
            '$value',
            style: AppTextStyle.semibold(kTextSizeXxl, valueColor),
          ),
        ],
      ),
    );
  }
}
