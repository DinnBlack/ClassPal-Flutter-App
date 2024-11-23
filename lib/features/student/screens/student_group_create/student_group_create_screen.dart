import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_class_pal/core/constants/constant.dart';
import 'package:flutter_class_pal/core/utils/app_text_style.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/custom_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/widgets/common_widget/loading_dialog.dart';
import '../../bloc/student_group/student_group_bloc.dart';
import '../student_list/student_list_screen.dart';

class StudentGroupCreateScreen extends StatefulWidget {
  const StudentGroupCreateScreen({super.key});

  @override
  State<StudentGroupCreateScreen> createState() =>
      _StudentGroupCreateScreenState();
}

class _StudentGroupCreateScreenState extends State<StudentGroupCreateScreen> {
  final TextEditingController _groupNameController = TextEditingController();
  bool _isValid = false;
  List<String> selectedStudentIds = [];

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    final groupName = _groupNameController.text.trim();
    return groupName.isNotEmpty;
  }

  void _onStudentSelectionChanged(List<String> selectedIds) {
    setState(() {
      selectedStudentIds = selectedIds; // Update the selected student IDs
      _isValid = _validateInputs() && selectedIds.isNotEmpty;
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  'Tạo nhóm',
                  style: AppTextStyle.bold(kTextSizeLg),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: BlocConsumer<StudentGroupBloc, StudentGroupState>(
                  listener: (context, state) {
                    if (state is StudentGroupCreateInProgress) {
                      LoadingDialog.showLoadingDialog(context);
                    } else if (state is StudentGroupCreateSuccess ||
                        state is StudentGroupCreateFailure) {
                      LoadingDialog.hideLoadingDialog(context);

                      if (state is StudentGroupCreateSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tạo nhóm thành công')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tạo nhóm thất bại')),
                        );
                      }

                      Navigator.pop(context);
                      context
                          .read<StudentGroupBloc>()
                          .add(StudentGroupResetStarted());
                    }
                  },
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        context.read<StudentGroupBloc>().add(
                              StudentGroupCreateStarted(
                                groupName: _groupNameController.text.trim(),
                                studentIds: selectedStudentIds,
                              ),
                            );
                      },
                      child: const Icon(
                        FontAwesomeIcons.check,
                        color: kPrimaryColor,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: kMarginXxl),
          CustomTextField(
            controller: _groupNameController,
            text: 'Tên nhóm',
            autofocus: true,
            onChanged: (value) {
              setState(() {
                _isValid = _validateInputs() && selectedStudentIds.isNotEmpty;
              });
            },
          ),
          const SizedBox(height: kMarginMd),
          Text(
            'Thành viên',
            style: AppTextStyle.medium(kTextSizeMd),
          ),
          const SizedBox(height: kMarginMd),
          Expanded(
            child: StudentListScreen(
              isFetchWithoutGroup: true,
              paddingEnabled: false,
              onSelectionChanged: _onStudentSelectionChanged,
            ),
          ),
        ],
      ),
    );
  }
}
