class Question {
  final String mainTitle;
  final String time;
  final String description;
  final String id;
  final String title;
  final Map<String, bool> options;

  Question({
    required this.id,
    required this.title,
    required this.options,
    required this.description,
    required this.mainTitle,
    required this.time
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'options': options,
      'mainTitle': mainTitle,
      'time': time,
      'description':description
    };
  }
}