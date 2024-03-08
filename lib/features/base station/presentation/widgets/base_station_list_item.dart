import 'package:flutter/material.dart';

import '../../../../core/app theme/app_colors.dart';

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
      dense: true,
      title: Text(title),
      subtitle: Text(
        address,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: PopupMenuButton<MenuOptions>(
        color: AppColors.white,
        itemBuilder: (context) {
          return [
            const PopupMenuItem(
              value: MenuOptions.update,
              child: Row(
                children: [
                  Icon(Icons.edit),
                  Text('Update'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: MenuOptions.delete,
              child: Row(
                children: [
                  Icon(Icons.delete, color: AppColors.red),
                  Text(
                    'Delete',
                    style: TextStyle(color: AppColors.red),
                  ),
                ],
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
