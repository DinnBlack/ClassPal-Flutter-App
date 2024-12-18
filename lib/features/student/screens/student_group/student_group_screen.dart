import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/loading_dialog.dart';

import '../../../../core/constants/constant.dart';
import '../../bloc/student_group/student_group_bloc.dart';
import '../../widgets/grid_student_group_item.dart';
import '../student_group_create/student_group_create_screen.dart';

class StudentGroupListScreen extends StatefulWidget {
  static const route = 'StudentGroupListScreen';

  @override
  State<StudentGroupListScreen> createState() => _StudentGroupListScreenState();
}

class _StudentGroupListScreenState extends State<StudentGroupListScreen> {
  @override
  void initState() {
    super.initState();
    final studentGroupBloc = BlocProvider.of<StudentGroupBloc>(context);
    studentGroupBloc.add(StudentGroupFetchStarted());
    studentGroupBloc.fetchStream.listen((_) {
      studentGroupBloc.add(StudentGroupFetchStarted());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kPaddingMd),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return StreamBuilder<void>(
              stream: context.read<StudentGroupBloc>().fetchStream,
              builder: (context, snapshot) {
                final state = context.watch<StudentGroupBloc>().state;
                if (state is StudentGroupFetchInProgress) {
                  return const LoadingDialog();
                } else if (state is StudentGroupFetchFailure) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: GridStudentGroupItem(
                      group: null,
                      add: true,
                      onTapCallback: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return const FractionallySizedBox(
                              alignment: Alignment.bottomCenter,
                              heightFactor: 0.95,
                              child: StudentGroupCreateScreen(),
                            );
                          },
                        );
                      },
                    ),
                  );
                } else if (state is StudentGroupFetchSuccess) {
                  final groupData = state.studentGroups;

                  double itemHeight = 100;
                  double itemWidth = (constraints.maxWidth - (2 - 1) * 8.0) / 2;

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: itemWidth / itemHeight,
                    ),
                    itemCount: groupData.length + 1,
                    // Include "Add New" button
                    itemBuilder: (context, index) {
                      if (index < groupData.length) {
                        final group = groupData[index];
                        return GridStudentGroupItem(group: group);
                      } else {
                        // "Add New" button
                        return GridStudentGroupItem(
                          group: null,
                          add: true,
                          onTapCallback: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return const FractionallySizedBox(
                                  alignment: Alignment.bottomCenter,
                                  heightFactor: 0.95,
                                  child: StudentGroupCreateScreen(),
                                );
                              },
                            );
                          },
                        );
                      }
                    },
                  );
                } else {
                  return const Center(child: Text("No students available"));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
