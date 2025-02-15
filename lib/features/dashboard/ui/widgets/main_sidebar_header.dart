import 'package:flutter/material.dart';

class MainSidebarHeader extends StatelessWidget {
  const MainSidebarHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const DrawerHeader(
      child: Column(
        children: [
          //  Add a circular profile picture with size 80x80
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              "https://images.pexels.com/photos/14589344/pexels-photo-14589344.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
            ),
          ),
          Text(
            "মোকাররম হোসাইন",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            "mukarrom@qma.com",
            style: TextStyle(
              // color: Colors.green,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
