import 'package:flutter/material.dart';

import '../../../../config/theme_data.dart';

enum MenuOptions { update, delete }

class BaseStationListItem extends StatelessWidget {
  const BaseStationListItem({
    super.key,
    required this.title,
    required this.address,
    required this.onSelected,
  });

  final String title;
  final String address;
  final Function(MenuOptions value) onSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 10),
      tileColor: AppColors.white,
      title: Text(title),
      subtitle: Text(
        address,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: PopupMenuButton<MenuOptions>(
        itemBuilder: (context) {
          return [
            const PopupMenuItem(
              value: MenuOptions.update,
              child: Text('Update'),
            ),
            const PopupMenuItem(
              value: MenuOptions.delete,
              child: Text(
                'Delete',
                style: TextStyle(color: AppColors.red),
              ),
            ),
          ];
        },
        onSelected: (value) {
          onSelected(value);
        },
      ),
    );
  }
}
