import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/custom_textfield.dart';
import 'note_controller.dart';

class AddNotePage extends StatelessWidget {

  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {

    final NoteController controller = Get.find();

    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Add Note"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            CustomTextField(
              controller: titleController,
              hintText: "Enter Title",
            ),

            const SizedBox(height: 20),

            CustomTextField(
              controller: descriptionController,
              hintText: "Enter Description",
              maxLines: 5,
            ),

            const SizedBox(height: 30),

            Obx(() {

              return controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : SizedBox(

                width: double.infinity,

                child: ElevatedButton(

                  onPressed: () {

                    controller.addNote(
                      title: titleController.text.trim(),
                      description:
                      descriptionController.text.trim(),
                      context: context,
                    );
                  },

                  child: const Text("Save Note"),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}