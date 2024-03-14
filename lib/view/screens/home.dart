import 'package:flutter/material.dart';
import 'package:apitest/model/model.dart';
import 'package:apitest/view/screens/add.dart';
import 'package:apitest/view/screens/editpage.dart';
import 'package:apitest/controll/post.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PostService _postService = PostService();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  late Future<List<modelClass>> _data;

  @override
  void initState() {
    super.initState();
    _data = _postService.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to Add screen and wait for result
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Add()),
          );
          // After adding, refresh the data
          setState(() {
            _data = _postService.fetchData();
          });
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          // Refresh data
          setState(() {
            _data = _postService.fetchData();
          });
        },
        child: FutureBuilder<List<modelClass>>(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else if (snapshot.data!.isEmpty) {
              return Center(
                child: Text("No data"),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return ListTile(
                    title: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("carname :${post.name}"),
                          Text("modelname :${post.age}"),
                          Text("en:number :${post.position}"),
                          Text("Details:"),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: post.details != null
                                ? post.details!.map((detail) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Engine Number: ${detail.engineNumber}"),
                                        Text("Price: ${detail.price}"),
                                        Text("Colors: ${detail.colors}"),
                                      ],
                                    );
                                  }).toList()
                                : [Text("No details available")],
                          ),
                        ],
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPage(
                                  post: post,
                                  onSave: (modelClass) {},
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm Deletion"),
                                  content: const Text("Are you sure you want to delete this item?"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        try {
                                          await _postService.deletePost(post.sId!); // Call deletePost method
                                          setState(() {
                                            // Remove the deleted item from the list
                                            snapshot.data!.remove(post);
                                          });
                                          Navigator.of(context).pop(); // Close the dialog
                                        } catch (e) {
                                          print('Error deleting item: $e');
                                        }
                                      },
                                      child: const Text("Delete"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.delete),
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("No data available"),
              );
            }
          },
        ),
      ),
    );
  }
}
