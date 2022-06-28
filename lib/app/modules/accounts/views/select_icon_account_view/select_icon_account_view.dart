import 'package:flutter/material.dart';

class SelectIconAccountView extends StatefulWidget {
  static const String routeName = '/selectIconAccount';
  const SelectIconAccountView({Key? key}) : super(key: key);

  @override
  State<SelectIconAccountView> createState() => _SelectIconAccountViewState();
}

class _SelectIconAccountViewState extends State<SelectIconAccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Selecione um icone',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
    );
  }
}
