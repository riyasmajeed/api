import 'package:flutter/material.dart';
import 'package:apitest/model/model.dart';
import 'package:apitest/view/screens/editpage.dart';
import 'package:apitest/controll/post.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PostService _postService = PostService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Text(
              "All Posts",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<modelClass>>(
                future: _postService.fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
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
                                Text( "modelname :${post.age}"),
                                Text( "en:number :${post.position}"),
                                Text("Details:"),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: post.details!.map((detail) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Engine Number: ${detail.engineNumber}"),
                                        Text("Price: ${detail.price}"),
                                        Text("Colors: ${detail.colors}"),
                                      ],
                                    );
                                  }).toList(),
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
                                      builder: (context) => EditPage(post: post, onSave: (modelClass ) {  },),
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
                                  content: const Text(
                                      "Are you sure you want to delete this user?"),
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
                                           _postService.deletePost(post.sId!); // Call deletePost method
                                  setState(() {
                                    // Refresh the UI after deletion
                                    snapshot.data!.remove(post);
                                  });
                                        } catch (e) {
                                          print('Error deleting error: $e');
                                        }
                                     
                                        Navigator.of(context).pop();
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
          ],
        ),
      ),
    );
  }
}
