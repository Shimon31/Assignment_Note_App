class NoteModel {

  final String id;
  final String title;
  final String description;

  NoteModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json, String id) {

    return NoteModel(
      id: id,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {

    return {
      'title': title,
      'description': description,
    };
  }
}