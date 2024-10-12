// models/course_models.dart

class CoursePage {
  final List<Course> courses;

  CoursePage({required this.courses});

  factory CoursePage.fromJson(Map<String, dynamic> json) {
    return CoursePage(
      courses: List<Course>.from(
        json['courses'].map((course) => Course.fromJson(course)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courses': courses.map((course) => course.toJson()).toList(),
    };
  }
}

class Course {
  final String id;
  final String title;
  final Categories categories;

  Course({required this.id, required this.title, required this.categories});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      categories: Categories.fromJson(json['categories']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'categories': categories.toJson(),
    };
  }
}

class Categories {
  final Chapters chapters;
  final Announcements announcements;

  Categories({required this.chapters, required this.announcements});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      chapters: Chapters.fromJson(json['chapters']),
      announcements: Announcements.fromJson(json['announcements']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chapters': chapters.toJson(),
      'announcements': announcements.toJson(),
    };
  }
}

class Chapters {
  final List<FileItem> files;
  final List<VideoItem> videos;

  Chapters({required this.files, required this.videos});

  factory Chapters.fromJson(Map<String, dynamic> json) {
    return Chapters(
      files: List<FileItem>.from(
        json['files'].map((file) => FileItem.fromJson(file)),
      ),
      videos: List<VideoItem>.from(
        json['videos'].map((video) => VideoItem.fromJson(video)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'files': files.map((file) => file.toJson()).toList(),
      'videos': videos.map((video) => video.toJson()).toList(),
    };
  }
}

class Announcements {
  final List<Assignment> assignments;

  Announcements({required this.assignments});

  factory Announcements.fromJson(Map<String, dynamic> json) {
    return Announcements(
      assignments: List<Assignment>.from(
        json['assignments'].map((assignment) => Assignment.fromJson(assignment)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assignments': assignments.map((assignment) => assignment.toJson()).toList(),
    };
  }
}

class FileItem {
  final String id;
  final String name;
  final String fileUrl;

  FileItem({required this.id, required this.name, required this.fileUrl});

  factory FileItem.fromJson(Map<String, dynamic> json) {
    return FileItem(
      id: json['id'],
      name: json['name'],
      fileUrl: json['fileUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'fileUrl': fileUrl,
    };
  }
}

class VideoItem {
  final String id;
  final String name;
  final String videoUrl;

  VideoItem({required this.id, required this.name, required this.videoUrl});

  factory VideoItem.fromJson(Map<String, dynamic> json) {
    return VideoItem(
      id: json['id'],
      name: json['name'],
      videoUrl: json['videoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'videoUrl': videoUrl,
    };
  }
}

class Assignment {
  final String id;
  final String title;
  final String description;
  final String dueDate;

  Assignment({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dueDate: json['dueDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate,
    };
  }
}
