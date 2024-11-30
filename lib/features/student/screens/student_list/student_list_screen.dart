import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/loading_dialog.dart';

import '../../../../core/constants/constant.dart';
import '../../bloc/student/student_bloc.dart';
import '../../widgets/grid_student_item.dart';
import '../student_create/student_create_screen.dart';

class StudentListScreen extends StatefulWidget {
  final bool isFetchWithoutGroup;
  final Function(List<String>)? onSelectionChanged;  // Tham số tùy chọn, có thể là null
  final bool paddingEnabled;  // Thêm trường mới để quyết định có padding hay không

  const StudentListScreen({
    Key? key,
    this.isFetchWithoutGroup = false,
    this.onSelectionChanged,  // Không bắt buộc
    this.paddingEnabled = true, // Mặc định là có padding
  }) : super(key: key);

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  Map<String, bool> selectedStudents = {};  // Map với key là ID sinh viên

  @override
  void initState() {
    super.initState();
    final classBloc = BlocProvider.of<StudentBloc>(context);

    if (widget.isFetchWithoutGroup) {
      classBloc.add(StudentFetchWithoutGroupStarted());
    } else {
      classBloc.add(StudentFetchStarted());
    }

    classBloc.fetchStream.listen((_) {
      if (widget.isFetchWithoutGroup) {
        classBloc.add(StudentFetchWithoutGroupStarted());
      } else {
        classBloc.add(StudentFetchStarted());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.paddingEnabled // Kiểm tra xem có padding hay không
          ? Padding(
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
                  double itemWidth = (constraints.maxWidth - (4 - 1) * 8.0) / 4;

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: itemWidth / itemHeight,
                    ),
                    itemCount: widget.isFetchWithoutGroup ? studentData.length : studentData.length + 1,
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
                        return Container(
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
                            onSelectionChanged: (isSelected) {},  // Không làm gì khi không có sinh viên
                          ),
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
      )
          : LayoutBuilder(
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
                    onSelectionChanged: (isSelected) {},
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
                  itemCount: widget.isFetchWithoutGroup ? studentData.length : studentData.length + 1,
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
