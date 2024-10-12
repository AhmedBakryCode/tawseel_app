// repositories/courses_repository.dart

import 'package:dio/dio.dart';
import 'package:task/models/courses_model.dart';

class CoursesRepository {
  final Dio _dio;
  final String apiUrl;

  CoursesRepository(this.apiUrl) : _dio = Dio(BaseOptions(baseUrl: apiUrl));

  // Fetch the list of courses from the API
  Future<CoursePage> fetchCourses() async {
    try {
      final response = await _dio.get('/courses'); // Adjust the endpoint
      return CoursePage.fromJson(response.data);  // Directly use response data
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception('Failed to load courses: ${e.response!.data}');
      } else {
        throw Exception('Failed to load courses: ${e.message}');
      }
    }
  }

  // Fetch a specific course by ID
  Future<Course> fetchCourseById(String courseId) async {
    try {
      final response = await _dio.get('/courses/$courseId');  // Adjust the endpoint
      return Course.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception('Failed to load course: ${e.response!.data}');
      } else {
        throw Exception('Failed to load course: ${e.message}');
      }
    }
  }

// You can add more methods as required...
}
