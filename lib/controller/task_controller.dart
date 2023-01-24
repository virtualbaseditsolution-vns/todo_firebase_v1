import 'package:cloud_firestore/cloud_firestore.dart';

import '../library.dart';


class TaskController extends ChangeNotifier{

  final taskCollection = FirebaseFirestore.instance.collection("tasks");

  /// creating Task
  Future addNewTask(data)async{
    loading("Creating task...");
    final taskDoc = taskCollection.doc();
    await taskDoc.set(data);
    Get.back();
    return true;
  }

  /// Update Task
  Future updateTask(id,data)async{
    loading("Updating task...");
    final taskDoc = taskCollection.doc(id);
    await taskDoc.update(data);
    Get.back();
    return true;
  }

  /// Delete Task
  Future deleteTask(id)async{
    loading("Deleting task...");
    final taskDoc = taskCollection.doc(id);
    await taskDoc.delete();
    Get.back();
    return true;
  }

}