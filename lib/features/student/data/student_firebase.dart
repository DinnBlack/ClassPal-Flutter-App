import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/id_generator.dart';
import '../../class/model/class_model.dart';
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
      return classModel.students;
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
}
