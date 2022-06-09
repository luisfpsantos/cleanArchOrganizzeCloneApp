import 'package:flutter/material.dart';

class AddAccountsView extends StatefulWidget {
  static const String routName = '/addAccounts';
  const AddAccountsView({Key? key}) : super(key: key);

  @override
  State<AddAccountsView> createState() => _AddAccountsViewState();
}

class _AddAccountsViewState extends State<AddAccountsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
