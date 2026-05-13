import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../auth/auth_controller.dart';
import 'note_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final NoteController noteController = Get.put(NoteController());

    final AuthController authController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Notes",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,

        actions: [
          TextButton.icon(
            onPressed: () {
              authController.logout(context);
            },

            icon: const Icon(Icons.logout, color: Colors.red),

            label: const Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          context.go('/add-note');
        },

        child: Icon(Icons.add, color: Colors.white),
      ),

      body: Obx(() {
        if (noteController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (noteController.notesList.isEmpty) {
          return Center(
            child: Text("No Notes Found", style: TextStyle(fontSize: 18)),
          );
        }

        return ListView.builder(
          itemCount: noteController.notesList.length,

          itemBuilder: (context, index) {
            final note = noteController.notesList[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: Colors.yellow[200],

              child: ListTile(
                title: Text(
                  note.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
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

                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
