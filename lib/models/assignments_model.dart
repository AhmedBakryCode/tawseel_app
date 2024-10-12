class Assignment {
  final String id; // Unique identifier for the assignment
  final String title; // Title of the assignment
  final String fileName; // Name of the file uploaded
  final String filePath; // Path to the file
  final bool isSubmitted; // Submission status

  Assignment({
    required this.id,
    required this.title,
    required this.fileName,
    required this.filePath,
    this.isSubmitted = false,
  });

  // Method to convert an Assignment instance to a Map (for saving to a database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'fileName': fileName,
      'filePath': filePath,
      'isSubmitted': isSubmitted,
    };
  }

  // Factory method to create an Assignment instance from a Map (for loading from a database)
  factory Assignment.fromMap(Map<String, dynamic> map) {
    return Assignment(
      id: map['id'],
      title: map['title'],
      fileName: map['fileName'],
      filePath: map['filePath'],
      isSubmitted: map['isSubmitted'] ?? false,
    );
  }
}
