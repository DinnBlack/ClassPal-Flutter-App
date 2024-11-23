import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diacritic/diacritic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_class_pal/core/state/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/id_generator.dart';
import '../../class/model/class_model.dart';
import '../model/student_group_model.dart';
import '../model/student_model.dart';

class StudentFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> _getUserIdFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  Future<List<StudentModel>> fetchStudents(String classId) async {
    try {
      var classDoc = await _firestore.collection('classes').doc(classId).get();
      if (!classDoc.exists) {
        throw Exception("Class not found");
      }
      var classData = classDoc.data() as Map<String, dynamic>;
      ClassModel classModel = ClassModel.fromMap(classData);

      // Sort students alphabetically by name with diacritic removed for accurate comparison
      List<StudentModel> sortedStudents = List.from(classModel.students);
      sortedStudents.sort((a, b) {
        // Remove diacritics before comparing
        String nameA = removeDiacritics(a.name);
        String nameB = removeDiacritics(b.name);
        return nameA.compareTo(nameB);
      });

      return sortedStudents;
    } catch (e) {
      print('Error fetching students: $e');
      return [];
    }
  }

  // Create a new student and associate them with a class
  Future<String> createStudent(StudentModel newStudent, String classId) async {
    try {
      String? currentUserId = await _getUserIdFromSharedPreferences();
      if (currentUserId == null || currentUserId.isEmpty) {
        throw Exception("User is not logged in");
      }
      String newStudentId = generateStudentId();
      newStudent = newStudent.copyWith(id: newStudentId);
      DocumentSnapshot classDoc =
          await _firestore.collection('classes').doc(classId).get();

      if (!classDoc.exists) {
        throw Exception("Class not found");
      }
      Map<String, dynamic> classData = classDoc.data() as Map<String, dynamic>;
      List<dynamic> currentStudents = classData['students'] ?? [];
      currentStudents.add(newStudent.toMap());
      await _firestore.collection('classes').doc(classId).update({
        'students': currentStudents,
      });

      return newStudentId;
    } catch (e) {
      print('Error creating student: $e');
      return '';
    }
  }

  Future<bool> createStudentGroup(
      String groupName, List<String> studentIds, String classId) async {
    try {
      String? currentUserId = await _getUserIdFromSharedPreferences();
      if (currentUserId == null || currentUserId.isEmpty) {
        throw Exception("User is not logged in");
      }
      DocumentSnapshot classDoc =
          await _firestore.collection('classes').doc(classId).get();
      print(classDoc);
      if (!classDoc.exists) {
        throw Exception("Class not found");
      }

      Map<String, dynamic> classData = classDoc.data() as Map<String, dynamic>;
      List<dynamic> currentGroups = classData['groups'] ?? [];
      Map<String, dynamic> studentGroup = {
        'groupName': groupName,
        'studentIds': studentIds,
      };
      currentGroups.add(studentGroup);
      print(currentGroups);
      await _firestore.collection('classes').doc(classId).update({
        'groups': currentGroups,
      });

      return true;
    } catch (e) {
      print('Error creating student group: $e');
      return false;
    }
  }

  Future<List<StudentGroupModel>> fetchStudentGroups(String classId) async {
    try {
      DocumentSnapshot classDoc =
      await _firestore.collection('classes').doc(classId).get();
      if (!classDoc.exists) {
        throw Exception("Class not found");
      }

      Map<String, dynamic> classData = classDoc.data() as Map<String, dynamic>;
      List<dynamic> studentGroupsData = classData['groups'] ?? [];

      // Convert to model and sort by group name
      List<StudentGroupModel> studentGroups = studentGroupsData.map((groupData) {
        return StudentGroupModel.fromMap(groupData as Map<String, dynamic>);
      }).toList();

      studentGroups.sort((a, b) => a.name.compareTo(b.name)); // Sort by 'groupName'

      return studentGroups;
    } catch (e) {
      print('Error fetching student groups: $e');
      return [];
    }
  }



  Future<bool> updateStudentGroup(String groupId, String newGroupName,
      List<String> updatedStudentIds, String classId) async {
    try {
      DocumentReference classDocRef =
          _firestore.collection('classes').doc(classId);
      DocumentSnapshot classDoc = await classDocRef.get();

      if (!classDoc.exists) {
        throw Exception("Class not found");
      }

      Map<String, dynamic> classData = classDoc.data() as Map<String, dynamic>;
      List<dynamic> currentGroups = classData['studentGroups'] ?? [];
      int groupIndex =
          currentGroups.indexWhere((group) => group['groupId'] == groupId);

      if (groupIndex == -1) {
        throw Exception("Student group not found");
      }
      currentGroups[groupIndex] = {
        'groupId': groupId,
        'groupName': newGroupName,
        'studentIds': updatedStudentIds,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await classDocRef.update({
        'studentGroups': currentGroups,
      });

      return true;
    } catch (e) {
      print('Error updating student group: $e');
      return false;
    }
  }

  Future<List<StudentModel>> fetchStudentsWithoutGroup() async {
    try {
      String? classId = AppState.getClass()?.classId;
      DocumentSnapshot classDoc = await _firestore.collection('classes').doc(classId).get();
      if (!classDoc.exists) {
        throw Exception("Class not found");
      }

      Map<String, dynamic> classData = classDoc.data() as Map<String, dynamic>;
      List<dynamic> studentIdsInGroups = [];
      List<dynamic> studentGroups = classData['groups'] ?? [];

      for (var group in studentGroups) {
        List<dynamic> studentIds = group['studentIds'] ?? [];
        studentIdsInGroups.addAll(studentIds);
      }

      ClassModel classModel = ClassModel.fromMap(classData);
      List<StudentModel> allStudents = classModel.students;

      // Filter out students already in groups
      List<StudentModel> studentsWithoutGroup = allStudents.where((student) {
        return !studentIdsInGroups.contains(student.id);
      }).toList();

      // Sort alphabetically by name
      studentsWithoutGroup.sort((a, b) => a.name.compareTo(b.name));  // Assuming 'name' is a field in StudentModel

      return studentsWithoutGroup;
    } catch (e) {
      print('Error fetching students without group: $e');
      return [];
    }
  }


}
