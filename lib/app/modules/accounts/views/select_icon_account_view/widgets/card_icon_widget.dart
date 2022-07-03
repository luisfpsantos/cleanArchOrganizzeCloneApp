import 'package:flutter/material.dart';

class CardIconWidget extends StatelessWidget {
  final Widget icon;
  final Widget title;
  final void Function() onTap;

  const CardIconWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: icon,
            title: title,
            contentPadding: const EdgeInsets.all(0),
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
