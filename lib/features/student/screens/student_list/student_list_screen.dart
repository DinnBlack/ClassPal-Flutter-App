import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/loading_dialog.dart';

import '../../../../core/constants/constant.dart';
import '../../bloc/student/fetch/student_fetch_bloc.dart';
import '../../widgets/grid_student_item.dart';
import '../student_create/student_create_screen.dart';

class StudentListScreen extends StatefulWidget {
  final bool isFetchWithoutGroup;
  final Function(List<String>)? onSelectionChanged;
  final bool paddingEnabled;

  const StudentListScreen({
    Key? key,
    this.isFetchWithoutGroup = false,
    this.onSelectionChanged,
    this.paddingEnabled = true,
  }) : super(key: key);

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  Map<String, bool> selectedStudents = {};

  @override
  void initState() {
    super.initState();
    final classBloc = BlocProvider.of<StudentFetchBloc>(context);

    if (widget.isFetchWithoutGroup) {
      classBloc.add(StudentFetchWithoutGroupStarted());
    } else {
      classBloc.add(StudentFetchStarted());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.paddingEnabled
          ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return BlocBuilder<StudentFetchBloc, StudentFetchState>(
              builder: (context, state) {
                if (state is StudentFetchInProgress) {
                  return const LoadingDialog();
                } else if (state is StudentFetchFailure) {
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
                    onSelectionChanged: (isSelected) {},
                  );
                } else if (state is StudentFetchSuccess) {
                  final studentData = state.students;

                  double itemHeight = 100;
                  double itemWidth =
                      (constraints.maxWidth - (4 - 1) * 8.0) / 4;

                  return GridView.builder(
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: itemWidth / itemHeight,
                    ),
                    itemCount: widget.isFetchWithoutGroup
                        ? studentData.length
                        : studentData.length + 1,
                    itemBuilder: (context, index) {
                      if (index < studentData.length) {
                        final student = studentData[index];
                        return GridStudentItem(
                          student: student,
                          isSelected:
                          selectedStudents[student.id] ?? false,
                          isFetchWithoutGroup: widget.isFetchWithoutGroup,
                          onSelectionChanged: (isSelected) {
                            setState(() {
                              selectedStudents[student.id] = isSelected;
                            });
                            if (widget.onSelectionChanged != null) {
                              widget.onSelectionChanged!(
                                selectedStudents.entries
                                    .where((entry) => entry.value)
                                    .map((entry) => entry.key)
                                    .toList(),
                              );
                            }
                          },
                        );
                      } else {
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
                          onSelectionChanged:
                              (isSelected) {},
                        );
                      }
                    },
                  );
                } else {
                  return const Center(
                      child: Text("No students available"));
                }
              },
            );
          },
        ),
      )
          : LayoutBuilder(
        builder: (context, constraints) {
          return BlocBuilder<StudentFetchBloc, StudentFetchState>(
            builder: (context, state) {
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
                    onSelectionChanged: (isSelected) {},
                  ),
                );
              } else if (state is StudentFetchSuccess) {
                final studentData = state.students;

                double itemHeight = 100;
                double itemWidth =
                    (constraints.maxWidth - (4 - 1) * 8.0) / 4;

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: itemWidth / itemHeight,
                  ),
                  itemCount: widget.isFetchWithoutGroup
                      ? studentData.length
                      : studentData.length + 1,
                  itemBuilder: (context, index) {
                    if (index < studentData.length) {
                      final student = studentData[index];
                      return GridStudentItem(
                        student: student,
                        isSelected: selectedStudents[student.id] ?? false,
                        isFetchWithoutGroup: widget.isFetchWithoutGroup,
                        onSelectionChanged: (isSelected) {
                          setState(() {
                            selectedStudents[student.id] = isSelected;
                          });
                          if (widget.onSelectionChanged != null) {
                            widget.onSelectionChanged!(
                              selectedStudents.entries
                                  .where((entry) => entry.value)
                                  .map((entry) => entry.key)
                                  .toList(),
                            );
                          }
                        },
                      );
                    } else {
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
                        onSelectionChanged: (isSelected) {},
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
    );
  }
}
