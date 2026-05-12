import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../auth/auth_controller.dart';
import 'note_controller.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final NoteController noteController =
    Get.put(NoteController());

    final AuthController authController =
    Get.find();

    return Scaffold(

      appBar: AppBar(

        title: const Text("My Notes"),

        centerTitle: true,

        actions: [

          IconButton(

            onPressed: () {

              authController.logout(context);
            },

            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(

        onPressed: () {

          context.go('/add-note');
        },

        child: const Icon(Icons.add),
      ),

      body: Obx(() {

        if (noteController.isLoading.value) {

          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (noteController.notesList.isEmpty) {

          return const Center(
            child: Text(
              "No Notes Found",
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return ListView.builder(

          itemCount: noteController.notesList.length,

          itemBuilder: (context, index) {

            final note = noteController.notesList[index];

            return Card(

              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),

              child: ListTile(

                title: Text(
                  note.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Text(
                  note.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                trailing: IconButton(

                  onPressed: () {

                    noteController.deleteNote(note.id);
                  },

                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}