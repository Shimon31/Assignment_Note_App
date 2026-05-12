import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/note_model.dart';

class NoteController extends GetxController {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  var notesList = <NoteModel>[].obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    fetchNotes();
  }


  Future<void> fetchNotes() async {

    try {

      isLoading.value = true;

      final snapshot = await _firestore
          .collection('notes')
          .get();

      notesList.value = snapshot.docs.map((doc) {

        return NoteModel.fromJson(
          doc.data(),
          doc.id,
        );

      }).toList();

    } catch (e) {

      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

    } finally {

      isLoading.value = false;
    }
  }


  Future<void> addNote({
    required String title,
    required String description,
    required BuildContext context,
  }) async {

    if (title.isEmpty || description.isEmpty) {

      Get.snackbar(
        "Error",
        "All fields are required",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      return;
    }

    try {

      isLoading.value = true;

      await _firestore.collection('notes').add({

        'title': title,
        'description': description,
      });

      await fetchNotes();

      Get.snackbar(
        "Success",
        "Note Added Successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      context.go('/home');

    } catch (e) {

      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

    } finally {

      isLoading.value = false;
    }
  }

  Future<void> deleteNote(String id) async {

    try {

      await _firestore
          .collection('notes')
          .doc(id)
          .delete();

      fetchNotes();

      Get.snackbar(
        "Success",
        "Note Deleted",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

    } catch (e) {

      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}