import 'package:flutter/material.dart';

class AccountCardWidget extends StatelessWidget {
  final Widget icon;
  final Widget title;
  final String currentBalance;
  final void Function() onTap;

  const AccountCardWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.currentBalance,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16),
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
            trailing: const Icon(Icons.arrow_forward_ios),
            contentPadding: const EdgeInsets.all(0),
            onTap: onTap,
          ),
          const Divider(
            thickness: 1,
          ),
          Text(
            'Saldo atual R\$ $currentBalance',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          )
        ],
      ),
    );
  }
}
