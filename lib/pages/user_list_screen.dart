import 'package:fetch_data_from_api/repository/user_repository.dart';
import 'package:fetch_data_from_api/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final UserRepository _userRepository = UserRepository();
  late Future<List<User>> _userList;

  @override
  void initState() {
    super.initState();
    _userList = _userRepository.fetchUsers();
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied "$text" to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('User List'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<List<User>>(
          future: _userList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No users found'));
            } else {
              final users = snapshot.data!;
              return ListView.separated(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: GestureDetector(
                      onTap: () => _copyToClipboard(context, user.name),
                      child: Text("Name: ${user.name}"),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => _copyToClipboard(context, user.username),
                          child: Text("Username: ${user.username}"),
                        ),
                        GestureDetector(
                          onTap: () => _copyToClipboard(context, user.email),
                          child: Text("Email: ${user.email}"),
                        ),
                        GestureDetector(
                          onTap: () => _copyToClipboard(context, user.phone),
                          child: Text("Phone: ${user.phone}"),
                        ),
                        GestureDetector(
                          onTap: () => _copyToClipboard(context, user.website),
                          child: Text("Website: ${user.website}"),
                        ),
                        GestureDetector(
                          onTap: () => _copyToClipboard(context, user.address),
                          child: Text("Address: ${user.address}"),
                        ),
                        GestureDetector(
                          onTap: () => _copyToClipboard(context, user.company),
                          child: Text("Company: ${user.company}"),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                  height: 20,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
