import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({super.key, required this.favorite, required this.onTap});
  final VoidCallback onTap;
  final VoidCallback favorite;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                  onTap: onTap,
                  title: const Text('Phan Xuân Hiệp'),
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
          }),
    );
  }
}
