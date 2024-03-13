import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:apitest/model/model.dart';

class PostService {
  final String baseUrl = 'https://crudcrud.com/api/f35c0002b17645208b15794e08a44aa0';

  Future<List<modelClass>> fetchData() async {
    final url = Uri.parse('$baseUrl/unicorns');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<modelClass> posts = responseData.map((json) => modelClass.fromJson(json)).toList();
        return posts;
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }

  Future<void> updatePost(String postId, Map<String, dynamic> newData) async {
    final String apiUrl = '$baseUrl/unicorns/$postId';

    try {
      var response = await http.put(
        Uri.parse(apiUrl),
        body: jsonEncode(newData),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Post updated successfully');
      } else {
        throw Exception('Failed to update post');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> deletePost(String postId) async {
    final String apiUrl = '$baseUrl/unicorns/$postId';

    try {
      var response = await http.delete(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        print('Post deleted successfully');
      } else {
        throw Exception('Failed to delete post');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
