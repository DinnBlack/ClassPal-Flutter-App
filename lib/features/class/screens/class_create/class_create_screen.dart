import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_class_pal/core/constants/constant.dart';
import 'package:flutter_class_pal/core/utils/app_text_style.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/custom_button.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/custom_text_field.dart';
import 'package:flutter_class_pal/features/class/bloc/class_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/widgets/common_widget/loading_dialog.dart';
import '../../../../core/widgets/normal_widget/custom_button_camera.dart';

class ClassCreateScreen extends StatefulWidget {
  const ClassCreateScreen({super.key});

  @override
  State<ClassCreateScreen> createState() => _ClassCreateScreenState();
}

class _ClassCreateScreenState extends State<ClassCreateScreen> {
  // Tạo controller để lấy giá trị tên lớp học
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
                  'Thêm lớp học',
                  style: AppTextStyle.bold(kTextSizeLg),
                ),
              ),
            ],
          ),
          const SizedBox(height: kMarginXl),
          CustomButtonCamera(),
          const SizedBox(height: kMarginMd),
          CustomTextField(
            controller: _classNameController,
            text: 'Tên lớp học',
            autofocus: true,
          ),
          const SizedBox(height: kMarginMd),
          BlocConsumer<ClassBloc, ClassState>(
            listener: (context, state) {
              if (state is ClassCreateSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Lớp học đã được tạo thành công')),
                );
                Navigator.pop(context);
                context.read<ClassBloc>().add(ClassResetStarted());
              } else if (state is ClassCreateFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tạo lớp học thất bại')),
                );
                context.read<ClassBloc>().add(ClassResetStarted());
              }
            },
            builder: (context, state) {
              if (state is ClassCreateInProgress) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const LoadingDialog();
                    },
                  );
                });
              } else if (state is ClassCreateSuccess ||
                  state is ClassCreateFailure) {
                Navigator.pop(context);
              }

              return Column(
                children: [
                  CustomButton(
                    text: 'Tạo',
                    onPressed: () {
                      final className = _classNameController.text.trim();
                      if (className.isNotEmpty) {
                        context
                            .read<ClassBloc>()
                            .add(ClassCreateStarted(className: className));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Vui lòng nhập tên lớp học')),
                        );
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
