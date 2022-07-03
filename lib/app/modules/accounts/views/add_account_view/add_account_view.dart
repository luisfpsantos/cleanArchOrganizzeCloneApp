import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/icon_entity.dart';
import 'package:organizze_app/app/modules/accounts/views/add_account_view/add_account_view_bloc/add_account_view_bloc.dart';
import 'package:organizze_app/app/modules/accounts/views/add_account_view/add_account_view_bloc/add_account_view_events.dart';
import 'package:organizze_app/app/modules/accounts/views/add_account_view/add_account_view_bloc/add_account_view_states.dart';
import 'package:organizze_app/app/modules/accounts/views/select_icon_account_view/select_icon_account_view.dart';
import 'package:organizze_app/app/modules/login/domain/entities/user_entity.dart';

class AddAccountView extends StatefulWidget {
  static const String routName = '/addAccount';
  final UserEntity loggedUser;
  const AddAccountView({Key? key, required this.loggedUser}) : super(key: key);

  @override
  State<AddAccountView> createState() => _AddAccountViewState();
}

class _AddAccountViewState extends State<AddAccountView> {
  Widget icon = const Icon(Icons.add, size: 50);
  String iconName = 'Selecione um icone';
  IconEntity? iconEntity;
  late final AddAccountViewBloc _bloc;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = context.read<AddAccountViewBloc>();
    _bloc.add(RemoveError());
  }

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
                          fontSize: 20,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nome da conta',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[800],
                      ),
                    ),
                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Digite o nome da conta',
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'Icone da conta',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        primary: Colors.grey[600],
                      ),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        final result = await Navigator.pushNamed(
                          context,
                          SelectIconAccountView.routeName,
                        );
                        if (result is IconEntity) {
                          iconEntity = result;
                          setState(() {
                            icon = Image.asset(
                              result.path,
                              scale: 10,
                            );
                            iconName = result.name.replaceAll('.png', '');
                          });
                        }
                      },
                      child: Row(
                        children: [
                          icon,
                          const SizedBox(width: 10),
                          Text(iconName),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          BlocListener<AddAccountViewBloc, AddAccountViewStates>(
            bloc: _bloc,
            listener: (_, state) {
              if (state is AddAccountSuccess) {
                Future.delayed(const Duration(milliseconds: 500)).then(
                  (_) => Navigator.pop(context, true),
                );
              }
            },
            child: BlocBuilder<AddAccountViewBloc, AddAccountViewStates>(
              bloc: _bloc,
              builder: (context, state) {
                if (state is AddAccountLoading) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 50),
                    child: SizedBox(
                      height: 70,
                      width: 70,
                      child: FloatingActionButton(
                        onPressed: () {},
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }

                if (state is OnAddAccountError) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 15),
                        child: SizedBox(
                          height: 70,
                          width: 70,
                          child: FloatingActionButton(
                            onPressed: () {
                              _bloc.add(
                                AddAccount(
                                  AccountEntity(
                                    id: '',
                                    balance: 0,
                                    name: _controller.text,
                                    icon: iconEntity ??
                                        IconEntity(name: '', path: ''),
                                  ),
                                  widget.loggedUser.userId,
                                ),
                              );
                            },
                            child: const Icon(Icons.check),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 35),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 247, 122, 113),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          state.msg,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 50),
                  child: SizedBox(
                    height: 70,
                    width: 70,
                    child: FloatingActionButton(
                      onPressed: () {
                        _bloc.add(
                          AddAccount(
                            AccountEntity(
                              id: '',
                              balance: 0,
                              name: _controller.text,
                              icon:
                                  iconEntity ?? IconEntity(name: '', path: ''),
                            ),
                            widget.loggedUser.userId,
                          ),
                        );
                      },
                      child: const Icon(Icons.check),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
