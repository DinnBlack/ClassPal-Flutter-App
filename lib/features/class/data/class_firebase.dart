import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_class_pal/core/state/app_state.dart';

import '../../../core/utils/id_generator.dart';
import '../../user/model/user_model.dart';
import '../model/class_model.dart';

class ClassFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserModel? currentUser = AppState.getUser();

  Future<List<ClassModel>> fetchClasses() async {
    try {
      if (currentUser == null) {
        throw Exception("User is not logged in");
      }
      QuerySnapshot classSnapshot = await _firestore
          .collection('classes')
          .where(FieldPath.documentId, whereIn: currentUser!.classesIds)
          .get();
      List<ClassModel> classes = classSnapshot.docs.map((doc) {
        return ClassModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return classes;
    } catch (e) {
      print('Error fetching classes: $e');
      return [];
    }
  }

  Future<String> createClass(ClassModel newClass) async {
    try {
      if (currentUser == null) {
        throw Exception("User is not logged in");
      }
      String newClassId = generateClassId();
      newClass = newClass.copyWith(classId: newClassId);
      await _firestore
          .collection('classes')
          .doc(newClassId)
          .set(newClass.toMap());
      await _firestore.collection('classes').doc(newClassId).update({
        'teacherIds': FieldValue.arrayUnion([currentUser!.userId]),
      });
      await _firestore.collection('users').doc(currentUser!.userId).update({
        'classesIds': FieldValue.arrayUnion([newClassId]),
      });
      return newClassId;
    } catch (e) {
      print('Error creating class: $e');
      return '';
    }
  }
}
