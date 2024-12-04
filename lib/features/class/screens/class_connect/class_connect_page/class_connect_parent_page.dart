import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_class_pal/core/constants/constant.dart';
import 'package:flutter_class_pal/core/utils/app_text_style.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/custom_list_item.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/loading_dialog.dart';
import '../../../../student/bloc/student/fetch/student_fetch_bloc.dart';

class ClassConnectParentPage extends StatelessWidget {
  const ClassConnectParentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: kMarginLg,
            ),
            Align(
              alignment: Alignment.center,
              child: BlocBuilder<StudentFetchBloc, StudentFetchState>(
                builder: (context, state) {
                  if (state is StudentFetchInProgress) {
                    return const LoadingDialog();
                  } else if (state is StudentFetchSuccess) {
                    var connectedStudents = state.students
                        .where((student) => student.parentId != null)
                        .toList();
                    var unconnectedStudents = state.students
                        .where((student) => student.parentId == null)
                        .toList();

                    return Column(
                      children: [
                        Text(
                          '${connectedStudents.length * 100 ~/ state.students.length}%',
                          style: AppTextStyle.semibold(
                              kTextSizeXxl, kPrimaryColor),
                        ),
                        const SizedBox(
                          height: kMarginMd,
                        ),
                        Text(
                          'Phụ huynh học sinh đã được kết nối',
                          style: AppTextStyle.semibold(kTextSizeXs),
                        ),
                        const SizedBox(
                          height: kMarginXxl,
                        ),
                        // Chưa kết nối
                        if (unconnectedStudents.isNotEmpty) ...[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Chưa kết nối (${unconnectedStudents.length})',
                              style: AppTextStyle.semibold(
                                  kTextSizeMd, kGreyColor),
                            ),
                          ),
                          const SizedBox(
                            height: kMarginMd,
                          ),
                          Column(
                            children: unconnectedStudents.map((student) {
                              return CustomListItem(
                                imageUrl: 'assets/images/family.jpg',
                                title: 'P/h của ${student.name}',
                                customTrailingWidget: Text(
                                  'Mời',
                                  style: AppTextStyle.semibold(
                                      kTextSizeSm, kPrimaryColor),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                        // Đã kết nối
                        if (connectedStudents.isNotEmpty) ...[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Đã kết nối (${connectedStudents.length})',
                              style: AppTextStyle.semibold(
                                  kTextSizeMd, kGreyColor),
                            ),
                          ),
                          const SizedBox(
                            height: kMarginMd,
                          ),
                          Column(
                            children: connectedStudents.map((student) {
                              return ListTile(
                                title: Text(student.name),
                                subtitle: Text('Đã kết nối'),
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    );
                  } else if (state is StudentFetchFailure) {
                    return Text(
                      'Error: ${state.error}',
                      style: AppTextStyle.semibold(kTextSizeXs, Colors.red),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            const SizedBox(
              height: kMarginMd,
            ),
          ],
        ),
      ),
    );
  }
}
