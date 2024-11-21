import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/id_generator.dart';
import '../model/class_model.dart';

class ClassFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> _getUserIdFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  Future<List<ClassModel>> fetchClasses() async {
    try {
      String? userId = await _getUserIdFromSharedPreferences();
      print(userId);
      if (userId == null || userId.isEmpty) {
        throw Exception("User is not logged in or UID is not available");
      }

      var userDoc = await _firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) {
        throw Exception("User not found");
      }

      var classIdsData = userDoc.data()?['classesIds'];
      List<String> classIds = [];
      if (classIdsData != null && classIdsData is List) {
        classIds = List<String>.from(classIdsData);
      } else {
        print("No 'classesIds' found or 'classesIds' is not a List.");
      }

      if (classIds.isEmpty) {
        throw Exception("No classes associated with the user");
      }

      List<ClassModel> classes = [];
      for (String classId in classIds) {
        DocumentSnapshot classDoc =
            await _firestore.collection('classes').doc(classId).get();
        if (classDoc.exists) {
          classes
              .add(ClassModel.fromMap(classDoc.data() as Map<String, dynamic>));
        } else {
          print("Class not found for classId: $classId");
        }
      }

      return classes;
    } catch (e) {
      print('Error fetching classes: $e');
      return [];
    }
  }

  Future<String> createClass(ClassModel newClass) async {
    try {
      String? currentUserId = await _getUserIdFromSharedPreferences();
      if (currentUserId == null || currentUserId.isEmpty) {
        throw Exception("User is not logged in");
      }

      var userDocSnapshot = await _firestore
          .collection('users')
          .where(currentUserId)
          .get();

      if (userDocSnapshot.docs.isEmpty) {
        throw Exception("User not found");
      }

      var userDoc = userDocSnapshot.docs.first;
      String userId = userDoc.data()['userId'];
      String newClassId = generateClassId();
      newClass = newClass.copyWith(classId: newClassId);

      await _firestore
          .collection('classes')
          .doc(newClassId)
          .set(newClass.toMap());

      await _firestore.collection('classes').doc(newClassId).update({
        'teacherIds': FieldValue.arrayUnion([userId]),
      });

      await _firestore.collection('users').doc(userDoc.id).update({
        'classesIds': FieldValue.arrayUnion([newClassId]),
      });

      return newClassId;
    } catch (e) {
      print('Error creating class: $e');
      return '';
    }
  }
}
