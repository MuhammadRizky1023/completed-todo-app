import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist/data/basedata/basedata.dart';
import 'package:todolist/data/data.dart';

class AccountServices {
  late Task task;

  TaskDataSource taskDataSource = TaskDataSource();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUserWithLink(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? userId = result.user?.uid;

      // Inisialisasi objek task sebelum mengakses category
      task = Task(
        title: 'Default Title',
        category: task.category, // Mengakses nilai category dari objek task
        time: 'Default Time',
        date: 'Default Date',
        note: 'Default Note',
        isCompleted: false,
        userId: userId ?? "",
      );

      await TaskRepositoryImpl(taskDataSource)
          .linkFirebaseUserWithSqlite(userId ?? "", task);
      await taskDataSource.insertUser(userId ?? "");
    } catch (e) {
      print('Failed to login user: $e');
    }
  }

  Future<void> signUpUser(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? userId = result.user?.uid;
      await taskDataSource.insertUser(userId ?? "");
    } catch (e) {
      print('Error during user registration: $e');
      throw e;
    }
  }

  
  Future<void> resetPassword(String email) async {
    try {
        await _auth.sendPasswordResetEmail(
        email: email,
      );
    } catch (e) {
      print('Error during user registration: $e');
      throw e;
    }
  }
}
