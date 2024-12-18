import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/loading_dialog.dart';
import 'package:flutter_class_pal/features/class/widgets/custom_grid_subject_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../bloc/subject/subject_cubit.dart';

class ClassScoreScreen extends StatefulWidget {
  const ClassScoreScreen({super.key});

  @override
  State<ClassScoreScreen> createState() => _ClassScoreScreenState();
}

class _ClassScoreScreenState extends State<ClassScoreScreen> {
  @override
  void initState() {
    context.read<SubjectCubit>().fetchSubjects();
    super.initState();
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
                  'Danh sách môn học',
                  style: AppTextStyle.bold(kTextSizeLg),
                ),
              ),
            ],
          ),
          const SizedBox(height: kMarginLg),
          BlocBuilder<SubjectCubit, SubjectState>(
            builder: (context, state) {
              if (state is SubjectFetchInProgress) {
                return const LoadingDialog();
              } else if (state is SubjectFetchSuccess) {
                return Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double itemHeight = 80;
                      double itemWidth = (constraints.maxWidth - 20) / 2;
                      return GridView.builder(
                        padding: const EdgeInsets.only(top: 8),
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: kMarginLg,
                          mainAxisSpacing: kMarginLg,
                          childAspectRatio: itemWidth / itemHeight,
                        ),
                        itemCount: state.subjects.length + 1,
                        itemBuilder: (context, index) {
                          if (index == state.subjects.length) {
                            return const CustomGridSubjectItem(
                                isAddButton: true);
                          }
                          final subject = state.subjects[index];
                          return CustomGridSubjectItem(
                            subject: subject,
                          );
                        },
                      );
                    },
                  ),
                );
              } else if (state is SubjectFetchFailure) {
                return Center(
                  child: Text('Error: ${state.error}'),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}