import 'package:flutter/material.dart';

import '../../../models/user.dart';

class SearchItem extends StatelessWidget {
  const SearchItem(
      {super.key,
      required this.favorite,
      required this.onTap,
      required this.users});
  final VoidCallback onTap;
  final VoidCallback favorite;
  final List<Users> users;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: users.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                onTap: onTap,
                title: Text(users[index].displayName ?? ''),
                trailing: IconButton(
                  onPressed: favorite,
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ),
              const Divider(
                height: 2,
                thickness: 2,
              )
            ],
          );
        });
  }
}
