import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_class_pal/core/constants/constant.dart';
import 'package:flutter_class_pal/core/utils/app_text_style.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/custom_button.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/custom_text_field.dart';
import 'package:flutter_class_pal/features/class/bloc/class_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/widgets/common_widget/loading_dialog.dart';

class ClassJoinScreen extends StatefulWidget {
  const ClassJoinScreen({super.key});

  @override
  State<ClassJoinScreen> createState() => _ClassJoinScreenState();
}

class _ClassJoinScreenState extends State<ClassJoinScreen> {
  final TextEditingController _classNameController = TextEditingController();

  @override
  void dispose() {
    _classNameController.dispose();
    super.dispose();
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
                  'Tham gia lớp',
                  style: AppTextStyle.bold(kTextSizeLg),
                ),
              ),
            ],
          ),
          const SizedBox(height: kMarginXl),
          CustomTextField(
            controller: _classNameController,
            text: 'Mã lớp học',
            autofocus: true,
          ),
          const SizedBox(height: kMarginMd),
          BlocConsumer<ClassBloc, ClassState>(
            listener: (context, state) {
              if (state is ClassJoinInProgress) {
                LoadingDialog.showLoadingDialog(context);
              } else if (state is ClassJoinSuccess ||
                  state is ClassJoinFailure) {
                LoadingDialog.hideLoadingDialog(context);

                if (state is ClassJoinSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Tham gia lớp học thành công')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tham gia lớp học thất bại')),
                  );
                }

                Navigator.pop(context);
                context.read<ClassBloc>().add(ClassResetStarted());
              }
            },
            builder: (context, state) {
              return CustomButton(
                text: 'Tham gia',
                onPressed: () {
                  final classCode = _classNameController.text.trim();
                  if (classCode.isNotEmpty) {
                    context
                        .read<ClassBloc>()
                        .add(ClassJoinStarted(classId: classCode));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Vui lòng nhập mã lớp học')),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
