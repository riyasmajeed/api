import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddMore extends StatefulWidget {
  const AddMore({Key? key}) : super(key: key);

  @override
  State<AddMore> createState() => _AddMoreState();
}

class _AddMoreState extends State<AddMore> {
  TextEditingController enginenumber = TextEditingController();
  TextEditingController price = TextEditingController();

  Future<void> _addEmployee() async {
    // Retrieve values from text editing controllers
    String engineNumber = enginenumber.text;
    String priceValue = price.text;

    // Validate input fields
    if (engineNumber.isEmpty || priceValue.isEmpty) {
      // Show a snackbar if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
      return;
    }
    // Save data to API
    try {
      final response = await http.post(
        Uri.parse('https://crudcrud.com/api/52e3d59af0ec4fb0bc6185fff2c7d15d/unicorns'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'enginenumber': engineNumber,
          'price': priceValue,
        }),
      );
      if (response.statusCode == 201) {
        // Show a snackbar if employee is added successfully
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Employee added successfully.'),
          ),
        );
        // Clear input fields after adding employee
        enginenumber.clear();
        price.clear();

        // Navigate back to home page after adding employee
        Navigator.pop(context);
      } else {
        // Throw an exception if adding employee fails
        throw Exception(
            'Failed to add employee. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Show a snackbar if an error occurs while adding employee
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add employee: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return
     GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Add details"),
              content: Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: enginenumber,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter a number";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter engine number',
                        ),
                      ),
                      TextFormField(
                        controller: price,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter a price";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter price',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    _addEmployee();
                    Navigator.of(context).pop();
                  },
                  child: Text("Save"),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.logout_outlined),
                )
              ],
            );
          },
        );
      },
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: Text("Add more details")),
      ),
    );
  }
}
