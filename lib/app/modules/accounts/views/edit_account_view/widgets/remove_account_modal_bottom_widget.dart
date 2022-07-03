import 'package:flutter/material.dart';

class RemoveAccountModalBottomWidget extends StatelessWidget {
  final void Function() onRemove;
  const RemoveAccountModalBottomWidget({Key? key, required this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.red,
            ),
            child: const Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 32,
            ),
          ),
          const Text(
            'Você tem certeza que deseja\nRemover esta conta?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red[300],
                ),
                onPressed: onRemove,
                child: const Text(
                  'Remover',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
