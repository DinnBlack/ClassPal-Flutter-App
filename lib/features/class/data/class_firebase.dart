import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_class_pal/core/state/app_state.dart';

import '../../../core/utils/id_generator.dart';
import '../model/class_model.dart';

class ClassFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Future<List<ClassModel>> fetchClasses() async {
    try {
      // Kiểm tra người dùng đã đăng nhập chưa
      if (currentUser == null) {
        throw Exception("User is not logged in");
      }

      // Lấy thông tin userId từ currentUser (đã đăng nhập)
      String userId = currentUser!.uid;
      print(userId);

      // Truy vấn tài liệu người dùng từ Firestore bằng userId
      var userDoc = await _firestore.collection('users').doc(userId).get();
      print(userDoc);

      if (!userDoc.exists) {
        throw Exception("User not found");
      }

      // Kiểm tra 'classesIds', nếu không có thì trả về danh sách rỗng
      var classIdsData = userDoc.data()?['classesIds'];
      List<String> classIds = [];

      // Nếu 'classesIds' không phải null và là một danh sách
      if (classIdsData != null && classIdsData is List) {
        classIds = List<String>.from(classIdsData);
      } else {
        print("No 'classesIds' found or 'classesIds' is not a List.");
      }

      print('classIds: $classIds');

      // Kiểm tra nếu không có lớp học nào liên kết với người dùng
      if (classIds.isEmpty) {
        throw Exception("No classes associated with the user");
      }

      // Tạo danh sách các truy vấn để lấy dữ liệu cho từng lớp
      List<ClassModel> classes = [];
      for (String classId in classIds) {
        // Truy vấn từng lớp với documentId là classId
        DocumentSnapshot classDoc = await _firestore.collection('classes').doc(classId).get();

        if (classDoc.exists) {
          // Chuyển đổi dữ liệu từ Firestore thành đối tượng ClassModel
          classes.add(ClassModel.fromMap(classDoc.data() as Map<String, dynamic>));
        } else {
          print("Class not found for classId: $classId");
        }
      }

      print(classes);
      return classes;
    } catch (e) {
      print('Error fetching classes: $e');
      return [];
    }
  }



  Future<String> createClass(ClassModel newClass) async {
    try {
      String currentUserId = AppState.getUser()?.userId ?? '';
      if (currentUserId.isEmpty) {
        throw Exception("User is not logged in");
      }

      var userDocSnapshot = await _firestore
          .collection('users')
          .where('userId', isEqualTo: currentUserId)
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
