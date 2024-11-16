import 'package:flutter/material.dart';

import '../../../../core/constants/constant.dart';
import '../../widgets/grid_student_item.dart';

class StudentListScreen extends StatelessWidget {
  static const route = 'StudentListScreen';

  // Sample student data
  final List<Map<String, String>> students = [
    {
      'avatarUrl': 'assets/images/boy.jpg',
      'name': 'John Doe',
      'value': 'A',
    },
    {
      'avatarUrl': 'assets/images/girl.jpg',
      'name': 'Jane Smith',
      'value': 'B',
    },
    {
      'avatarUrl': 'assets/images/boy.jpg',
      'name': 'Mark Lee',
      'value': 'C',
    },
    {
      'avatarUrl': 'assets/images/boy.jpg',
      'name': 'Emily Brown',
      'value': 'A+',
    },
    {
      'avatarUrl': 'assets/images/girl.jpg',
      'name': 'Thảo Vy',
      'value': 'B+',
    },
    {
      'avatarUrl': 'assets/images/boy.jpg',
      'name': 'Laura Green',
      'value': 'A',
    },
    {
      'avatarUrl': 'assets/images/boy.jpg',
      'name': 'David Harris',
      'value': 'C+',
    },
    {
      'avatarUrl': 'assets/images/girl.jpg',
      'name': 'Olivia Taylor',
      'value': 'A',
    },
  ];

  StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kPaddingMd),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double itemHeight = 100;
            double itemWidth = (constraints.maxWidth - (4 - 1) * 8.0) / 4;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: itemWidth / itemHeight,
              ),
              itemCount: students.length + 1,
              itemBuilder: (context, index) {
                if (index < students.length) {
                  final student = students[index];
                  return GridStudentItem(
                    avatarUrl: student['avatarUrl']!,
                    name: student['name']!,
                    value: student['value']!,
                  );
                } else {
                  // "Add Item" widget
                  return const GridStudentItem(
                    name: 'Thêm mới',
                    value: '',
                    add: true,
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
