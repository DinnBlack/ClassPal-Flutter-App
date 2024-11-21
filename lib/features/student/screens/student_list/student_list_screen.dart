import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/loading_dialog.dart';

import '../../../../core/constants/constant.dart';
import '../../bloc/student_bloc.dart';
import '../../widgets/grid_student_item.dart';
import '../student_create/student_create_screen.dart';

class StudentListScreen extends StatefulWidget {
  static const route = 'StudentListScreen';

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  @override
  void initState() {
    super.initState();
    final classBloc = BlocProvider.of<StudentBloc>(context);
    classBloc.add(StudentFetchStarted());
    classBloc.fetchStream.listen((_) {
      classBloc.add(StudentFetchStarted());
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
              stream: context.read<StudentBloc>().fetchStream,
              builder: (context, snapshot) {
                final state = context.watch<StudentBloc>().state;

                if (state is StudentFetchInProgress) {
                  return const LoadingDialog();
                } else if (state is StudentFetchFailure) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: GridStudentItem(
                      student: null,
                      add: true,
                      onTapCallback: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return const FractionallySizedBox(
                              alignment: Alignment.bottomCenter,
                              heightFactor: 0.95,
                              child: StudentCreateScreen(),
                            );
                          },
                        );
                      },
                    ),
                  );
                } else if (state is StudentFetchSuccess) {
                  final studentData = state.students;

                  double itemHeight = 100;
                  double itemWidth = (constraints.maxWidth - (4 - 1) * 8.0) / 4;

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: itemWidth / itemHeight,
                    ),
                    itemCount: studentData.length + 1,
                    // Include "Add New" button
                    itemBuilder: (context, index) {
                      if (index < studentData.length) {
                        final student = studentData[index];
                        return GridStudentItem(student: student);
                      } else {
                        // "Add New" button
                        return GridStudentItem(
                          student: null,
                          add: true,
                          onTapCallback: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return const FractionallySizedBox(
                                  alignment: Alignment.bottomCenter,
                                  heightFactor: 0.95,
                                  child: StudentCreateScreen(),
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
