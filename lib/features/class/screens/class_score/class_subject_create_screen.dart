import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_class_pal/core/constants/constant.dart';
import 'package:flutter_class_pal/core/utils/app_text_style.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/custom_button.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/custom_text_field.dart';
import 'package:flutter_class_pal/features/class/data/class_firebase.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/widgets/common_widget/loading_dialog.dart';
import '../../../../core/widgets/normal_widget/custom_button_camera.dart';
import '../../bloc/subject/subject_cubit.dart';
import 'class_score_screen.dart';

class ClassSubjectCreateScreen extends StatefulWidget {
  const ClassSubjectCreateScreen({super.key});

  @override
  State<ClassSubjectCreateScreen> createState() =>
      _ClassSubjectCreateScreenState();
}

class _ClassSubjectCreateScreenState extends State<ClassSubjectCreateScreen> {
  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _scoreTypeController = TextEditingController();
  final List<String> _scoreTypes = [];

  @override
  void dispose() {
    _classNameController.dispose();
    _scoreTypeController.dispose();
    super.dispose();
  }

  void _addScoreType() {
    final scoreType = _scoreTypeController.text.trim();
    if (scoreType.isNotEmpty) {
      setState(() {
        _scoreTypes.add(scoreType);
        _scoreTypeController.clear();
      });
    }
  }

  void _removeScoreType(int index) {
    setState(() {
      _scoreTypes.removeAt(index);
    });
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
                  child: const FaIcon(FontAwesomeIcons.arrowLeft),
                  onTap: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return FractionallySizedBox(
                          alignment: Alignment.bottomCenter,
                          heightFactor: 0.95,
                          child: ClassScoreScreen(),
                        );
                      },
                    );
                  },
                ),
              ),
              Center(
                child: Text(
                  'Thêm môn học',
                  style: AppTextStyle.bold(kTextSizeLg),
                ),
              ),
            ],
          ),
          const SizedBox(height: kMarginXl),
          CustomButtonCamera(
            onImagePicked: (File? value) {},
          ),
          const SizedBox(height: kMarginMd),
          CustomTextField(
            controller: _classNameController,
            text: 'Tên môn học',
            autofocus: true,
          ),
          const SizedBox(height: kMarginMd),
          CustomTextField(
            controller: _scoreTypeController,
            text: 'Loại điểm',
            suffixIcon: IconButton(
              icon: const FaIcon(FontAwesomeIcons.check),
              onPressed: _addScoreType,
            ),
          ),
          const SizedBox(height: kMarginMd),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: kPaddingMd,
                mainAxisSpacing: kPaddingMd,
                childAspectRatio: 4,
              ),
              itemCount: _scoreTypes.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kBorderRadiusMd),
                    border: Border.all(color: kGreyColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _scoreTypes[index],
                        style: AppTextStyle.medium(kTextSizeSm),
                      ),
                      const SizedBox(width: kMarginMd),
                      InkWell(
                        child: const FaIcon(
                          FontAwesomeIcons.xmark,
                          color: kGreyColor,
                        ),
                        onTap: () => _removeScoreType(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: kMarginMd),
          BlocProvider(
            create: (context) => SubjectCubit(ClassFirebase()),
            child: BlocConsumer<SubjectCubit, SubjectState>(
              // Use SubjectCubit here
              listener: (context, state) {
                if (state is SubjectCreateInProgress) {
                  LoadingDialog.showLoadingDialog(context);
                } else if (state is SubjectCreateSuccess ||
                    state is SubjectCreateFailure) {
                  LoadingDialog.hideLoadingDialog(context);

                  if (state is SubjectCreateSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Môn học đã được tạo thành công')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tạo môn học thất bại')),
                    );
                  }
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return const FractionallySizedBox(
                        alignment: Alignment.bottomCenter,
                        heightFactor: 0.95,
                        child: ClassScoreScreen(),
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                return CustomButton(
                  text: 'Tạo',
                  onPressed: () {
                    if (_classNameController.text.isNotEmpty &&
                        _scoreTypes.isNotEmpty) {
                      context.read<SubjectCubit>().createSubject(
                            _classNameController.text.trim(),
                            _scoreTypes,
                          );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Vui lòng điền đầy đủ thông tin')),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
