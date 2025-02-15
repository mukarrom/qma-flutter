import 'package:flutter/material.dart';
import 'package:qma/features/dashboard/ui/widgets/main_sidebar_header.dart';
import 'package:qma/features/sidebar/data/data/nav_item_data.dart';
import 'package:qma/features/sidebar/data/model/nav_item_model.dart';
import 'package:qma/features/sidebar/ui/widgets/nav_item_tile.dart';

class MainSidebar extends StatelessWidget {
  const MainSidebar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            const MainSidebarHeader(),
            for (NavItemModel item in NavItemData.navList)
              item.path != null
                  ? NavItemTile(
                      path: item.path!,
                      itemName: item.name,
                      icon: item.icon,
                    )
                  : ExpansionTile(
                      title: Text(item.name),
                      leading: Icon(item.icon),
                      backgroundColor: Colors.transparent,
                      childrenPadding: const EdgeInsets.only(left: 20),
                      subtitle: const Text("Click to view more"),
                      children: [
                        for (NavItemModel child in item.children)
                          NavItemTile(
                            path: child.path!,
                            itemName: child.name,
                            icon: child.icon,
                          ),
                      ],
                    ),
          ],
        ),
      ),
    );
  }
}
