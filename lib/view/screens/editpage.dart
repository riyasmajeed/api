import 'dart:convert';

import 'package:apitest/view/screens/Homepage.dart';
import 'package:apitest/view/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:apitest/model/model.dart';
import 'package:apitest/controll/post.dart';
import 'package:http/http.dart';

class EditPage extends StatefulWidget {
  final modelClass post;
  final Function(modelClass) onSave; // Callback function to save changes
  const EditPage({Key? key, required this.post, required this.onSave}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _positionController;
  late TextEditingController _salaryController;
  final PostService _postService = PostService(); // Instantiate PostService
  

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.post.name);
    _ageController = TextEditingController(text: widget.post.age);
    _positionController = TextEditingController(text: widget.post.position);
     _salaryController = TextEditingController(text: widget.post.salary);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Post"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "carname"),
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: "modelname"),
              ),
              TextField(
                controller: _positionController,
                decoration: InputDecoration(labelText: "en:number"),
              ),
              
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await _saveChanges(); // await to ensure changes are saved before moving forward
                   onSave(post);
                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home(),), (route) => false);
                },
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

 Future<void> _saveChanges() async {
  // Prepare the updated data to be sent to the server
  final Map<String, dynamic> updatedData = {
    'name': _nameController.text,
    'age': _ageController.text,
    'position': _positionController.text,
    'salary': _salaryController.text, // Assuming you have a _salaryController for updating the salary
    'details': widget.post.details!.map((detail) => detail.toJson()).toList(),
  };

  try {
    await _postService.updatePost(widget.post.sId!, updatedData); // Call updatePost method from PostService
    // Pass the updated post back to the calling widget
    final updatedPost = modelClass(
      sId: widget.post.sId,
      name: _nameController.text,
      age: _ageController.text,
      position: _positionController.text,
      salary: _salaryController.text, // Assuming you have a _salaryController for updating the salary
      details: widget.post.details, // Use the same list of details as before
    );
    widget.onSave(updatedPost);
   
  } catch (e) {
    // Handle errors here
    print('Error updating post: $e');
    // You may also want to show a snackbar or dialog to inform the user about the error.
  }
}

  void onSave(Future<Response> Function(Uri url, {Object? body, Encoding? encoding, Map<String, String>? headers}) post) {}




}