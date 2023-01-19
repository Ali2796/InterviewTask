import 'package:flutter/material.dart';

import '../custom_widgets/avatar.dart';
import '../data/mock_data.dart';
import '../data/user.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final searchController;
  late List<User?> users;
  late List<User?> filteredUsers;

  @override
  void initState() {
    super.initState();
    users = User.fromJsonToList(allData());
    filteredUsers = users;
    searchController = TextEditingController();
    searchController.addListener(() {
      setState(() {
        users = _filterList(searchController.text.toString());
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<User> _filterList(String value) {
    List<User> searchList = [];
    for (int i = 0; i < filteredUsers.length; i++) {
      if (filteredUsers[i]!
              .firstName
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()) ||
          filteredUsers[i]!
              .lastName
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()) ||
          filteredUsers[i]!
              .email
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()) ||
          filteredUsers[i]!
              .role
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase())) {
        searchList.add(filteredUsers[i]!);
      }
    }
    return searchList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                autofocus: true,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                User item = users[index]!;
                print('${item.avatar}');
                return ListTile(
                  leading: Avatar.getUserAvatar(
                    url: item.avatar.toString(),
                  ),
                  title: Text(
                      '${item.firstName.toString()} ${item.lastName.toString()}'),
                  subtitle: Text('${item.role.toString()}'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var newUser = User(
              id: "b32ec56c-21bb-4b7b-a3a0-635b8bca1f9d",
              avatar: null,
              firstName: "James",
              lastName: "May",
              email: "ssaull1c@tripod.com",
              role: "Developer");

          users.add(newUser);
          filteredUsers.add(newUser);
          setState(() {});
        },
        tooltip: 'Add new',
        child: Icon(Icons.add),
      ),
    );
  }
}
