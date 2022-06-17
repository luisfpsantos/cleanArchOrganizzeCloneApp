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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 242, 245),
      appBar: AppBar(
        title: const Text('Contas'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {},
      ),
    );
  }
}
