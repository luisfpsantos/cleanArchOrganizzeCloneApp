import 'package:flutter/material.dart';

class AccountAddModalBottom extends StatelessWidget {
  final Widget child;
  const AccountAddModalBottom({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height - 50,
        minHeight: MediaQuery.of(context).size.height - 50,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Stack(
                children: const [
                  Align(
                    alignment: Alignment.topLeft,
                    child: BackButton(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Criar conta',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 1.5,
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: child,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 50),
            child: FloatingActionButton(
              child: const Icon(Icons.check),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
