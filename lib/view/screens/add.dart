import 'dart:convert';

import 'package:apitest/view/screens/Homepage.dart';
import 'package:apitest/view/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController enginenumberController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  final List<String> carcolor = ["red", 'green', 'blue'];
  List<String> selectedColors = [];
  List<Map<String, dynamic>> moreDetails = [];

  Future<void> _addEmployee() async {
    String name = nameController.text;
    String age = ageController.text;
    String position = positionController.text;
    String salary = salaryController.text;

    if (name.isEmpty ||
        age.isEmpty ||
        position.isEmpty ||
        salary.isEmpty ||
        moreDetails.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(
            'https://crudcrud.com/api/0fccca93e662427490e8e7e24dfcb4bf/unicorns'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
          'age': age,
          'position': position,
          'salary': salary,
          'details': moreDetails,
        }),
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Employee added successfully.'),
          ),
        );
        nameController.clear();
        ageController.clear();
        positionController.clear();
        salaryController.clear();
        enginenumberController.clear();
        priceController.clear();
        selectedColors.clear();
        moreDetails.clear();
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
      } else {
        throw Exception(
            'Failed to add employee. Status code: ${response.statusCode}');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add employee: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Column(
              children: [
                Form(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter a name";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter car Name',
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: ageController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter a name";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter model',
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: positionController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter a name";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter en:number',
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: salaryController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter a name";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter price',
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Add more details"),
                                  content: Form(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: enginenumberController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Enter engine number";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Engine Number',
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            controller: priceController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Enter price";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Price',
                                            ),
                                          ),
                                         DropdownButtonFormField(
  items: carcolor
      .map((e) => DropdownMenuItem(
            child: Text(e),
            value: e,
          ))
      .toList(),
  decoration: InputDecoration(
    border: OutlineInputBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(28))),
    filled: true,
    hintText: "color",
  ),
  onChanged: (val) {
    setState(() {
      selectedColors.add(val.toString());
     
    });
  },
),

                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          moreDetails.add({
                                            'engineNumber': enginenumberController.text,
                                            'price': priceController.text,
                                            'colors': selectedColors.toList(), 
                                          });
                                        });
                                        enginenumberController.clear();
                                        priceController.clear();
                                        selectedColors.clear();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Save"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel"),
                                    ),
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
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _addEmployee();
                          },
                          child: Text("save"),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            nameController.clear();
                            ageController.clear();
                            positionController.clear();
                            salaryController.clear();
                          },
                          child: Text("clear"),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(Add());
}
